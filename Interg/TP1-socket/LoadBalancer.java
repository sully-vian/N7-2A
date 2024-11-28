import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Random;

public class LoadBalancer extends Thread {
    static String[] hosts = { "localhost", "localhost" };
    static int[] ports = { 8081, 8082 };
    static int nbHosts = 2;
    static Random rand = new Random();
    Socket clientSock;

    public static void main(String[] args) {
        ServerSocket server;

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

    public LoadBalancer(Socket clientSock) {
        super();
        this.clientSock = clientSock;
    }

    /**
     * Appelé lors du démarrage du thread, il va choisir un serveur aléatoire et
     * faire suivre la requête du client à ce serveur
     */
    public void run() {
        int nbServer = rand.nextInt(nbHosts);

        try {
            int nbLus;
            Socket sSock = new Socket(hosts[nbServer], ports[nbServer]);

            // communication client -> serveur
            InputStream clientIn = this.clientSock.getInputStream();
            OutputStream lbOut = sSock.getOutputStream();
            byte[] req = new byte[1024];
            nbLus = clientIn.read(req); // lecture de la requête du client
            lbOut.write(req, 0, nbLus); // envoi de la requête au serveur

            // communication serveur -> client
            OutputStream clientOut = this.clientSock.getOutputStream();
            InputStream lbIn = sSock.getInputStream();
            byte[] rep = new byte[1024];
            nbLus = lbIn.read(rep); // leture de la réponse du serveur
            clientOut.write(rep, 0, nbLus); // envoi de la réponse au client

            // fermeture des streams
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
