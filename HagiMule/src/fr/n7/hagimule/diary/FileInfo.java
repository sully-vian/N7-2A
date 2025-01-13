package fr.n7.hagimule.diary;

import java.io.File;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import fr.n7.hagimule.Host;

/**
 * Représente un fichier.
 */
public class FileInfo implements Serializable {

    private String name;
    private long size; // en octets
    private Set<Host> hosts;

    public FileInfo(String name, long size) {
        this.name = name;
        this.size = size;
        this.hosts = new HashSet<>();
    }

    public FileInfo(String name, long size, Host host) {
        this(name, size);
        this.hosts.add(host);
    }

    public FileInfo(File file) {
        this(file.getName(), file.length());
    }

    public String getName() {
        return name;
    }

    public long getSize() {
        return size;
    }

    public Set<Host> getHosts() {
        return hosts;
    }

    public void addHost(Host host) {
        this.hosts.add(host);
    }

    public void removeHost(Host host) {
        hosts.remove(host);
    }

    public String toString() {
        return this.name + " (" + this.size + ") " + this.hosts;
    }

}