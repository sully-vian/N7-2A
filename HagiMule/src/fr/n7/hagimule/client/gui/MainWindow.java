package fr.n7.hagimule.client.gui;

import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

import fr.n7.hagimule.client.Client;

/**
 * Fenêtre principale de l'application.
 */
public class MainWindow extends JFrame {

    public static final int REFRESH_DELAY = 100; // ms

    private final Client client;
    private DiaryPanel diaryPanel;
    private DownloaderPanel downloaderPanel;
    private DownloadTaskPanel downloadTaskPanel;
    private DaemonPanel daemonPanel;

    public MainWindow(Client client) {
        super("HagiMule Client");
        this.client = client;
        this.setSize(1000, 450);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.setVisible(true);

        this.setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));

        this.diaryPanel = new DiaryPanel(this.client.getDownloader(), this.client.getDaemon());
        this.downloaderPanel = new DownloaderPanel(this.client.getDownloader());
        this.daemonPanel = new DaemonPanel(this.client.getDaemon());
        this.downloadTaskPanel = new DownloadTaskPanel(this.client.getDownloader());

        JPanel topPanel = new JPanel();
        topPanel.setLayout(new BoxLayout(topPanel, BoxLayout.X_AXIS));
        topPanel.add(this.diaryPanel);
        topPanel.add(this.daemonPanel);
        topPanel.add(this.downloaderPanel);
        this.add(topPanel);

        this.add(this.downloadTaskPanel);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(new Runnable() {
            @Override
            public void run() {
                Client client = new Client();
                // pas d'interface si arg
                if (args.length == 0) {
                    new MainWindow(client).setVisible(true);
                }
                client.getDaemon().start();
                ;
            }
        });
    }
}