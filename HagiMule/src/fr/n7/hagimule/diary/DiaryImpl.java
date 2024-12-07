package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class DiaryImpl extends UnicastRemoteObject implements Diary {

    private HashMap<String, HashSet<String>> map;

    /**
     * Crée un DiaryImpl vide.
     *
     * @throws RemoteException
     */
    public DiaryImpl() throws RemoteException {
        super();
        this.map = new HashMap<>();
    }

    @Override
    public HashSet<String> getFiles() throws RemoteException {
        return new HashSet<>(this.map.keySet());
    }

    @Override
    public HashSet<String> getHosts(String file) throws RemoteException {
        Set<String> hosts = this.map.get(file);
        return hosts == null ? new HashSet<>() : new HashSet<>(hosts);
    }

    @Override
    public void addHost(String file, String host) throws RemoteException {
        HashSet<String> hosts = this.map.get(file);
        if (hosts == null) {
            hosts = new HashSet<>();
            this.map.put(file, hosts);
        }
        hosts.add(host);
    }

    @Override
    public void removeHost(String file, String host) throws RemoteException {
        HashSet<String> hosts = this.map.get(file);
        if (hosts != null) {
            hosts.remove(host);
        }
    }
}