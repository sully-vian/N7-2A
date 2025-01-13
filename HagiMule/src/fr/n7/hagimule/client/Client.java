package fr.n7.hagimule.client;

import java.rmi.ConnectException;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import javax.swing.SwingUtilities;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

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

    private static final int DEFAULT_DAEMON_PORT = 6881;

    private static final String USAGE = "Client [-p <daemon port>] [-d <diary server IP>]";

    private Host diaryHost;
    private int daemonPort;
    private Diary diary;
    private Downloader downloader;
    private Daemon daemon;

    /**
     * Crée un client, son téléchargeur et son démon sur le port spécifié.
     *
     * @param diaryHost
     * @param daemonPort
     */
    public Client(Host diaryHost, int daemonPort) {
        this.diaryHost = diaryHost;
        this.daemonPort = daemonPort;
        this.downloader = new Downloader(this);
        this.daemon = new Daemon(this);
    }

    public Host getDiaryHost() {
        return this.diaryHost;
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

    public int getDaemonPort() {
        return this.daemonPort;
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
            this.daemon.syncFiles();
        } catch (ConnectException e) {
            System.err.println("Client: Could not connect to diary at " + diaryHostAddress + ":" + diaryHostPort);
        } catch (RemoteException e) {
            System.err.println("Client: Error when fetching diary: " + e.toString());
        } catch (NotBoundException e) {
            System.err.println("Client: Error when fetching diary: " + e.toString());
        }
    }

    public boolean isDiaryConnected() {
        if (this.diary == null) {
            return false;
        }
        try {
            this.diary.getContents();
            return true;
        } catch (RemoteException e) {
            return false;
        }
    }

    public static void main(String[] args) throws RemoteException {

        Options options = new Options();
        options.addOption(Option.builder("p")
                .longOpt("port")
                .numberOfArgs(1)
                .type(Integer.class)
                .desc("Port number for the daemon")
                .build());
        options.addOption(Option.builder("d")
                .longOpt("diary")
                .numberOfArgs(1)
                .type(String.class)
                .desc("IP address of the diary server")
                .build());
        options.addOption(Option.builder("g")
                .longOpt("gui")
                .hasArg(false)
                .desc("Run the client with a GUI")
                .build());
        options.addOption(Option.builder("h")
                .longOpt("help")
                .hasArg(false)
                .desc("Show help")
                .build());

        CommandLineParser parser = new DefaultParser();
        HelpFormatter formatter = new HelpFormatter();
        CommandLine cmd = null;

        try {
            cmd = parser.parse(options, args);
        } catch (ParseException e) {
            System.err.println(e.getMessage());
            formatter.printHelp(USAGE, options);
            System.exit(1);
            return;
        }

        if (cmd.hasOption("h")) {
            formatter.printHelp(USAGE, options);
            System.exit(0);
            return;
        }

        int daemonPort = DEFAULT_DAEMON_PORT;
        if (cmd.hasOption("p")) {
            try {
                daemonPort = cmd.getParsedOptionValue("p");
            } catch (ParseException e) {
                System.err.println("Invalid port number: " + cmd.getOptionValue("p"));
                formatter.printHelp(USAGE, options);
                System.exit(1);
            }
        }

        Host diaryHost = new Host("localhost", DiaryServer.PORT);
        if (cmd.hasOption("d")) {
            String diaryIP = cmd.getOptionValue("d");
            diaryHost = new Host(diaryIP, DiaryServer.PORT);
        }

        boolean guiMode = false;
        if (cmd.hasOption("gui")) {
            guiMode = true;
        }

        final Client client = new Client(diaryHost, daemonPort);
        System.out.println("Client: port is " + client.getDaemonPort());
        new Thread(() -> {
            while (!client.isDiaryConnected()) {
                System.out.println("Client: Diary not connected, retrying in 10 seconds.");
                try {
                    Thread.sleep(10_000);
                    client.fetchDiary();
                } catch (InterruptedException e) {
                    System.err.println("Client: Interrupted while waiting for diary to connect");
                }
            }
        }).start();
        client.daemon.start();
        if (guiMode) {
            SwingUtilities.invokeLater(() -> {
                MainWindow window = new MainWindow(client);
                window.setVisible(true);
            });
        }
    }
}
