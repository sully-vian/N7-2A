package fr.n7.hagimule.client.downloader;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Random;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Sur les clients.
 * <p>
 * Permet de télécharger en parallèle des fichiers en créant des tâches de
 * téléchargement pour chaque fichier.
 */
public class Downloader extends Thread {

    /** Les noms des fichiers disponibles dans l'annuaire */
    private String[] availableFileNames;

    private Registry registry;
    private Host diaryHost;
    private Diary diary;

    /**
     * Crée un nouveau téléchargeur.
     *
     * @param diaryHost
     */
    public Downloader(Host diaryHost) {
        super();
        this.diaryHost = diaryHost;
        this.fetchDiary();
        this.fetchFileNames();
        this.addTestHosts();
    }

    /**
     * Renvoie les noms des fichiers disponibles.
     *
     * @return les noms des fichiers disponibles
     */
    public String[] getAvailableFileNames() {
        return this.availableFileNames;
    }

    public void downloadFile(String fileName) {
        DownloadTask task = new DownloadTask(diary, fileName);
        task.start();
    }

    /**
     * Récupère l'annuaire depuis le serveur.
     */
    public void fetchDiary() {
        try {
            this.registry = LocateRegistry.getRegistry(this.diaryHost.getName(), this.diaryHost.getPort());
            this.diary = (Diary) this.registry.lookup("Diary");
        } catch (RemoteException | NotBoundException e) {
            System.err.println("Error when fetching diary: " + e.toString());
        }
    }

    public void fetchFileNames() {
        try {
            this.availableFileNames = this.diary.getFileNames().toArray(new String[0]);
        } catch (RemoteException e) {
            System.err.println("Error when fetching fileNames: " + e.toString());
        }
    }

    private void addTestHosts() {
        try {
            Random random = new Random();
            for (int i = 0; i < 10; i++) {
                String fileName = "file" + i;
                this.diary.addHost(fileName, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
                this.diary.addHost(fileName, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
                this.diary.addHost(fileName, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
                this.diary.addHost(fileName, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
            }
        } catch (RemoteException e) {
            System.err.println("Error when adding test hosts: " + e.toString());
        }
    }
}