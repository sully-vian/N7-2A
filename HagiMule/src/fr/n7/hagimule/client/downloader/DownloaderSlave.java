package fr.n7.hagimule.client.downloader;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.concurrent.Callable;

/**
 * Traite le téléchargement d'un fragment d'un fichier.
 */
public class DownloaderSlave implements Callable<FragmentData> {

    private String fileName;
    private Socket socket;
    private byte[] fragment;
    private int fragmentNumero;

    /**
     * Crée un DownloaderSlave
     *
     * @param fileName       Le nom du fichier dont on veut un fragment.
     * @param host           L'hôte hébergeant ce fichier.
     * @param fragmentNumero Le numéro du fragment à télécharger.
     */
    public DownloaderSlave(String fileName, Socket socket, int fragmentNumero) {
        this.fileName = fileName;
        this.socket = socket;
        this.fragmentNumero = fragmentNumero;
    }

    @Override
    public FragmentData call() {
        if (socket.isClosed()) {
            System.err.println("DownloaderSlave: Socket is closed.");
        }
        try (OutputStream os = socket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = socket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is);) {

            // écrire le nom du fichier
            oos.writeUTF(this.fileName);
            oos.flush();

            this.fetchFragment(this.fragmentNumero, oos, ois);
            return new FragmentData(fragmentNumero, this.fragment);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Récupère le fragment de numéro donné par le stream.
     *
     * @param fragmentNumero Le numéro du fragment à télécharger.
     * @param oos            Le stream à partir duquel écrire la requête.
     * @param ois            Le stream à partir duquel lire le fragment.
     */
    private void fetchFragment(int fragmentNumero, ObjectOutputStream oos, ObjectInputStream ois) throws IOException {
        long start = fragmentNumero * DownloadTask.MAX_FRAGMENT_SIZE;
        // envoyer la position du début du fragment
        oos.writeLong(start);
        oos.flush();

        // lire les octets envoyés et les écrire dans le buffer
        long len = ois.readLong();
        if (len <= 0 || len > DownloadTask.MAX_FRAGMENT_SIZE) {
            throw new IOException("Invalid fragment length: " + len);
        }
        byte[] buffer = new byte[(int) len];
        // int numBytesRead = ois.read(buffer);
        int numBytesRead = (int) len;
        ois.readFully(buffer);
        if (numBytesRead != len) {
            System.out.println("DownloaderSlave: Warning: expected " + len +
                    " bytes, but read " + numBytesRead + " bytes.");
        }
        this.fragment = buffer;
    }
}