package fr.n7.hagimule.client;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Set;

import fr.n7.hagimule.diary.Diary;

public class Client {

    public static void main(String[] args) {
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