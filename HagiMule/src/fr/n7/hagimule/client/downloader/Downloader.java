package fr.n7.hagimule.client.downloader;

import fr.n7.hagimule.Host;

/**
 * Sur les clients.
 * <p>
 * Permet de télécharger en parallèle des fichiers.
 */
public class Downloader extends Thread {

    private int numFragments = 1;
    private String fileName;
    private Host host;

    public Downloader(String fileName, Host host) {
        super();
        this.fileName = fileName;
        this.host = host;
    }

    @Override
    public void run() {
        DownloaderSlave slave = new DownloaderSlave(this.fileName, this.host, this.numFragments, 1);
        slave.start();
        System.out.println("DownloaderSlave started");
    }
}