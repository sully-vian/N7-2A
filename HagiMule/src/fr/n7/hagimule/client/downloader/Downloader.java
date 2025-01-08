package fr.n7.hagimule.client.downloader;

import java.rmi.RemoteException;
import java.util.HashSet;
import java.util.Set;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.Client;

/**
 * Sur les clients.
 * <p>
 * Permet de télécharger en parallèle des fichiers en créant des
 * {@link DownloadTask} pour chaque fichier.
 */
public class Downloader {

    public static final String STORAGE_PATH = "storage/downloads/";

    /** Les noms des fichiers disponibles dans l'annuaire */
    private String[] availableFileNames = new String[0];
    private Set<DownloadTask> currentTasks = new HashSet<>();

    private Client client;

    /**
     * Crée un nouveau téléchargeur.
     */
    public Downloader(Client client) {
        super();
        this.client = client;
        this.availableFileNames = new String[0];
        this.currentTasks = new HashSet<>();
    }

    public boolean IsDiaryConnected() {
        return this.client.getDiary() != null;
    }

    public String[] getAvailableFileNames() {
        return this.availableFileNames;
    }

    public Set<DownloadTask> getCurrentTasks() {
        return this.currentTasks;
    }

    /**
     * Lance le téléchargement d'un fichier s'il n'est pas déjà en cours.
     *
     * @param fileName le nom du fichier à télécharger
     */
    public void downloadFile(String fileName) {
        if (this.currentTasks.stream().anyMatch(task -> task.getFileName().equals(fileName))) {
            return;
        }
        DownloadTask task = new DownloadTask(this, this.client.getDiary(), fileName);
        task.start();
        this.currentTasks.add(task);
    }

    public void taskFinished(DownloadTask task) {
        this.currentTasks.remove(task);
    }

    /**
     * Récupère l'annuaire depuis le serveur.
     *
     * @return true si l'annuaire a été récupéré, false sinon
     */
    public void fetchDiary(Host diaryHost) {
        try {
            this.client.fetchDiary();
        } catch (RemoteException e) {
            System.err.println("Downloader: Error when fetching diary: " + e.toString());
        }
    }

    public void fetchFileNames() {
        try {
            this.availableFileNames = this.client.getDiary().getFileNames().toArray(new String[0]);
            System.out.println("Downloader: File names fetched");
        } catch (RemoteException e) {
            System.err.println("Downloader: Error when fetching fileNames: " + e.toString());
        }
    }
}