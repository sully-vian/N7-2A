package example;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client {

    public static void main(String[] args) {
        try {
            // Locate RMI registry
            Registry registry = LocateRegistry.getRegistry("localhost", 8080);

            // Lookup the remote object
            Hello stub = (Hello) registry.lookup("Hello");

            // Invoke the remote method
            String response = stub.sayHello();
            System.out.println("Response: " + response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}