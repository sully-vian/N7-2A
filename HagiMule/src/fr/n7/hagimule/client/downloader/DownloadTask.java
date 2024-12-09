package fr.n7.hagimule.client.downloader;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Classe responsable du téléchargement d'un fichier.
 * <p>
 * C'est ici que sont créés les DownloaderSlave.
 */
public class DownloadTask extends Thread {

    private final String fileName;
    private final Diary diary;
    private Host[] hosts;

    /**
     * Crée une nouvelle tâche de téléchargement. et récupère les hôtes ayant le
     * fichier donné.
     *
     * @param diary    l'annuaire
     * @param fileName le nom du fichier à télécharger
     */
    public DownloadTask(Diary diary, String fileName) {
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
        for (int i = 0; i < this.hosts.length; i++) {
            DownloaderSlave slave = new DownloaderSlave(this.fileName, this.hosts[i], this.hosts.length, i);
            slave.start();
            System.out.println("DownloaderSlave started");
        }
        System.out.println("DownloaderTask started for " + this.fileName + " with " + this.hosts.length + " slaves");
    }

    /**
     * Retourne les hôtes ayant le fichier donné.
     *
     * @return les hôtes ayant le fichier donné.
     */
    public Host[] getHosts() {
        return this.hosts;
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
}