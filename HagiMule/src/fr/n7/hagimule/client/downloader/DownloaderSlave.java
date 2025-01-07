package fr.n7.hagimule.client.downloader;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import fr.n7.hagimule.Host;

/**
 * Traite le téléchargement des fragments demandés.
 */
public class DownloaderSlave extends Thread {

    private String fileName;
    private Host host;
    private List<Integer> fragmentNumeros;
    private Map<Integer, byte[]> fragments;
    private boolean downloadFinished;

    /**
     * Crée un DownloaderSlave
     *
     * @param fileName        Le nom du fichier dont on veut un fragment.
     * @param host            L'hôte hébergeant ce fichier.
     * @param fragmentNumeros Les numéros des fragments à télécharger.
     */
    public DownloaderSlave(String fileName, Host host) {
        super("Downloading " + fileName + " from " + host);
        this.fileName = fileName;
        this.host = host;
        this.fragmentNumeros = new ArrayList<>();
        this.fragments = new HashMap<>();
        this.downloadFinished = false;
    }

    @Override
    public void run() {
        System.out.println("DownloaderSlave: starting with " + this.fragmentNumeros.size() + " fragments to download.");
        try (Socket socket = new Socket(this.host.getName(), this.host.getPort());
                OutputStream os = socket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = socket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is);) {

            System.out.println("DownloaderSlave: connected with " + this.host);

            // écrire le nom du fichier
            oos.writeUTF(this.fileName);
            oos.flush();

            for (int fragmentNumero : this.fragmentNumeros) {
                this.fetchFragment(fragmentNumero, oos, ois);
            }

            this.downloadFinished = true;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void addFragmentNumero(int fragmentNumero) {
        this.fragmentNumeros.add(fragmentNumero);
    }

    /**
     * Récupère le fragment de numéro donné par le stream.
     *
     * @param fragmentNumero Le numéro du fragment à télécharger.
     * @param oos            Le stream à partir duquel écrire la requête.
     * @param ois            Le stream à partir duquel lire le fragment.
     */
    private void fetchFragment(int fragmentNumero, ObjectOutputStream oos, ObjectInputStream ois) throws IOException {
        long start = fragmentNumero * DownloadTask.FRAGMENT_SIZE;
        // envoyer la position du début du fragment
        System.out.println("DownloaderSlave: requesting fragment " + fragmentNumero + " at " + start);
        oos.writeLong(start);
        oos.flush();

        byte[] buffer = new byte[((int) DownloadTask.FRAGMENT_SIZE)];

        // lire les octets envoyés et les écrire dans le buffer
        int numBytesRead = ois.read(buffer);
        System.out.println("DownloaderSlave: " + numBytesRead + " bytes read from stream");

        this.fragments.put(fragmentNumero, buffer);
    }

    /**
     * Renvoie les fragments téléchargés.
     *
     * @return Les fragments téléchargés. null si le téléchargement n'est pas
     *         terminé.
     */
    public Map<Integer, byte[]> getFragments() {
        if (!this.downloadFinished) {
            System.err.println("DownloaderSlave: Error: trying to retrieve the fragments "
                    // + this.fragmentNumeros
                    + " of " + this.fileName + " before download finished.");
            return null;
        }
        return this.fragments;
    }
}