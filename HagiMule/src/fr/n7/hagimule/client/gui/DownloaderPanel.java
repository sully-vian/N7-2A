package fr.n7.hagimule.client.gui;

import java.awt.event.ActionEvent;
import java.util.Arrays;

import javax.swing.BorderFactory;
import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;

import fr.n7.hagimule.client.downloader.Downloader;

/**
 * Panneau d'affichage pour choisir le fichier à télécharger.
 */
public class DownloaderPanel extends JPanel {

    private Downloader downloader;

    private JButton reloadButton;
    private JComboBox<String> filesBox;
    private JButton downloadButton;

    public DownloaderPanel(Downloader downloader) {
        super();
        this.downloader = downloader;
        this.setBorder(BorderFactory.createTitledBorder("New Download"));

        this.reloadButton = new JButton("Reload");
        this.reloadButton.addActionListener(this::reloadAvailableFiles);

        this.add(this.reloadButton);

        this.add(new JLabel("Available files:"));

        this.filesBox = new JComboBox<>(this.getStortedFileNames());
        this.add(this.filesBox);

        this.downloadButton = new JButton("Download");
        this.downloadButton.addActionListener(this::downloadSelectedFile);
        this.add(this.downloadButton);
    }

    private String[] getStortedFileNames() {
        String[] fileNames = this.downloader.getAvailableFileNames();
        Arrays.sort(fileNames);
        return fileNames;
    }

    /**
     * Recharge l'affichage des fichiers disponibles.
     *
     * @param e l'événement qui a déclenché l'action
     */
    private void reloadAvailableFiles(ActionEvent e) {
        if (!this.downloader.getClient().isDiaryConnected()) {
            System.out.println("DownloaderPanel: Diary not connected");
            return;
        }
        this.downloader.fetchFileNames();
        String[] fileNames = this.getStortedFileNames();
        this.filesBox.setModel(new DefaultComboBoxModel<>(fileNames));

        System.out.println("Files menu reloaded");
    }

    /**
     * Lance le téléchargement du fichier sélectionné.
     *
     * @param e l'événement qui a déclenché l'action
     */
    private void downloadSelectedFile(ActionEvent e) {
        String fileName = (String) this.filesBox.getSelectedItem();
        if (fileName == null) {
            System.out.println("No file selected");
            return;
        }
        this.downloader.downloadFile(fileName);
    }
}