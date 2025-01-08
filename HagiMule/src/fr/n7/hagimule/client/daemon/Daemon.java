package fr.n7.hagimule.client.daemon;

import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.rmi.RemoteException;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.Client;
import fr.n7.hagimule.diary.DuplicateFileNameException;

/**
 * Sur chaque client.
 * <p>
 * Permet le téléchargement de fragments depuis un autre client.
 * <p>
 * Accessible avec des sockets TCP.
 */
public class Daemon extends Thread {

    public static final String STORAGE_PATH = "storage/uploads/";
    public static final int DAEMON_PORT = 2048;

    private final Host myHost;
    private ServerSocket serverSocket;
    private Client client;

    public Daemon(Client client) {
        super();
        this.client = client;
        this.myHost = new Host("localhost", DAEMON_PORT);
    }

    /** Récupère l'annuaire depuis le serveur */
    public void fetchDiary(Host diaryHost) {
        try {
            this.client.fetchDiary();
        } catch (RemoteException e) {
            System.err.println("Daemon: Error when fetching diary: " + e.toString());
        }
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
                this.client.getDiary().addFile(fileName, size, this.myHost);
                addedFiles++;
            } catch (DuplicateFileNameException e) {
                System.err.println("Daemon: Diary already has \""
                        + fileName + "\" with different size.");
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

    public boolean IsDiaryConnected() {
        return this.client.getDiary() != null;
    }

    @Override
    public void run() {
        try {
            this.serverSocket = new ServerSocket(this.myHost.getPort());
            System.out.println("Daemon: started on port " + this.myHost.getPort());

            while (true) {
                Socket clientSocket = this.serverSocket.accept();
                System.out.println("Daemon: socket connected, starting slave");
                Thread slave = new DaemonSlave(clientSocket);
                slave.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}