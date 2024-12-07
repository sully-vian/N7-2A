package example;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Server {
    public static void main(String[] args) {
        try {
            // Create the remote object
            HelloImpl obj = new HelloImpl();

            // Bind the remote object to the RMI registry
            Registry registry = LocateRegistry.createRegistry(8080);
            registry.rebind("Hello", obj);

            System.out.println("Server ready");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
