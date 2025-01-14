package fr.n7.hagimule.client.daemon;

import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardWatchEventKinds;
import java.nio.file.WatchEvent;
import java.nio.file.WatchKey;
import java.nio.file.WatchService;
import java.rmi.RemoteException;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.Utils;
import fr.n7.hagimule.client.Client;
import fr.n7.hagimule.diary.FileInfo;

/**
 * Sur chaque client.
 * <p>
 * Permet le téléchargement de fragments depuis un autre client.
 * <p>
 * Accessible avec des sockets TCP.
 */
public class Daemon extends Thread {

    public static final String STORAGE_PATH = "storage/uploads/";

    private final Host myHost;
    private ServerSocket serverSocket;
    private Client client;

    public Daemon(Client client) {
        super();
        this.client = client;
        this.myHost = new Host(Utils.getLocalIPAddress(), client.getDaemonPort());
    }

    /** Ajoute les fichiers du dossier de stockage à l'annuaire */
    public void postFiles() {
        if (this.client.getDiary() == null) {
            System.err.println("Daemon: Diary not connected, cannot add files.");
            return;
        }
        File[] files = new File(STORAGE_PATH).listFiles();
        int addedFiles = 0;

        for (File file : files) {
            String fileName = file.getName();
            long size = file.length();
            try {
                FileInfo fileInfo = new FileInfo(fileName, size, this.myHost);
                this.client.getDiary().addFileInfo(fileInfo, myHost);
                addedFiles++;
            } catch (RemoteException e) {
                System.err.println("Daemon: Could not add \"" + fileName + "\" to diary.");
            }
        }
        System.out.println("Daemon: Posted " + addedFiles + "/" + files.length + " files to diary");
    }

    /** Retire l'hôte de l'annuaire */
    public void removeHost() {
        if (this.client.getDiary() == null) {
            System.err.println("Daemon: Diary not connected, cannot remove host.");
            return;
        }
        try {
            this.client.getDiary().removeHost(myHost);
            System.out.println("Daemon: Removed host from diary.");
        } catch (RemoteException e) {
            System.err.println("Daemon: Could not remove host from diary.");
        }
    }

    public void syncFiles() {
        if (this.client.getDiary() == null) {
            System.err.println("Daemon: Diary not connected, cannot sync files.");
            return;
        }

        try {
            // retirer tous les fichiers que je serv(ai)s
            this.client.getDiary().removeHost(myHost);

            File[] localFiles = new File(STORAGE_PATH).listFiles();
            int numSyncedFiles = 0;

            // ajouter tous les fichiers que j'héberge
            for (File file : localFiles) {
                FileInfo fileInfo = new FileInfo(file);
                this.client.getDiary().addFileInfo(fileInfo, myHost);
                numSyncedFiles++;
            }
            System.out.println("Daemon: Synced " + numSyncedFiles + " files.");
        } catch (Exception e) {

            System.err.println("Daemon: Could not sync files with diary.");
        }
    }

    @Override
    public void run() {
        System.out.println("Daemon: started on " + this.myHost);

        // setup avec l'annuaire
        new Thread(this::watchFiles).start();
        new Thread(this::notifyDiary).start();

        try {
            this.serverSocket = new ServerSocket(this.myHost.getPort());
            while (true) {
                Socket clientSocket = this.serverSocket.accept();
                Thread slave = new DaemonSlave(clientSocket);
                System.out.println("Daemon: Accepted connection from " + clientSocket.getRemoteSocketAddress());
                slave.start();
            }
        } catch (IOException e) {
            System.err.println("Daemon: Error in server socket.");
            e.printStackTrace();
        }
    }

    private void notifyDiary() {
        try {
            while (true) {
                Thread.sleep(1000);
                if (this.client.isDiaryConnected()) {
                    this.client.getDiary().resetHostTimer(myHost);
                }
            }
        } catch (InterruptedException e) {
            System.err.println("Daemon: Error when sleeping.");
        } catch (RemoteException e) {
            System.err.println("Daemon: Error when updating host timer.");
        }
    }

    private void watchFiles() {
        try {
            WatchService watcher = FileSystems.getDefault().newWatchService();

            Path pathToWatch = Paths.get(STORAGE_PATH);
            pathToWatch.register(watcher,
                    StandardWatchEventKinds.ENTRY_CREATE,
                    StandardWatchEventKinds.ENTRY_DELETE,
                    StandardWatchEventKinds.ENTRY_MODIFY);

            while (true) {
                WatchKey key = watcher.take();
                for (WatchEvent<?> event : key.pollEvents()) {
                    if (event.kind() == StandardWatchEventKinds.OVERFLOW) {
                        continue;
                    }
                    this.syncFiles();
                    WatchEvent.Kind<?> kind = event.kind();
                    Path path = (Path) event.context();
                    System.out.println("Daemon: " + kind + " " + path);
                }
                key.reset();
            }
        } catch (Exception e) {

            System.err.println("Daemon: Error when watching uploads directory.");
        }
    }
}