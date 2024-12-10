package fr.n7.hagimule.client.gui;

import java.awt.BorderLayout;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.Timer;

import fr.n7.hagimule.client.downloader.DownloadTask;
import fr.n7.hagimule.client.downloader.Downloader;

public class DownloadTaskPanel extends JPanel {

    private Downloader downloader;
    private DefaultListModel<String> taskListModel;
    private JList<String> taskList;
    private Set<String> previousTasks = new HashSet<>();
    private Timer refreshTimer;

    public DownloadTaskPanel(Downloader downloader) {
        super(new BorderLayout());
        this.downloader = downloader;
        this.taskListModel = new DefaultListModel<>();
        this.taskList = new JList<>(this.taskListModel);

        this.setBorder(BorderFactory.createTitledBorder("Current Downloads"));

        this.add(new JScrollPane(this.taskList), BorderLayout.CENTER);

        this.updateTaskList();

        this.refreshTimer = new Timer(100, e -> this.updateTaskList());
        this.refreshTimer.start();
    }

    private void updateTaskList() {
        Set<String> currentTasks = downloader.getCurrentTasks().stream()
                .map(DownloadTask::toString)
                .collect(Collectors.toSet());

        // add new tasks
        for (String taskName : currentTasks) {
            // add task if it's not yet in the list
            if (!this.previousTasks.contains(taskName)) {
                this.taskListModel.addElement(taskName);
            }
        }

        for (String taskName : this.previousTasks) {
            // remove old task if not in the current tasks
            if (!currentTasks.contains(taskName)) {
                taskListModel.removeElement(taskName);
            }
        }

        this.previousTasks = new HashSet<>(currentTasks);

        // this.taskListModel.clear();
        // Set<DownloadTask> tasks = this.downloader.getCurrentTasks();
        // for (DownloadTask task : tasks) {
        //     this.taskListModel.addElement(task.toString());
        // }
    }
}