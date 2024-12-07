import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {

    static int nbFrag = 3;

    static String[] document = new String[nbFrag];

    public static void main(String[] args) {
        document[0] = "Bonjour";
        document[1] = "tout";
        document[2] = "le monde";
        try {
            int myPort = Integer.parseInt(args[0]);

            ServerSocket ss = new ServerSocket(myPort);

            while (true) {
                Socket s = ss.accept();
                System.out.println("Connection on port " + myPort);

                InputStream is = s.getInputStream();
                OutputStream os = s.getOutputStream();

                // Permet de lire et envoyer des objets (int, String) (serialization)
                ObjectOutputStream oos = new ObjectOutputStream(os);
                ObjectInputStream ois = new ObjectInputStream(is);

                // réception puis envoi de la réponse
                int fragNo = (int) ois.readObject();
                oos.writeObject(document[fragNo]);
            }
        } catch (Exception e) {
            System.err.println(e);
        }
    }
}