import java.net.ServerSocket;
import java.net.Socket;

/**
 * Gère les requêtes utilisateurs et crée un nouveau Thread Diary pour chaque
 * client.
 */
public class DiaryServer {

    public static void main(String[] args) {

        ServerSocket server;

        try {
            server = new ServerSocket(Integer.parseInt(args[0]));
            while (true) {
                Socket sock = server.accept();
                Thread t = new DiaryImpl(sock);
                t.start();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}