package fr.n7.hagimule.client;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Set;

import fr.n7.hagimule.client.daemon.Daemon;
import fr.n7.hagimule.client.downloader.Downloader;
import fr.n7.hagimule.diary.Diary;

public class Client {

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java Client [0|1]");
            return;
        }

        if (Integer.parseInt(args[0]) == 0) {
            Daemon daemon = new Daemon(8080);
            daemon.start();
            System.out.println("Daemon started");
        } else if (Integer.parseInt(args[0]) == 1) {
            Downloader downloader = new Downloader("foo.txt", "localhost", 8080);
            downloader.start();
            System.out.println("Downloader started");
        } else {
            System.out.println("Usage: java Client [0|1]");
        }
    }

    public static void main2(String[] args) {
        try {
            Registry registry = LocateRegistry.getRegistry("localhost", 1099);
            System.out.println("got registry");

            Diary stub = (Diary) registry.lookup("Diary");
            System.out.println("got stub");

            Set<String> files = stub.getFiles();
            System.out.println(files);
        } catch (Exception e) {
            System.err.println("Client exception: " + e.toString());
        }
    }
}