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

        int acceptedConnections = 0;

        try {
            this.serverSocket = new ServerSocket(this.myHost.getPort());
            while (true) {
                Socket clientSocket = this.serverSocket.accept();
                acceptedConnections++;
                Thread slave = new DaemonSlave(clientSocket);
                System.out.println("Daemon: Accepted connection #" + acceptedConnections);
                slave.start();
            }
        } catch (IOException e) {
            System.err.println("Daemon: Error in server socket in connection #" + acceptedConnections);
            e.printStackTrace();
        }
    }

    /**
     * Notifie l'annuaire pour signaler que le démon est toujours actif.
     */
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

    /**
     * Surveille les fichiers du répertoire {@link #STORAGE_PATH} pour les
     * synchroniser avec l'annuaire en cas de modification.
     */
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