package fr.n7.hagimule.client.gui;

import java.awt.event.ActionEvent;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.downloader.Downloader;

/**
 * Panneau d'affichage pour se connecter à un {@link Diary}.
 */
public class DiaryPanel extends JPanel {

    private Downloader downloader;

    private JTextField hostAddressField;
    private JTextField hostPortField;
    private JButton connectButton;

    public DiaryPanel(Downloader downloader) {
        super();
        this.downloader = downloader;
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
        this.updatePanelTitle();
    }

    private void updatePanelTitle() {
        this.setBorder(BorderFactory.createTitledBorder("Diary " +
                (downloader.IsDiaryConnected() ? "(connected)" : "(disconnected)")));
    }
}