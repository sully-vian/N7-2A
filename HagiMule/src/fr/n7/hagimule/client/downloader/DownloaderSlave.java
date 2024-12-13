package fr.n7.hagimule.client.downloader;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Random;

import fr.n7.hagimule.Host;

/**
 * Traite le téléchargement d'un fragment.
 */
public class DownloaderSlave extends Thread {

    private String fileName;
    private int numFragments;
    private int fragmentNumero;
    private Host host;
    private boolean downloadFinished;
    private byte[] fragment;

    /**
     * Crée un DownloaderSlave
     *
     * @param fileName       Le nom du fichier dont on veut un fragment.
     * @param host           L'hôte hébergeant ce fichier.
     * @param numFragments   Le nombre de fragments en lequel le fichier est
     *                       découpé.
     * @param fragmentNumero Le numéro du fragement à télécharger.
     */
    public DownloaderSlave(String fileName, int fileSize, Host host, int numFragments, int fragmentNumero) {
        this.fileName = fileName;
        this.host = host;
        this.numFragments = numFragments;
        this.fragmentNumero = fragmentNumero;
        this.downloadFinished = false;
        this.fragment = new byte[fileSize / numFragments];
    }

    @Override
    public void run() {
        // System.out.println("Trying to connect to " + this.host);

        // Pour simuler un téléchargement
        Random random = new Random();
        try {
            Thread.sleep(random.nextInt(10000));
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // TODO: Télécharger le fragment du fichier

        try (Socket socket = new Socket(this.host.getName(), this.host.getPort());
                OutputStream os = socket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = socket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is);) {
            System.out.println("DownloaderSlave connected with " + this.host + ":" +
                    this.host.getPort());

            // écrire le nom du fichier
            oos.writeUTF(this.fileName);
            oos.flush();
            // puis le nombre de fragments
            oos.writeInt(this.numFragments);
            oos.flush();
            // et le numéro du fragment voulu
            oos.writeInt(this.fragmentNumero);
            oos.flush();

            int numRead = ois.read(this.fragment);
            System.out.println(numRead + "bytes read");

            this.downloadFinished = true;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Obtenir le fragment ainsi téléchargé.
     *
     * @return Le fragment téléchargé. null si le téléchargement n'est pas terminé.
     */
    public byte[] getFragment() {
        if (!this.downloadFinished) {
            System.err.println("Error: trying to retrieve the fragment " + this.fragmentNumero
                    + " of " + this.fileName + " before download finised.");
            return null;
        }
        return this.fragment;
    }
}