package fr.n7.hagimule.client.downloader;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.rmi.RemoteException;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;

/**
 * Classe responsable du téléchargement d'un fichier.
 * <p>
 * C'est ici que sont créés les {@link DownloaderSlave}.
 */
public class DownloadTask extends Thread {

    /**
     * La taille maximale d'un fragment. Tous les fragments font exactement cette
     * taille, excepté le dernier, qui est plus petit si le fichier n'est pas un
     * multiple de cette taille.
     */
    public static final long MAX_FRAGMENT_SIZE = 1024 * 16; // bytes

    private Downloader downloader;
    private final String fileName;
    private long fileSize;
    private byte[] fileBytes;

    private Host[] hosts;

    private final ExecutorService executor;

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
        this.executor = Executors.newFixedThreadPool(this.hosts.length);
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

        int numFragments = (int) ((this.fileSize + MAX_FRAGMENT_SIZE - 1) / (MAX_FRAGMENT_SIZE));
        System.out.println("DownloadTask: " + numFragments + " fragments to download");

        List<Future<FragmentData>> futures = new LinkedList<>();
        for (int fragmentNumero = 0; fragmentNumero < numFragments; fragmentNumero++) {
            Host host = this.hosts[fragmentNumero % this.hosts.length];
            try {
                Socket socket = new Socket(host.getAddress(), host.getPort());
                Future<FragmentData> future = executor.submit(new DownloaderSlave(fileName, socket, fragmentNumero));
                futures.add(future);
            } catch (IOException e) {
                System.err.println("DownloadTask: Error when connecting to " + host + ": " + e.toString());
            }
        }

        // Attendre que tous les fragments soient téléchargés
        executor.shutdown();
        while (!executor.isTerminated()) {
        }
        System.out.println("DownloadTask: All slaves completed.");

        this.joinFragments(futures);
        this.writeToFile();
        this.downloader.taskFinished(this);
        System.out.println("DownloadTask: Finished writing to file.");

        long endTime = System.nanoTime();
        System.out.println("DownloadTask: Downloaded in " + (endTime - startTime) / 1e6 + "ms");
    }

    /**
     * Récupère sur le serveur les hôtes ayant le fichier de nom donné.
     */
    public void fetchHosts() {
        try {
            Diary diary = this.downloader.getClient().getDiary();
            this.hosts = diary.getHosts(this.fileName).toArray(new Host[0]);
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
            Diary diary = this.downloader.getClient().getDiary();
            this.fileSize = diary.getFileSize(this.fileName);
        } catch (RemoteException e) {
            System.err.println("DownloadTask: Error when fetching "
                    + this.fileName + "size: " + e.toString());
        }
    }

    private void joinFragments(List<Future<FragmentData>> futures) {
        this.fileBytes = new byte[(int) this.fileSize];
        for (Future<FragmentData> future : futures) {
            try {
                int fragmentNumero = future.get().getNumero();
                byte[] fragment = future.get().getData();
                int start = fragmentNumero * (int) MAX_FRAGMENT_SIZE;
                System.arraycopy(fragment, 0, this.fileBytes, start, fragment.length);
            } catch (Exception e) {
                System.err.println("DownloadTask: Error when joining fragments: " + e.toString());
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