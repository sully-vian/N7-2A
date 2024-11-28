import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;

/**
 * Réponse à la Question 2 du Problème 1 du sujet 2011-2012
 */
public class UsagerClient extends Thread {
    static final String[] hosts = { "host1", "host2", "host3", };
    static final int[] ports = { 8081, 8082, 8083 };
    static final int nbHosts = 3;
    static String[] document = new String[nbHosts];
    int fragment;

    public static void main(String[] args) {
        try {
            Thread[] t = new Thread[nbHosts];

            for (int i = 0; i < nbHosts; i++) {
                t[i] = new UsagerClient(i);
                t[i].start();
            }

            for (int i = 0; i < nbHosts; i++) {
                t[i].join(); // attend la fin de chaque thread (équivaut à un wait en C)
            }

            for (int i = 0; i < nbHosts; i++) {
                System.out.println("fragment " + i + ": " + document[i]);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public UsagerClient(int fragment) {
        this.fragment = fragment;
    }

    public void run() {
        try {
            Socket sock = new Socket(hosts[fragment], ports[fragment]);

            OutputStream os = sock.getOutputStream();
            ObjectOutputStream oos = new ObjectOutputStream(os);
            InputStream is = sock.getInputStream();
            ObjectInputStream ois = new ObjectInputStream(is);

            oos.writeInt(fragment);

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}