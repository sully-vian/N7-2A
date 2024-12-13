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
    private int fragmentSize = 1024;
    private Host host;

    public DownloaderSlave(String fileName, Host host, int numFragments, int fragmentNumero) {
        this.fileName = fileName;
        this.host = host;
        this.numFragments = numFragments;
        this.fragmentNumero = fragmentNumero;
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

            oos.writeUTF(this.fileName);
            System.out.println("sent file name:" + this.fileName);
            oos.flush();
            oos.writeInt(this.numFragments);
            System.out.println("sent numFragments:" + this.numFragments);
            oos.flush();
            oos.writeInt(this.fragmentNumero);
            System.out.println("sent fragmentNumero:" + this.fragmentNumero);
            oos.flush();

            String response = ois.readUTF();
            System.out.println("recieved response: \"" + response + "\"");

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}