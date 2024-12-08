package fr.n7.hagimule.diary;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import fr.n7.hagimule.Host;

public class DiaryImpl extends UnicastRemoteObject implements Diary {

    private HashMap<String, HashSet<Host>> map;
    private String FILE_NAME;

    /**
     * Crée un DiaryImpl vide.
     * <p>
     * Son fichier de sauvegarde par défaut est "diary.ser".
     *
     * @throws RemoteException
     */
    public DiaryImpl() throws RemoteException {
        super();
        this.FILE_NAME = "diary.ser";
        this.map = new HashMap<>();
    }

    /**
     * Crée un DiaryImpl à partir d'un nom fichier de sauvegarde.
     *
     * @param fileName le nom du fichier de sauvegarde
     * @throws RemoteException
     */
    public DiaryImpl(String fileName) throws RemoteException {
        this();
        this.FILE_NAME = fileName;
        this.loadMapFromFile();
    }

    @Override
    public HashSet<String> getFiles() throws RemoteException {
        return new HashSet<>(this.map.keySet());
    }

    @Override
    public HashSet<Host> getHosts(String file) throws RemoteException {
        Set<Host> hosts = this.map.get(file);
        return hosts == null ? new HashSet<>() : new HashSet<>(hosts);
    }

    @Override
    public void addHost(String file, Host host) throws RemoteException {
        HashSet<Host> hosts = this.map.get(file);
        if (hosts == null) {
            hosts = new HashSet<>();
            this.map.put(file, hosts);
        }
        hosts.add(host);
    }

    @Override
    public void removeHost(String file, Host host) throws RemoteException {
        HashSet<Host> hosts = this.map.get(file);
        if (hosts != null) {
            hosts.remove(host);
        }
    }

    protected void saveMapToFile() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_NAME))) {
            oos.writeObject(this.map);
        } catch (Exception e) {
            System.err.println("Error saving diary map to file: " + e.toString());
        }
    }

    protected void loadMapFromFile() {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_NAME))) {
            this.map = (HashMap<String, HashSet<Host>>) ois.readObject();
        } catch (Exception e) {
            System.err.println("Error loading diary map from file: " + e.toString());
            this.map = new HashMap<>();
        }
    }
}