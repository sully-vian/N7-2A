package fr.n7.hagimule.client.daemon;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;
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

    private final Host myHost;
    private ServerSocket serverSocket;
    private Diary diary;

    public Daemon(int port) {
        super();
        this.myHost = new Host("localhost", port);
    }

    /** Récupère l'annuaire depuis le serveur */
    public void fetchDiary(Host diaryHost) {
        try {
            Registry reg = LocateRegistry.getRegistry(diaryHost.getName(), diaryHost.getPort());
            this.diary = (Diary) reg.lookup("Diary");
            System.out.println("Daemon: Diary connected");
        } catch (RemoteException | NotBoundException e) {
            System.err.println("Daemon: Error when fetching diary: " + e.toString());
        }
    }

    /** Ajoute les fichiers du dossier de stockage à l'annuaire */
    public void postFiles() {
        if (this.diary == null) {
            System.err.println("Daemon: Diary not connected, cannot add files.");
            return;
        }
        File[] files = new File(STORAGE_PATH).listFiles();
        for (File file : files) {
            String name = file.getName();
            long size = file.length();
            try {
                this.diary.addFile(name, size, this.myHost);
            } catch (DuplicateFileNameException e) {
                System.err.println("Daemon: Diary already has \"" + name + "\" with different size.");
            } catch (RemoteException e) {
                System.err.println("Daemon: Could not add \"" + name + "\" to diary.");
            }
        }
    }

    /** Retire l'hôte de l'annuaire */
    public void removeHost() {
        if (this.diary == null) {
            System.err.println("Daemon: Diary not connected, cannot remove host.");
            return;
        }
        try {
            this.diary.removeHost(myHost);
        } catch (RemoteException e) {
            System.err.println("Daemon: Could not remove host from diary.");
        }
    }

    public boolean IsDiaryConnected() {
        return this.diary != null;
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