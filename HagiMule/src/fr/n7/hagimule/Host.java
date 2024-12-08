package fr.n7.hagimule;

import java.io.Serializable;

/**
 * Classe représentant un hôte (nom et port).
 * <p>
 * Elle est sérialisable pour pouvoir être envoyée par RMI.
 */
public class Host implements Serializable {
    private String name;
    private int port;

    /**
     * Crée un hôte.
     *
     * @param name le nom de l'hôte
     * @param port le port de l'hôte
     */
    public Host(String name, int port) {
        this.name = name;
        this.port = port;
    }

    /**
     * Renvoie le nom de l'hôte.
     *
     * @return le nom de l'hôte
     */
    public String getName() {
        return name;
    }

    /**
     * Renvoie le port de l'hôte.
     *
     * @return le port de l'hôte
     */
    public int getPort() {
        return port;
    }

    /**
     * Compare cet hôte à un autre.
     *
     * @param other l'hôte à comparer
     * @return true si les hôtes sont égaux, false sinon
     */
    @Override
    public boolean equals(Object other) {
        if (other == this) {
            return true;
        }
        if (!(other instanceof Host)) {
            return false;
        }
        Host otherHost = (Host) other;
        return name.equals(otherHost.name) && port == otherHost.port;
    }

    /**
     * Renvoie une représentation textuelle de l'hôte de la forme "nom:port".
     *
     * @return une représentation textuelle de l'hôte
     */
    @Override
    public String toString() {
        return name + ":" + port;
    }
}