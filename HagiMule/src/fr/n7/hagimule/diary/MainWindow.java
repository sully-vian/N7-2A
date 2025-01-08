package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.Timer;

import fr.n7.hagimule.Host;

public class MainWindow extends JFrame {

    public static final int REFRESH_DELAY = 100; // ms
    private final Diary diary;
    private DefaultListModel<String> fileListModel;
    private JList<String> fileJList;

    public MainWindow(Diary diary) {
        super("HagiMule Diary");
        this.diary = diary;
        this.setSize(800, 600);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.setVisible(true);

        this.fileListModel = new DefaultListModel<>();
        this.fileJList = new JList<>(this.fileListModel);

        this.add(this.fileJList);

        Timer refreshTimer = new Timer(MainWindow.REFRESH_DELAY, e -> this.updateContents());
        refreshTimer.start();
        this.fileJList.setBorder(BorderFactory.createTitledBorder("Known Files"));
    }

    private void updateContents() {
        try {
            List<String> contentList = new ArrayList<>();
            String[] fileNames = diary.getFileNames().toArray(new String[0]);
            Arrays.sort(fileNames);
            for (String fileName : fileNames) {
                long fileSize = diary.getFileSize(fileName);
                Set<Host> hosts = diary.getHosts(fileName);
                contentList.add(fileName + " (" + fileSize + "): " + hosts);
            }
            this.fileListModel.clear();
            for (String file : contentList) {
                this.fileListModel.addElement(file);
            }
        } catch (RemoteException e) {
            System.err.println("Error while fetching diary contents: " + e.getMessage());
        }
    }
}
