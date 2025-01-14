package fr.n7.hagimule.diary;

import java.awt.BorderLayout;
import java.rmi.RemoteException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JScrollPane;
import javax.swing.Timer;

public class MainWindow extends JFrame {

    public static final int REFRESH_DELAY = 100; // ms
    private final ServerDiary diary;
    private DefaultListModel<String> fileListModel;
    private JList<String> fileList;
    private Set<String> previousFiles;

    public MainWindow(ServerDiary diary) {
        super("HagiMule Diary");
        this.diary = diary;
        this.fileListModel = new DefaultListModel<>();
        this.fileList = new JList<>(this.fileListModel);
        this.previousFiles = new HashSet<>();

        this.setSize(800, 600);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.setVisible(true);

        this.fileList.setBorder(BorderFactory.createTitledBorder("Known Files"));

        this.add(new JScrollPane(this.fileList), BorderLayout.CENTER);

        Timer refreshTimer = new Timer(MainWindow.REFRESH_DELAY, e -> this.updateContents());
        refreshTimer.start();
    }

    /** Met à jour l'affichage de la liste des fichiers répertoriés. */
    private void updateContents() {
        try {
            // la liste crée est immutable, donc pas de tri possible
            final List<String> currentContents = this.diary.getContents().values()
                    // collect parce que toList est depuis Java 16
                    .stream().map(FileInfo::toString).collect(Collectors.toList());

            // ajouter les nouveaux fichiers
            for (String fileString : currentContents) {
                // ajouter le fichier s'il n'était pas déjà dans la liste
                if (!this.previousFiles.contains(fileString)) {
                    this.fileListModel.addElement(fileString);
                }
            }

            // retirer les anciens fichiers
            for (String fileString : this.previousFiles) {
                // retirer le fichier s'il n'est plus dans la liste actuelle
                if (!currentContents.contains(fileString)) {
                    this.fileListModel.removeElement(fileString);
                }
            }

            // remplacer les fichiers précédents par les actuels
            this.previousFiles = new HashSet<>(currentContents);
        } catch (RemoteException e) {
            System.err.println("Diary MainWindow: Error while fetching diary contents: " + e.getMessage());
        }
    }
}
