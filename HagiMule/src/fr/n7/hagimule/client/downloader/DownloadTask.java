package fr.n7.hagimule.client.downloader;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Classe responsable du téléchargement d'un fichier.
 * <p>
 * C'est ici que sont créés les DownloaderSlave.
 */
public class DownloadTask extends Thread {

    private Downloader downloader;
    private final Diary diary;
    private final String fileName;

    private Host[] hosts;
    private DownloaderSlave[] slaves;

    /**
     * Crée une nouvelle tâche de téléchargement. et récupère les hôtes ayant le
     * fichier donné.
     *
     * @param downloader le téléchargeur à notifier quand la tâche est terminée
     * @param diary    l'annuaire
     * @param fileName le nom du fichier à télécharger
     */
    public DownloadTask(Downloader downloader, Diary diary, String fileName) {
        super("Downloading " + fileName);
        this.downloader = downloader;
        this.diary = diary;
        this.fileName = fileName;
        this.fetchHosts();
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
            this.slaves[i] = new DownloaderSlave(this.fileName, this.hosts[i], this.hosts.length, i);
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
    }

    /**
     * Retourne les hôtes ayant le fichier donné.
     *
     * @return les hôtes ayant le fichier donné.
     */
    public Host[] getHosts() {
        return this.hosts;
    }

    public int getNumHosts() {
        return this.hosts.length;
    }

    /**
     * Récupère sur le serveur les hôtes ayant le fichier donné.
     */
    public void fetchHosts() {
        try {
            this.hosts = this.diary.getHosts(this.fileName).toArray(new Host[0]);
        } catch (Exception e) {
            System.err.println(
                    "Erreur lors de la récupération des hôtes pour le fichier " + this.fileName + ": " + e.toString());
        }
    }

    @Override
    public String toString() {
        return this.getName() + " (" + this.getNumHosts() + " hosts)";
    }
}