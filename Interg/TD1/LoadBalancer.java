import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Random;

/**
 * Réponse au Problème 1 du sujet 2010-2011
 */
public class LoadBalancer extends Thread {
    static String[] hosts = { "host1", "host2" };
    static int[] ports = { 8081, 8082 };
    static int nbHosts = 2;
    static Random rand = new Random();
    Socket sock;

    public static void main(String[] args) {

        ServerSocket server; // définis en dehors du try pour pouvoir les fermer dans le finally

        try {
            server = new ServerSocket(Integer.parseInt(args[0]));

            while (true) {
                Socket sock = server.accept();
                Thread t = new LoadBalancer(sock);
                t.start();
            }

        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public LoadBalancer(Socket sock) {
        this.sock = sock;
    }

    public void run() {
        int nbServer = rand.nextInt(nbHosts);

        try {
            int nbLus;
            Socket sSock = new Socket(hosts[nbServer], ports[nbServer]);

            // Communication client -> serveur
            InputStream clientIn = sock.getInputStream();
            OutputStream lbOut = sSock.getOutputStream();
            byte[] req = new byte[1024];
            nbLus = clientIn.read(req); // lecture de la requête du client
            lbOut.write(req, 0, nbLus); // envoi de la requête au serveur

            // Communication serveur -> client
            OutputStream clientOut = sock.getOutputStream();
            InputStream lbIn = sSock.getInputStream();
            byte[] rep = new byte[1024];
            nbLus = lbIn.read(rep); // lecture de la réponse du serveur
            clientOut.write(rep, 0, nbLus); // envoi de la réponse au client

            clientIn.close();
            clientOut.close();
            lbIn.close();
            lbOut.close();
            sSock.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }

}