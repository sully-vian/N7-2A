import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.Socket;

public class Client extends Thread {
    final static String[] hosts = { "localhost", "localhost", "localhost" };
    final static int[] ports = { 8080, 8081, 8082 };
    final static int nbFrag = 3;
    static String[] document = new String[nbFrag];
    int myNumero;

    public Client(int n) {
        this.myNumero = n;
        System.out.println("Client " + n + " created");
    }

    public static void main(String[] args) {
        Thread[] threads = new Thread[nbFrag];
        for (int i = 0; i < nbFrag; i++) {
            threads[i] = new Client(i);
            threads[i].start();
        }

        try {
            // Attendre que tous les threads se terminent
            for (int i = 0; i < nbFrag; i++) {
                threads[i].join();
                System.out.println("Client " + i + " joined");
            }
        } catch (Exception e) {
            System.err.println(e);
        }

        for (int i = 0; i < nbFrag; i++) {
            System.out.println(document[i]);
        }
    }

    @Override
    public void run() {
        System.err.println("Client " + myNumero + " running");
        try {
            Socket s = new Socket(hosts[myNumero], ports[myNumero]);
            System.out.println("Client " + myNumero + " connected");

            InputStream is = s.getInputStream();
            OutputStream os = s.getOutputStream();

            // Permet de lire et de renvoyer des objets (int, String) (serialization)
            ObjectOutputStream oos = new ObjectOutputStream(os);
            ObjectInputStream ois = new ObjectInputStream(is);

            // envoi puis réception de la réponse
            oos.writeObject(this.myNumero); // Envoi de la requête
            document[myNumero] = ((String) ois.readObject()); // Récupération de la réponse

            System.out.println("Client " + myNumero + " done");

        } catch (ConnectException e) {
            System.err.println("Impossible de se connecter au serveur " + hosts[myNumero] + ":" + ports[myNumero]);
        } catch (Exception e) {
            System.err.println(e);
        }
    }
}