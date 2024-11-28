import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class UsagerServer extends Thread {
    public Socket sock;
    private Object[] document;

    public static void main(String[] args) {
        try {
            ServerSocket s = new ServerSocket(Integer.parseInt(args[0]));

            while (true) {
                Socket clientSocket = s.accept();
                Thread t = new UsagerServer(clientSocket);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public UsagerServer(Socket sock) {
        this.sock = sock;
    }

    public void run() {
        try {
            OutputStream os = sock.getOutputStream();
            ObjectOutputStream oos = new ObjectOutputStream(os);
            InputStream is = sock.getInputStream();
            ObjectInputStream ois = new ObjectInputStream(is);

            int fragment = (int) ois.readObject();
            oos.writeObject(document[fragment]);

            os.close();
            is.close();
            sock.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}