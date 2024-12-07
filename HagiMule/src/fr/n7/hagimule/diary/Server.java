package fr.n7.hagimule.diary;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Server {

    public static void main(String[] args) {
        try {
            Diary obj = new DiaryImpl();
            Registry registry = LocateRegistry.createRegistry(1099);
            registry.rebind("Diary", obj);
            System.out.println("Server ready");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}