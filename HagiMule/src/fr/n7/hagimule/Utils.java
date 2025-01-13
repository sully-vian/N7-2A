package fr.n7.hagimule;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

public class Utils {

    /**
     * Récupère l'adresse IP locale de la machine.
     * <p>
     * Cette méthode itère sur les interfaces réseau de la machine et leur IP
     * associée pour trouver la première adresse IPv4 non loopback.
     * Si aucune telle adresse n'est trouvée, la méthode retourne <code>localhost</code>.
     * </p>
     *
     * @return l'adresse IP locale de la machine.
     */
    public static String getLocalIPAddress() {
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
            System.err.println("Utils: Error when getting local IP address:");
            e.printStackTrace();
        }
        return "localhost";
    }
}