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

    private Socket socket;
    private String fileName;
    private byte[] fragment;
    private int fragmentNumero;

    /**
     * Crée un DownloaderSlave.
     *
     * @param socket         La socket à utiliser pour la communication avec l'hôte.
     * @param fileName       Le nom du fichier dont on veut un fragment.
     * @param fragmentNumero Le numéro du fragment à télécharger.
     */
    public DownloaderSlave(Socket socket, String fileName, int fragmentNumero) {
        this.socket = socket;
        this.fileName = fileName;
        this.fragmentNumero = fragmentNumero;
    }

    @Override
    public FragmentData call() {
        try (OutputStream os = socket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = socket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is);) {

            // écrire le nom du fichier
            oos.writeUTF(this.fileName);
            oos.flush();

            this.fetchFragment(oos, ois);
            return new FragmentData(fragmentNumero, this.fragment);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Récupère le fragment de numéro donné par le stream.
     *
     * @param oos            Le stream à partir duquel écrire la requête.
     * @param ois            Le stream à partir duquel lire le fragment.
     */
    private void fetchFragment(ObjectOutputStream oos, ObjectInputStream ois) throws IOException {
        long start = this.fragmentNumero * DownloadTask.MAX_FRAGMENT_SIZE;
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