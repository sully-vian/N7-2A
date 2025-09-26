package fr.n7.hagimule.diary;

import java.io.File;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.Utils;

/**
 * Représente un fichier.
 */
public class FileInfo implements Serializable {

    private String name;
    private int size; // en octets
    private Set<Host> hosts;

    public FileInfo(String name, int size) {
        this.name = name;
        this.size = size;
        this.hosts = new HashSet<>();
    }

    public FileInfo(String name, int size, Host host) {
        this(name, size);
        this.hosts.add(host);
    }

    public FileInfo(File file) {
        this(file.getName(), (int) file.length());
    }

    public String getName() {
        return name;
    }

    public int getSize() {
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
        return this.name + " (" + Utils.byteToUnit(size) + ") : " +
                this.hosts.size() + (this.hosts.size() > 1 ? " hosts" : " host");
    }
}