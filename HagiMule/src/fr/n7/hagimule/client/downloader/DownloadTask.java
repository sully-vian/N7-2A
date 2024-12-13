package fr.n7.hagimule.client.downloader;

import java.rmi.RemoteException;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Classe responsable du téléchargement d'un fichier.
 * <p>
 * C'est ici que sont créés les {@link DownloaderSlave}.
 */
public class DownloadTask extends Thread {

    private Downloader downloader;
    private final Diary diary;
    private final String fileName;
    private int fileSize;

    private Host[] hosts;
    private DownloaderSlave[] slaves;
    private byte[][] fragments;

    /**
     * Crée une nouvelle tâche de téléchargement. et récupère les hôtes ayant le
     * fichier donné.
     *
     * @param downloader le téléchargeur à notifier quand la tâche est terminée
     * @param diary      l'annuaire
     * @param fileName   le nom du fichier à télécharger
     */
    public DownloadTask(Downloader downloader, Diary diary, String fileName) {
        super("Downloading " + fileName);
        this.downloader = downloader;
        this.diary = diary;
        this.fileName = fileName;
        this.fetchHosts();
        this.fetchSize();
        this.fragments = new byte[this.hosts.length][];
    }

    /**
     * Retourne le nom du fichier à télécharger.
     *
     * @return le nom du fichier à télécharger.
     */
    public String getFileName() {
        return this.fileName;
    }

    @Override
    public void run() {
        this.slaves = new DownloaderSlave[this.hosts.length];

        // start all the slaves
        for (int i = 0; i < this.hosts.length; i++) {
            this.slaves[i] = new DownloaderSlave(this.fileName, this.fileSize, this.hosts[i], this.hosts.length, i);
            this.slaves[i].start();
            // System.out.println("DownloaderSlave started");
        }
        System.out.println("DownloaderTask started for " + this.fileName + " with " + this.hosts.length + " slaves");

        // wait for all the slaves to finish
        for (Thread slave : slaves) {
            try {
                slave.join();
            } catch (InterruptedException e) {
                System.err.println("Erreur lors de l'attente de la fin d'un DownloaderSlave: " + e.toString());
            }
        }

        System.out.println("DownloaderTask finished for " + this.fileName + " with " + this.hosts.length + " slaves");
        this.downloader.taskFinished(this);

        this.joinFragments();
    }

    /**
     * Récupère sur le serveur les hôtes ayant le fichier de nom donné.
     */
    public void fetchHosts() {
        try {
            this.hosts = this.diary.getHosts(this.fileName).toArray(new Host[0]);
        } catch (Exception e) {
            System.err.println(
                    "Error when fetching the hosts for " + this.fileName + ": " + e.toString());
        }
    }

    /**
     * Récupère sur le serveur la taille (en octets) du fichier de nom donné.
     */
    public void fetchSize() {
        try {
            this.fileSize = this.diary.getFileSize(this.fileName);
        } catch (RemoteException e) {
            System.err.println("Error when fetching " + this.fileName + "size: " + e.toString());
        }
    }

    @Override
    public String toString() {
        return this.getName() + " (" + this.hosts.length + " hosts)";
    }

    /**
     * Joint les fragments des esclaves
     */
    private void joinFragments() {
        for (int i = 0; i < this.slaves.length; i++) {
            this.fragments[i] = this.slaves[i].getFragment();
        }
    }
}