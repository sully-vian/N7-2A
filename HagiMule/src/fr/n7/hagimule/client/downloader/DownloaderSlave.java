package fr.n7.hagimule.client.downloader;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.daemon.DaemonSlave;

/**
 * Traite le téléchargement d'un fragment d'un fichier sur un hôte. La méthode
 * héritée {@link #run} écrit automatiquement le fragment dans la
 * {@link DownloadTask} associée.
 */
public class DownloaderSlave extends Thread {

    private Host host;
    private String fileName;
    private byte[] fragment;
    private int fragmentStart;
    private int fragmentLength;
    private DownloadTask task;

    /**
     * Crée un DownloaderSlave.
     *
     * @param socket        La socket à utiliser pour la communication avec l'hôte.
     * @param fileName      Le nom du fichier dont on veut un fragment.
     * @param fragmentStart Le début du fragment à télécharger.
     */
    public DownloaderSlave(DownloadTask task, Host host, String fileName, int fragmentStart, int fragmentLength) {
        super("DownloaderSlave");
        this.host = host;
        this.fileName = fileName;
        this.fragmentStart = fragmentStart;
        this.fragmentLength = fragmentLength;
        this.fragment = new byte[fragmentLength];
        this.task = task;
        System.out.println(
                "DownloaderSlave: created with fragmentStart=" + fragmentStart + ", fragmentLength=" + fragmentLength);
    }

    @Override
    public void run() {
        try (Socket socket = new Socket(this.host.getAddress(), this.host.getPort());
                OutputStream os = socket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = socket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is)) {

            // écrire le nom du fichier
            oos.writeUTF(this.fileName);
            oos.flush();
            // puis le début du fragment
            oos.writeInt(this.fragmentStart);
            oos.flush();
            // et enfin la longueur du fragment
            oos.writeInt(this.fragmentLength);
            oos.flush();

            int totalBytesRead = 0;
            // lire les morceaux
            while (totalBytesRead < this.fragmentLength) {
                int remainingBytes = this.fragmentLength - totalBytesRead;
                int toReadNow = Math.min(remainingBytes, DaemonSlave.MAX_BUFFER_SIZE);
                byte[] buffer = new byte[toReadNow];
                int bytesRead = ois.read(buffer);
                if (bytesRead < 0) {
                    System.err.println("DownloaderSlave: Warning: read " + bytesRead + " bytes.");
                }
                // copier le fragment dans le tableau
                System.arraycopy(buffer, 0, this.fragment, totalBytesRead, bytesRead);
                totalBytesRead += bytesRead; // on avance dans la réception
            }
            System.out.println("DownloaderSlave: finished reading");
            // écrit tout seul comme un grand dans son daron
            this.task.writeFragment(fragment, fragmentStart);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Retourne le fragment téléchargé. Appeler cette méthode après que le thread
     * soit terminé.
     *
     * @return le fragment téléchargé.
     */
    public byte[] getFragment() {
        return this.fragment;
    }
}