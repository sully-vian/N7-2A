package fr.n7.hagimule.diary;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import fr.n7.hagimule.Host;

/**
 * Implémentation de l'annuaire.
 */
public class DiaryImpl extends UnicastRemoteObject implements Diary {

    private Map<String, FileInfo> infoMap;

    public DiaryImpl() throws RemoteException {
        super();
        this.infoMap = new HashMap<>();
    }

    @Override
    public Set<String> getFileNames() throws RemoteException {
        return new HashSet<>(this.infoMap.keySet());
    }

    @Override
    public synchronized void addFileInfo(FileInfo fileInfo, Host host) throws RemoteException {
        String fileName = fileInfo.getName();
        if (this.infoMap.get(fileName) == null) {
            this.infoMap.put(fileName, fileInfo);
        }
        this.infoMap.get(fileName).addHost(host);
    }

    @Override
    public synchronized void removeHost(String fileName, Host host) throws RemoteException {
        FileInfo fileInfo = this.infoMap.get(fileName);
        if (fileInfo != null) {
            fileInfo.removeHost(host);
            if (fileInfo.getHosts().isEmpty()) {
                this.infoMap.remove(fileName);
            }
        }
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
    public FileInfo getFileInfo(String fileName) throws RemoteException {
        return this.infoMap.get(fileName);
    }

    @Override
    public Map<String, FileInfo> getContents() throws RemoteException {
        return new HashMap<>(this.infoMap);
    }

}