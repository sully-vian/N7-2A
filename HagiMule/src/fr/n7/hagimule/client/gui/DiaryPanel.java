package fr.n7.hagimule.client.gui;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JLabel;
import javax.swing.JPanel;

import fr.n7.hagimule.client.downloader.Downloader;

public class DiaryPanel extends JPanel {

    private Downloader downloader;

    private JLabel diaryHost;
    private JLabel diaryStatus;

    public DiaryPanel(Downloader downloader) {
        super();
        this.downloader = downloader;
        this.setBorder(BorderFactory.createTitledBorder("Diary"));
        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));

        this.diaryHost = new JLabel("Diary host: " + this.downloader.getDiaryHost());
        this.add(this.diaryHost);

        this.diaryStatus = new JLabel("Diary status: " +
                (this.downloader.IsDiaryConnected() ? "connected" : "not connected"));
        this.add(this.diaryStatus);
    }
}