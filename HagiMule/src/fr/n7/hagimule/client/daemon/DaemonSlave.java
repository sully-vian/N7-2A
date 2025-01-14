package fr.n7.hagimule.client.daemon;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.Socket;
import java.net.SocketException;

/**
 * Traite une requête de téléchargement d'un fragment.
 */
public class DaemonSlave extends Thread {

    public static final int MAX_BUFFER_SIZE = 1024 * 16; // bytes

    private Socket clientSocket;
    private String fileName;

    public DaemonSlave(Socket clientSocket) {
        super("DaemonSlave");
        this.clientSocket = clientSocket;
    }

    @Override
    public void run() {
        try (OutputStream os = this.clientSocket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = this.clientSocket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is)) {

            // lire le nom du fichier
            this.fileName = ois.readUTF();
            File file = new File(Daemon.STORAGE_PATH + this.fileName);
            // puis le début du fragment
            int fragmentStart = ois.readInt();
            // et enfin la longueur du fragment
            int fragmentLength = ois.readInt();

            // créer un flux de lecture
            try (RandomAccessFile raf = new RandomAccessFile(file, "r")) {
                // envoyer le fichier par morceaux d'au plus MAX_BUFFER_SIZE octets
                raf.seek(fragmentStart); // positionner le curseur
                int totalBytesRead = 0;
                // lire les morceaux
                while (totalBytesRead < fragmentLength) {
                    int remainingBytes = fragmentLength - totalBytesRead;
                    int toReadNow = Math.min(remainingBytes, MAX_BUFFER_SIZE);
                    byte[] buffer = new byte[toReadNow];
                    int numBytesRead = raf.read(buffer); // lire dans le fichier
                    if (numBytesRead < 0) {
                        throw new IOException("Could not read enough bytes from file.");
                    }
                    oos.write(buffer, 0, numBytesRead); // écrire dans le flux
                    oos.flush();
                    totalBytesRead += numBytesRead;
                }
                System.out.println("DaemonSlave: finished writing");
            }

        } catch (SocketException e) {
            System.err.println("DaemonSlave: SocketException while processing request.");
            e.printStackTrace();
        } catch (IOException e) {
            System.err.println("DaemonSlave: Error while processing request.");
            e.printStackTrace();
        }
    }
}