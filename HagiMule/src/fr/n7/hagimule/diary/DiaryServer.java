package fr.n7.hagimule.diary;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Enumeration;

import javax.swing.SwingUtilities;

/**
 * Serveur RMI pour l'annuaire.
 */
public class DiaryServer {

    /** Port du serveur RMI */
    public static final int PORT = 1234;

    /** Nom pour le binding de l'annuaire */
    public static final String BINDING_NAME = "Diary";

    public static final String IP_ADDRESS = getLocalIPAddress();

    private static final String USAGE = "\n\tUsage: java -cp bin fr.n7.hagimule.diary.DiaryServer [-gui]\n\n"
            + "\tIf the -gui option is provided, the server will run in GUI mode.\n";

    private static String getLocalIPAddress() {
        try {
            Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
            while (interfaces.hasMoreElements()) {
                NetworkInterface iface = interfaces.nextElement();
                if (iface.isLoopback() || !iface.isUp()) {
                    continue;
                }
                Enumeration<InetAddress> addresses = iface.getInetAddresses();
                while (addresses.hasMoreElements()) {
                    String address = addresses.nextElement().getHostAddress();
                    if (address.contains(":")) {
                        continue; // skip IPv6
                    }
                    return address;
                }
            }
        } catch (SocketException e) {
            System.err.println("DiaryServer: Error when getting local IP address: " + e.toString());
        }
        return "localhost";
    }

    private static void registerDiary(Diary diary) throws RemoteException {
        Registry registry = LocateRegistry.createRegistry(PORT);
        registry.rebind(BINDING_NAME, diary);
        System.out.println("Diary server started at " + IP_ADDRESS + ":" + PORT);
    }

    /**
     * Crée un serveur RMI pour l'annuaire.
     *
     * @param args arguments de la ligne de commande (non utilisés)
     */
    public static void main(String[] args) {
        boolean guiMode = false;
        if (args.length > 0) {
            if (args[0].equals("-gui")) {
                guiMode = true;
            } else {
                System.err.println(USAGE);
                System.exit(1);
            }
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