package fr.n7.hagimule.client.downloader;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.HashSet;
import java.util.Set;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Sur les clients.
 * <p>
 * Permet de télécharger en parallèle des fichiers en créant des
 * {@link DownloadTask} pour chaque fichier.
 */
public class Downloader extends Thread {

    public static final String STORAGE_PATH = "storage/downloads/";

    /** Les noms des fichiers disponibles dans l'annuaire */
    private String[] availableFileNames = new String[0];
    private Set<DownloadTask> currentTasks = new HashSet<>();

    private Registry registry;
    private Host diaryHost;
    private Diary diary;

    /**
     * Crée un nouveau téléchargeur.
     */
    public Downloader() {
        super();
        this.availableFileNames = new String[0];
        this.currentTasks = new HashSet<>();
    }

    public Host getDiaryHost() {
        return this.diaryHost;
    }

    public boolean IsDiaryConnected() {
        return this.diary != null;
    }

    public String[] getAvailableFileNames() {
        return this.availableFileNames;
    }

    public Diary getDiary() {
        return this.diary;
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
        DownloadTask task = new DownloadTask(this, diary, fileName);
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
            this.registry = LocateRegistry.getRegistry(diaryHost.getName(), diaryHost.getPort());
            this.diary = (Diary) this.registry.lookup("Diary");
            System.out.println("Downloader: Diary connected");
        } catch (RemoteException | NotBoundException e) {
            System.err.println("Downloader: Error when fetching diary: " + e.toString());
        }
    }

    public void fetchFileNames() {
        try {
            this.availableFileNames = this.diary.getFileNames().toArray(new String[0]);
            System.out.println("Downloader: File names fetched");
        } catch (RemoteException e) {
            System.err.println("Downloader: Error when fetching fileNames: " + e.toString());
        }
    }
}