package fr.n7.hagimule.diary;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

/**
 * Crée un serveur RMI pour le Diary accessible par le client sur le port 1099.
 */
public class Server {

    public static void main(String[] args) {
        try {
            DiaryImpl diary = new DiaryImpl();
            Registry registry = LocateRegistry.createRegistry(1099);
            registry.rebind("Diary", diary);
            System.out.println("Server ready");

            // save the diary map to a file every 10 seconds
            while (true) {
                diary.saveMapToFile();
                System.out.println("Diary map saved to file");
                Thread.sleep(10_000);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}