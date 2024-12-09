package fr.n7.hagimule.client.gui;

import java.awt.FlowLayout;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;

import fr.n7.hagimule.client.Client;

public class MainWindow extends JFrame {

    private final Client client;
    private DownloaderPanel downloaderPanel;
    private DaemonPanel daemonPanel;

    public MainWindow(Client client) {
        super("Hagimule");
        this.client = client;
        this.setSize(800, 600);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);

        this.setLayout(new FlowLayout());

        this.downloaderPanel = new DownloaderPanel(this.client.getDownloader());
        this.daemonPanel = new DaemonPanel(this.client.getDaemon());

        this.add(this.downloaderPanel);
        this.add(this.daemonPanel);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                new MainWindow(new Client()).setVisible(true);
            }
        });
    }
}