package fr.n7.hagimule.client.downloader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.rmi.RemoteException;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.Utils;
import fr.n7.hagimule.client.ClientDiary;

/**
 * Classe responsable du téléchargement d'un fichier.
 * <p>
 * C'est ici que sont créés les {@link DownloaderSlave}.
 */
public class DownloadTask extends Thread {

    private Downloader downloader;
    private final String fileName;
    private int fileSize;
    private byte[] fileBytes;

    private Host[] hosts;

    /**
     * Crée une nouvelle tâche de téléchargement. et récupère les hôtes ayant le
     * fichier donné.
     *
     * @param downloader le téléchargeur à notifier quand la tâche est terminée.
     * @param fileName   le nom du fichier à télécharger.
     */
    public DownloadTask(Downloader downloader, String fileName) {
        super("Downloading " + fileName);
        this.downloader = downloader;
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
        long startTime = System.nanoTime();

        this.fileBytes = new byte[(int) this.fileSize];

        int fragmentSize = this.fileSize / this.hosts.length;
        int remainder = this.fileSize % this.hosts.length;
        int lastFragmentSize = fragmentSize + remainder;

        DownloaderSlave[] slaves = new DownloaderSlave[this.hosts.length];

        for (int i = 0; i < this.hosts.length; i++) {
            Host host = this.hosts[i];
            int fragmentStart = i * fragmentSize;
            int fragmentLength = (i == this.hosts.length - 1) ? lastFragmentSize : fragmentSize;
            slaves[i] = new DownloaderSlave(this, host, fileName, fragmentStart, fragmentLength);
            slaves[i].start(); // récupère et écrit le fragment dans l'attribut fileBytes
        }

        // wait for threads to finish
        for (DownloaderSlave slave : slaves) {
            try {
                slave.join();
            } catch (InterruptedException e) {
                System.err.println("DownloadTask: Error when waiting for slave: " + e.toString());
            }
        }

        this.writeToFile();
        this.downloader.taskFinished(this);
        System.out.println("DownloadTask: Finished writing to file.");

        long duration = System.nanoTime() - startTime;
        this.printStats(duration);
    }

    private void printStats(long duration) {
        double rate = this.fileSize / (duration / 1e9);
        double durationSeconds = duration / 1e9;
        durationSeconds = Math.round(durationSeconds * 100.0) / 100.0;
        System.out.println("DownloadTask: downloaded " +
                Utils.byteToUnit(this.fileSize) + " in " + (duration / 1e6) +
                " ms (" + Utils.byteToUnit((int) rate) + "/s)");
    }

    /**
     * Récupère sur le serveur les hôtes ayant le fichier de nom donné.
     */
    public void fetchHosts() {
        try {
            ClientDiary diary = this.downloader.getClient().getDiary();
            this.hosts = diary.getFileInfo(this.fileName).getHosts().toArray(new Host[0]);
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
            ClientDiary diary = this.downloader.getClient().getDiary();
            this.fileSize = diary.getFileInfo(this.fileName).getSize();
        } catch (RemoteException e) {
            System.err.println("DownloadTask: Error when fetching "
                    + this.fileName + "size: " + e.toString());
        }
    }

    public synchronized void writeFragment(byte[] fragment, int start) {
        System.arraycopy(fragment, 0, this.fileBytes, start, fragment.length);
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