package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;

import fr.n7.hagimule.Host;

/**
 * Implémentation de l'annuaire.
 */
public class DiaryImpl extends UnicastRemoteObject implements Diary {

    private HashMap<String, HashSet<Host>> hostMap;
    private HashMap<String, Long> sizeMap;

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

    @Override
    public void addFile(String file, long fileSize, Host host) throws RemoteException, DuplicateFileNameException {

        Long expectedSize = this.sizeMap.get(file);

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
            if (hosts.isEmpty()) {
                this.hostMap.remove(file);
                this.sizeMap.remove(file);
            }
        }
    }

    @Override
    public synchronized void removeHost(Host host) throws RemoteException {
        Map<String, HashSet<Host>> hostMapCopy = new HashMap<>(this.hostMap);
        for (String file : hostMapCopy.keySet()) {
            HashSet<Host> hosts = this.hostMap.get(file);
            hosts.remove(host);
            if (hosts.isEmpty()) {
                this.hostMap.remove(file);
                this.sizeMap.remove(file);
            }
        }
    }

    @Override
    public Long getFileSize(String file) throws RemoteException {
        return this.sizeMap.get(file);
    }
}