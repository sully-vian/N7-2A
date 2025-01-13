package fr.n7.hagimule.client.daemon;

import java.io.File;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
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
        System.out.println("Daemon: Created on " + this.myHost);
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

    @Override
    public void run() {
        try {
            this.serverSocket = new ServerSocket(this.myHost.getPort());
            System.out.println("Daemon: started on port " + this.myHost.getPort());

            while (true) {
                Socket clientSocket = this.serverSocket.accept();
                Thread slave = new DaemonSlave(clientSocket);
                slave.start();
            }
        } catch (IOException e) {
            System.err.println("Daemon: Error in server socket.");
            e.printStackTrace();
        }
    }
}