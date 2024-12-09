package fr.n7.hagimule.client.gui;

import javax.swing.JPanel;

import fr.n7.hagimule.client.daemon.Daemon;

public class DaemonPanel extends JPanel {

    private Daemon daemon;

    public DaemonPanel(Daemon daemon) {
        super();
        this.daemon = daemon;
    }
}