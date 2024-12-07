package fr.n7.hagimule.client.downloader;

/**
 * Sur les clients.
 * <p>
 * Permet de télécharger en parallèle des fichiers.
 */
public class Downloader extends Thread {

    private int numFragments = 1;
    private String fileName;
    private String host;
    private int port;

    public Downloader(String fileName, String host, int port) {
        super();
        this.fileName = fileName;
        this.host = host;
        this.port = port;
    }

    @Override
    public void run() {
        DownloaderSlave slave = new DownloaderSlave(this.fileName, this.host, this.port, this.numFragments, 1);
        slave.start();
        System.out.println("DownloaderSlave started");
    }
}