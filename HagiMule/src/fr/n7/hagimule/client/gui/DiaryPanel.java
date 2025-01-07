package fr.n7.hagimule.client.gui;

import java.awt.event.ActionEvent;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.daemon.Daemon;
import fr.n7.hagimule.client.downloader.Downloader;

/**
 * Panneau d'affichage pour se connecter à un {@link Diary}.
 */
public class DiaryPanel extends JPanel {

    private Downloader downloader;
    private Daemon daemon;

    private JTextField hostAddressField;
    private JTextField hostPortField;
    private JButton connectButton;

    public DiaryPanel(Downloader downloader, Daemon daemon) {
        super();
        this.downloader = downloader;
        this.daemon = daemon;
        this.updatePanelTitle();

        this.hostAddressField = new JTextField("localhost", 10);
        this.add(this.hostAddressField);

        this.add(new JLabel(":"));

        this.hostPortField = new JTextField("1099");
        this.add(this.hostPortField);

        this.connectButton = new JButton("Connect Diary");
        this.connectButton.addActionListener(this::connectDiary);
        this.add(this.connectButton);
    }

    private void connectDiary(ActionEvent e) {
        String address = this.hostAddressField.getText();
        int port = Integer.parseInt(this.hostPortField.getText());
        this.downloader.fetchDiary(new Host(address, port));
        this.daemon.fetchDiary(new Host(address, port));
        this.updatePanelTitle();
    }

    private void updatePanelTitle() {
        String connectionStatus = "(disconnected)";
        if (this.downloader.IsDiaryConnected() && this.daemon.IsDiaryConnected()) {
            connectionStatus = "(connected)";
        }
        this.setBorder(BorderFactory.createTitledBorder(connectionStatus));
    }
}