package fr.n7.hagimule.client.downloader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.Map;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Classe responsable du téléchargement d'un fichier.
 * <p>
 * C'est ici que sont créés les {@link DownloaderSlave}.
 */
public class DownloadTask extends Thread {

    public static final long FRAGMENT_SIZE = 1024; // bytes

    private Downloader downloader;
    private final Diary diary;
    private final String fileName;
    private long fileSize;
    private byte[] fileBytes;

    private Host[] hosts;
    private DownloaderSlave[] slaves;

    /**
     * Crée une nouvelle tâche de téléchargement. et récupère les hôtes ayant le
     * fichier donné.
     *
     * @param downloader le téléchargeur à notifier quand la tâche est terminée.
     * @param diary      l'annuaire.
     * @param fileName   le nom du fichier à télécharger.
     */
    public DownloadTask(Downloader downloader, Diary diary, String fileName) {
        super("Downloading " + fileName);
        this.downloader = downloader;
        this.diary = diary;
        this.fileName = fileName;
        this.fetchHosts();
        this.fetchSize();
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

        // create the slaves
        for (int i = 0; i < this.hosts.length; i++) {
            this.slaves[i] = new DownloaderSlave(this.fileName, this.hosts[i]);
        }
        System.out.println("DownloadTask: started for " +
                this.fileName + " with " + this.hosts.length + " slaves");

        // Attribuer les fragments aux esclaves
        int numFragments = (this.fileSize % FRAGMENT_SIZE == 0)
                ? (int) (this.fileSize / FRAGMENT_SIZE)
                : (int) (this.fileSize / FRAGMENT_SIZE) + 1;
        System.out.println("DownloadTask: " + numFragments + " fragments to download");
        for (int i = 0; i < numFragments; i++) {
            this.slaves[i % this.hosts.length].addFragmentNumero(i);
        }

        // lancer les threads
        for (Thread slave : slaves) {
            slave.start();
        }

        // wait for all the slaves to finish
        for (Thread slave : slaves) {
            try {
                slave.join();
            } catch (InterruptedException e) {
                System.err.println(
                        "DownloadTask: Error while waiting for a DownloaderSlave to finish: "
                                + e.toString());
            }
        }

        System.out.println("DownloadTask: finished for "
                + this.fileName + " with " + this.hosts.length + " slaves");

        this.joinFragments();
        this.writeToFile();
        this.downloader.taskFinished(this);
    }

    /**
     * Récupère sur le serveur les hôtes ayant le fichier de nom donné.
     */
    public void fetchHosts() {
        try {
            this.hosts = this.diary.getHosts(this.fileName).toArray(new Host[0]);
        } catch (Exception e) {
            System.err.println("DownloadTask: Error when fetching the hosts for "
                    + this.fileName + ": " + e.toString());
        }
    }

    /**
     * Récupère sur le serveur la taille (en octets) du fichier de nom donné.
     */
    public void fetchSize() {
        try {
            this.fileSize = this.diary.getFileSize(this.fileName);
        } catch (RemoteException e) {
            System.err.println("DownloadTask: Error when fetching "
                    + this.fileName + "size: " + e.toString());
        }
    }

    private void joinFragments() {
        this.fileBytes = new byte[(int) this.fileSize];
        for (DownloaderSlave slave : slaves) {
            Map<Integer, byte[]> fragmentMap = slave.getFragments();
            for (int fragmentNumero : fragmentMap.keySet()) {
                byte[] fragment = fragmentMap.get(fragmentNumero);
                int start = fragmentNumero * ((int) FRAGMENT_SIZE);
                System.arraycopy(fragment, 0, this.fileBytes, start, this.fileBytes.length - start);
            }
        }
    }

    /** Écrit les octets dans la mémoire. Appeler après {@link #joinFragments} */
    private void writeToFile() {
        File outputFile = new File(Downloader.STORAGE_PATH + this.fileName);
        System.out.println("DownloadTask: Saving to " + outputFile.getPath());

        try (FileOutputStream fos = new FileOutputStream(outputFile)) {
            fos.write(this.fileBytes);
        } catch (IOException e) {
            System.err.println("DownloadTask: Error when saving file: " + e.toString());
        }
    }

    @Override
    public String toString() {
        return this.getName() + " (" + this.hosts.length + " hosts)";
    }
}