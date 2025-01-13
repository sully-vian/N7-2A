package fr.n7.hagimule.client.gui;

import java.awt.event.ActionEvent;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.Timer;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.Client;

/**
 * Panneau d'affichage pour se connecter à un {@link Diary}.
 */
public class DiaryPanel extends JPanel {

    private Client client;

    private JTextField hostAddressField;
    private JTextField hostPortField;
    private JButton connectButton;

    public DiaryPanel(Client client) {
        super();
        this.client = client;
        this.updatePanelTitle();

        this.hostAddressField = new JTextField(this.client.getDiaryHost().getAddress(), 12);
        this.add(this.hostAddressField);

        this.add(new JLabel(":"));

        this.hostPortField = new JTextField(this.client.getDiaryHost().getPort() + "", 4);
        this.add(this.hostPortField);

        this.connectButton = new JButton("Connect Diary");
        this.connectButton.addActionListener(this::connectDiary);
        this.add(this.connectButton);

        Timer refreshTimer = new Timer(MainWindow.REFRESH_DELAY, e -> this.updatePanelTitle());
        refreshTimer.start();
    }

    private void connectDiary(ActionEvent e) {
        String address = this.hostAddressField.getText();
        int port = Integer.parseInt(this.hostPortField.getText());
        this.client.setDiaryHost(new Host(address, port));
        this.client.fetchDiary();
        this.updatePanelTitle();
    }

    private void updatePanelTitle() {
        String connectionStatus = "(disconnected)";
        if (this.client.isDiaryConnected()) {
            connectionStatus = "(connected)";
        }
        this.setBorder(BorderFactory.createTitledBorder(connectionStatus));
    }
}