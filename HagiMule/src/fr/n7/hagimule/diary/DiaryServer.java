package fr.n7.hagimule.diary;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

/**
 * Crée un serveur RMI pour le Diary accessible par le client sur le port 1099.
 */
public class DiaryServer {

    private static final int PORT = 1099;

    public static void main(String[] args) {
        try {
            DiaryImpl diary = new DiaryImpl();
            Registry registry = LocateRegistry.createRegistry(PORT);
            registry.rebind("Diary", diary);
            System.out.println("Diary served on port " + PORT);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}