package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.client.ClientDiary;

/**
 * Implémentation commune de l'annuaire.
 * <p>
 * Ses méthodes sont spécifiées et documentées dans les interfaces
 * {@link ClientDiary} et {@link ServerDiary} en fonction de leur usage (client
 * ou serveur).
 */
public class DiaryImpl extends UnicastRemoteObject implements ServerDiary, ClientDiary {

    /**
     * Durée de vie d'un hôte sans nouvelles (en secondes).
     */
    private static final int DEATH_DELAY = 3;

    private Map<String, FileInfo> infoMap;
    private Map<Host, Integer> hostTimers;

    public DiaryImpl() throws RemoteException {
        super();
        this.infoMap = new HashMap<>();
        this.hostTimers = new HashMap<>();
    }

    @Override
    public synchronized Set<String> getFileNames() throws RemoteException {
        return new HashSet<>(this.infoMap.keySet());
    }

    @Override
    public synchronized void addFileInfo(FileInfo fileInfo, Host host) throws RemoteException {
        String fileName = fileInfo.getName();
        if (this.infoMap.get(fileName) == null) {
            this.infoMap.put(fileName, fileInfo);
        }
        this.infoMap.get(fileName).addHost(host);
        this.resetHostTimer(host);
    }

    @Override
    public synchronized void removeHost(Host host) throws RemoteException {
        Map<String, FileInfo> infoMapCopy = this.getContents();
        for (FileInfo fileInfo : infoMapCopy.values()) {
            fileInfo.removeHost(host);
            if (fileInfo.getHosts().isEmpty()) {
                this.infoMap.remove(fileInfo.getName());
            }
        }
    }

    @Override
    public synchronized FileInfo getFileInfo(String fileName) throws RemoteException {
        return this.infoMap.get(fileName);
    }

    @Override
    public synchronized Map<String, FileInfo> getContents() throws RemoteException {
        return new HashMap<>(this.infoMap);
    }

    @Override
    public synchronized void resetHostTimer(Host host) throws RemoteException {
        this.hostTimers.put(host, DEATH_DELAY);
    }

    @Override
    public synchronized void updateHostTimers() throws RemoteException {
        Set<Host> hosts = new HashSet<>(this.hostTimers.keySet());
        for (Host host : hosts) {
            int timeLeft = this.hostTimers.get(host);
            if (timeLeft == 0) {
                this.hostTimers.remove(host);
                this.removeHost(host);
                System.out.println("Diary: Lost host " + host);
            } else {
                this.hostTimers.put(host, timeLeft - 1);
            }
        }
    }

}