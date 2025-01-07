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
                        // Fin du stream, on sot de la loop
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
        System.out.println("DaemonSlave: reading fragment at " + start);
        byte[] buffer = new byte[(int) DownloadTask.FRAGMENT_SIZE];
        // lire les octets voulus
        int bytesRead = raf.read(buffer, (int) start, (int) DownloadTask.FRAGMENT_SIZE);
        System.out.println("DaemonSlave: " + bytesRead + " bytes read from file");
        oos.write(buffer);
        oos.flush();
    }
}