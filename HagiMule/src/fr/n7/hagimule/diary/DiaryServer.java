package fr.n7.hagimule.diary;

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

import fr.n7.hagimule.Utils;

/**
 * Serveur RMI pour l'annuaire.
 */
public class DiaryServer {

    /** Port du serveur RMI */
    public static final int PORT = 1099;

    /** Nom pour le binding de l'annuaire */
    public static final String BINDING_NAME = "Diary";

    /** Adresse IP du serveur */
    public static final String IP_ADDRESS = Utils.getLocalIPAddress();

    public static final String USAGE = "./scripts/diary [--gui]";

    private static void registerDiary(Diary diary) throws RemoteException {
        Registry registry = LocateRegistry.createRegistry(PORT);
        registry.rebind(BINDING_NAME, diary);
        System.out.println("Diary server started at " + IP_ADDRESS + ":" + PORT);
    }

    /**
     * Crée un serveur RMI pour l'annuaire.
     * <p>
     * Le binding de l'annuaire est fait avec le nom {@value #BINDING_NAME}.
     * <p>
     * Le port du serveur est {@value #PORT}.
     *
     * @param args -gui pour lancer le serveur avec une interface graphique
     */
    public static void main(String[] args) {

        Options options = new Options();
        options.addOption(Option.builder("g")
                .longOpt("gui")
                .hasArg(false)
                .desc("Run the server with a GUI")
                .build());
        options.addOption(Option.builder("h")
                .longOpt("help")
                .hasArg(false)
                .desc("Print this message")
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

        boolean guiMode = false;
        if (cmd.hasOption("gui")) {
            guiMode = true;
        }

        try {
            DiaryImpl diary = new DiaryImpl();
            registerDiary(diary);
            if (guiMode) {
                SwingUtilities.invokeLater(() -> {
                    MainWindow window = new MainWindow(diary);
                    window.setVisible(true);
                });
            }
        } catch (RemoteException e) {
            System.err.println("DiaryServer: Error when creating the server: " + e.toString());
        }
    }
}