package fr.n7.hagimule.client.gui;

import java.awt.BorderLayout;
import java.util.List;
import java.util.Set;

import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;

import fr.n7.hagimule.client.downloader.DownloadTask;
import fr.n7.hagimule.client.downloader.Downloader;

public class DownloadTaskPanel extends JPanel {

    private Downloader downloader;
    private DefaultListModel<String> taskListModel;
    private JList<String> taskList;

    public DownloadTaskPanel(Downloader downloader) {
        super(new BorderLayout());
        this.downloader = downloader;
        this.taskListModel = new DefaultListModel<>();
        this.taskList = new JList<>(this.taskListModel);

        this.add(new JScrollPane(this.taskList), BorderLayout.CENTER);
        this.setBorder(BorderFactory.createTitledBorder("Current Downloads"));

        this.updateTaskList();
    }

    private void updateTaskList() {
        this.taskListModel.clear();
        Set<DownloadTask> tasks = this.downloader.getCurrentTasks();
        for (DownloadTask task : tasks) {
            this.taskListModel.addElement(task.getFileName());
        }
    }
}