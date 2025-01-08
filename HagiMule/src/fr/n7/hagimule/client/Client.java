package fr.n7.hagimule.client;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import javax.swing.SwingUtilities;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.daemon.Daemon;
import fr.n7.hagimule.client.downloader.Downloader;
import fr.n7.hagimule.client.gui.MainWindow;
import fr.n7.hagimule.diary.Diary;
import fr.n7.hagimule.diary.DiaryServer;

/**
 * Client principal.
 */
public class Client {
    private Downloader downloader;
    private Daemon daemon;
    private Host diaryHost;
    private Diary diary;

    private static final String USAGE = "\n\tUsage: java -cp bin fr.n7.hagimule.client.Client <diary_ip> (optional)\n\n"
            + "\tIf no argument is provided, " +
            "the client will run in GUI mode in which you\n\tcan provide an IO address to connect to the diary server.\n";

    public Client(Host diaryHost) {
        this.downloader = new Downloader(this);
        this.daemon = new Daemon(this);
        this.diaryHost = diaryHost;
    }

    public Downloader getDownloader() {
        return this.downloader;
    }

    public Daemon getDaemon() {
        return this.daemon;
    }

    public Diary getDiary() {
        return this.diary;
    }

    public void setDiaryHost(Host diaryHost) {
        this.diaryHost = diaryHost;
    }

    public void fetchDiary() {
        String diaryHostAddress = this.diaryHost.getAddress();
        int diaryHostPort = this.diaryHost.getPort();
        try {
            Registry registry = LocateRegistry.getRegistry(diaryHostAddress, diaryHostPort);
            this.diary = (Diary) registry.lookup(DiaryServer.BINDING_NAME);
            System.out.println("Client: Connected to diary");
        } catch (NotBoundException e) {
            System.err.println("Client: Error when fetching diary: " + e.toString());
        } catch (RemoteException e) {
            System.err.println("Client: Error when fetching diary: " + e.toString());
        }
    }

    public boolean isDiaryConnected() {
        return this.diary != null;
    }

    public static void main(String[] args) throws RemoteException {
        Host diaryHost;

        if (args.length == 0) {
            diaryHost = new Host("localhost", DiaryServer.PORT);
        } else if (args.length == 1) {
            diaryHost = new Host(args[0], DiaryServer.PORT);
        } else {
            System.err.println(USAGE);
            System.exit(1);
            return;
        }
        final Client client = new Client(diaryHost);

        if (args.length == 1) {
            // en mode serveur, on ne peut que servir des fichiers
            client.fetchDiary();
            client.daemon.start();
        } else {
            // en mode avec interface graphique
            client.daemon.start();
            SwingUtilities.invokeLater(() -> {
                MainWindow window = new MainWindow(client);
                window.setVisible(true);
            });
        }
    }
}