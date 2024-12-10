package fr.n7.hagimule.client.gui;

import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

import fr.n7.hagimule.client.Client;

public class MainWindow extends JFrame {

    private final Client client;
    private DiaryPanel diaryPanel;
    private DownloaderPanel downloaderPanel;
    private DownloadTaskPanel downloadTaskPanel;

    public MainWindow(Client client) {
        super("HagiMule Client");
        this.client = client;
        this.setSize(800, 600);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setVisible(true);

        this.setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));

        this.diaryPanel = new DiaryPanel(this.client.getDownloader());
        this.downloaderPanel = new DownloaderPanel(this.client.getDownloader());
        this.downloadTaskPanel = new DownloadTaskPanel(this.client.getDownloader());

        JPanel topPanel = new JPanel();
        topPanel.setLayout(new BoxLayout(topPanel, BoxLayout.X_AXIS));
        topPanel.add(this.diaryPanel);
        topPanel.add(this.downloaderPanel);
        this.add(topPanel);

        this.add(this.downloadTaskPanel);
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