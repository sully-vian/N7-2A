package fr.n7.hagimule.client.gui;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JPanel;

import fr.n7.hagimule.client.daemon.Daemon;

public class DaemonPanel extends JPanel {
    private Daemon daemon;
    private JButton postFilesButton;
    private JButton removeHostButton;

    public DaemonPanel(Daemon daemon) {
        super();
        this.daemon = daemon;

        this.setBorder(BorderFactory.createTitledBorder("Daemon"));

        this.postFilesButton = new JButton("Post files");
        this.postFilesButton.addActionListener(e -> this.daemon.postFiles());
        this.add(this.postFilesButton);

        this.removeHostButton = new JButton("Remove host");
        this.removeHostButton.addActionListener(e -> this.daemon.removeHost());
        this.add(this.removeHostButton);
    }
}
