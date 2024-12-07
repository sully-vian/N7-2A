package fr.n7.hagimule.client.downloader;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.net.Socket;

public class DownloaderSlave extends Thread {

    private String fileName;
    private int numFragments;
    private int fragmentNumero;
    private int fragmentSize = 1024;
    private String host;
    private int port;

    public DownloaderSlave(String fileName, String host, int port, int numFragments, int fragmentNumero) {
        this.fileName = fileName;
        this.host = host;
        this.port = port;
        this.numFragments = numFragments;
        this.fragmentNumero = fragmentNumero;
    }

    @Override
    public void run() {
        System.out.println("Trying to connect to " + this.host + ":" + this.port);

        try (Socket socket = new Socket(this.host, this.port);
                OutputStream os = socket.getOutputStream();
                ObjectOutputStream oos = new ObjectOutputStream(os);
                InputStream is = socket.getInputStream();
                ObjectInputStream ois = new ObjectInputStream(is);) {
            System.out.println("DownloaderSlave connected with " + this.host + ":" + this.port);

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
            System.out.println("received response: \"" + response + "\"");

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}