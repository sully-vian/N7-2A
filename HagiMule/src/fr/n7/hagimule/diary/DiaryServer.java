package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Random;

import fr.n7.hagimule.Host;

/**
 * Serveur RMI pour l'annuaire.
 */
public class DiaryServer {

    private static final int PORT = 1099;

    /**
     * Crée un serveur RMI pour le Diary accessible par le client sur le port 1099.
     */
    public static void main(String[] args) {
        try {
            DiaryImpl diary = new DiaryImpl();
            addTestHosts(diary);

            Registry registry = LocateRegistry.createRegistry(PORT);
            registry.rebind("Diary", diary);
            System.out.println("Diary served on port " + PORT);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // TODO: retirer cette méthode
    private static void addTestHosts(Diary diary) {
        try {
            Random random = new Random();
            for (int i = 0; i < 10; i++) {
                String fileName = "file" + i;
                int fileSize = random.nextInt(10000);
                diary.addFile(fileName, fileSize, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
                diary.addFile(fileName, fileSize, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
                diary.addFile(fileName, fileSize, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
                diary.addFile(fileName, fileSize, new Host("host" + random.nextInt(10000), random.nextInt(10000)));
            }
        } catch (RemoteException | DuplicateFileNameException e) {
            System.err.println("Error when adding test hosts: " + e.toString());
        }
    }
}