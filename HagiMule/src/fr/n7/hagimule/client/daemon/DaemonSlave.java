package fr.n7.hagimule.client.daemon;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;

/**
 * Traite une requête de téléchargement d'un fragment.
 */
public class DaemonSlave extends Thread {

    private Socket clientSocket;

    private String fileName;
    private int numFragments;
    private int fragmentNumero;

    public DaemonSlave(Socket clientSocket) {
        this.clientSocket = clientSocket;
    }

    @Override
    public void run() {
        try (OutputStream os = this.clientSocket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = this.clientSocket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is);) {

            System.out.println("DeamonSlave connected with " + this.clientSocket.getInetAddress().getHostAddress() + ":"
                    + this.clientSocket.getPort());

            this.fileName = ois.readUTF();
            System.out.println("recieved file name:" + this.fileName);
            this.numFragments = ois.readInt();
            System.out.println("recieved numFragment:" + this.numFragments);
            this.fragmentNumero = ois.readInt();
            System.out.println("recieved fragmentNumero:" + this.fragmentNumero);

            oos.writeUTF("Recieved !");
            oos.flush();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}