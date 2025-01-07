package fr.n7.hagimule.client.daemon;

import java.io.EOFException;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.net.Socket;
import java.net.SocketException;

import fr.n7.hagimule.client.downloader.DownloadTask;

/**
 * Traite une requête de téléchargement d'un fragment.
 */
public class DaemonSlave extends Thread {

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

            System.out.println("DeamonSlave: connected with " +
                    this.clientSocket.getInetAddress().getHostAddress() +
                    ":" + this.clientSocket.getPort());

            // récupérer le nom du fichier
            this.fileName = ois.readUTF();
            File file = new File(Daemon.STORAGE_PATH + this.fileName);

            // créer un flux de lecture
            try (RandomAccessFile raf = new RandomAccessFile(file, "r")) {
                while (true) {
                    try {
                        sendFragment(oos, ois, raf);
                    } catch (EOFException e) {
                        // Fin du stream, on sort de la loop
                        break;
                    }
                }
            }

        } catch (SocketException e) {
            System.err.println("DaemonSlave: SocketException while processing request.");
            e.printStackTrace();
        } catch (IOException e) {
            System.err.println("DaemonSlave: Error while processing request.");
            e.printStackTrace();
        }
    }

    /**
     * Envoie un fragment du fichier demandé.
     *
     * @param oos le flux de sortie.
     * @param ois le flux d'entrée.
     * @param raf le fichier à lire.
     * @throws IOException
     */
    private void sendFragment(ObjectOutputStream oos, ObjectInputStream ois, RandomAccessFile raf) throws IOException {
        long start = ois.readLong();

        // calculer et transmettre la taille du prochain fragment
        long len = Math.min(DownloadTask.FRAGMENT_SIZE, raf.length() - start);
        if (len <= 0 || len > DownloadTask.FRAGMENT_SIZE) {
            throw new IOException("Invalid fragment length: " + len);
        }
        oos.writeLong(len);
        oos.flush();

        raf.seek(start); // positionner le curseur
        byte[] buffer = new byte[(int) len];
        int numBytesRead = raf.read(buffer); // lire les octets voulus dans le fichier
        if (numBytesRead < len) {
            throw new IOException("Could not read enough bytes from file.");
        }
        oos.write(buffer); // écrire les octets dans le flux
        oos.flush();
    }
}