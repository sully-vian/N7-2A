package fr.n7.hagimule.client.daemon;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.nio.file.Files;

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

            System.out.println("DeamonSlave: connected with " + this.clientSocket.getInetAddress().getHostAddress() + ":"
                    + this.clientSocket.getPort());

            // récupérer le nom du fichier
            this.fileName = ois.readUTF();
            File file = new File(Daemon.STORAGE_PATH + this.fileName);
            // puis le nombre de fragments
            this.numFragments = ois.readInt();
            // et le numéro du fragment à fournir
            this.fragmentNumero = ois.readInt();

            // écris les octets
            byte[] fragment = Files.readAllBytes(file.toPath());
            oos.write(fragment);
            oos.flush();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}