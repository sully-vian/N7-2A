package fr.n7.hagimule.client.daemon;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * Sur chaque client.
 * <p>
 * Permet le téléchargement de fragments depuis un autre client.
 * <p>
 * Accessible avec des sockets TCP.
 */
public class Daemon extends Thread {

    private int port;
    private ServerSocket serverSocket;

    public Daemon(int port) {
        super();
        this.port = port;
    }

    @Override
    public void run() {
        try {
            this.serverSocket = new ServerSocket(this.port);
            System.out.println("Daemon started on port " + this.port);

            while (true) {
                Socket clientSocket = this.serverSocket.accept();
                System.out.println("Daemon connected socket, starting slave");
                Thread slave = new DaemonSlave(clientSocket);
                slave.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}