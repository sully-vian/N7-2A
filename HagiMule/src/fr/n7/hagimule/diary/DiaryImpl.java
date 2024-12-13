package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.HashSet;

import fr.n7.hagimule.Host;

/**
 * Implémentation de l'annuaire.
 */
public class DiaryImpl extends UnicastRemoteObject implements Diary {

    private HashMap<String, HashSet<Host>> hostMap;
    private HashMap<String, Integer> sizeMap;

    /**
     * Crée un DiaryImpl vide.
     *
     * @throws RemoteException
     */
    public DiaryImpl() throws RemoteException {
        super();
        this.hostMap = new HashMap<>();
        this.sizeMap = new HashMap<>();
    }

    @Override
    public HashSet<String> getFileNames() throws RemoteException {
        return new HashSet<>(this.hostMap.keySet());
    }

    @Override
    public HashSet<Host> getHosts(String file) throws RemoteException {
        return this.hostMap.get(file);
    }

    // TODO: à tester
    @Override
    public void addFile(String file, int fileSize, Host host) throws RemoteException, DuplicateFileNameException {

        Integer expectedSize = this.sizeMap.get(file);

        if (expectedSize != null && expectedSize != fileSize) {
            throw new DuplicateFileNameException("File \"" + file + "\" already exists with a different size.");
        }

        this.sizeMap.put(file, fileSize);

        HashSet<Host> hosts = this.hostMap.get(file);
        if (hosts == null) {
            hosts = new HashSet<>();
            this.hostMap.put(file, hosts);
        }
        hosts.add(host);
    }

    @Override
    public void removeHost(String file, Host host) throws RemoteException {
        HashSet<Host> hosts = this.hostMap.get(file);
        if (hosts != null) {
            hosts.remove(host);
        }

        if (hosts.isEmpty()) {
            this.hostMap.remove(file);
            this.sizeMap.remove(file);
        }
    }

    // TODO: à tester
    @Override
    public Integer getFileSize(String file) throws RemoteException {
        return this.sizeMap.get(file);
    }
}