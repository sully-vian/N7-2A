package fr.n7.hagimule;

import java.io.Serializable;

/**
 * Classe représentant un hôte (adresse et port).
 * <p>
 * Elle est sérialisable pour pouvoir être envoyée par RMI.
 */
public class Host implements Serializable {
    private String address;
    private int port;

    /**
     * Crée un hôte.
     *
     * @param address l'addresse de l'hôte
     * @param port    le port de l'hôte
     */
    public Host(String address, int port) {
        this.address = address;
        this.port = port;
    }

    /**
     * Renvoie l'adresse de l'hôte.
     *
     * @return l'adresse de l'hôte
     */
    public String getAddress() {
        return address;
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
        if (other == null || getClass() != other.getClass()) {
            return false;
        }
        Host otherHost = (Host) other;
        return port == otherHost.port && java.util.Objects.equals(address, otherHost.address);
    }

    /**
     * Renvoie le code de hachage de l'hôte.
     *
     * @return le code de hachage de l'hôte.
     */
    @Override
    public int hashCode() {
        int result = address.hashCode();
        result = 31 * result + port;
        return result;
    }

    /**
     * Renvoie une représentation textuelle de l'hôte de la forme "address:port".
     *
     * @return une représentation textuelle de l'hôte.
     */
    @Override
    public String toString() {
        return this.address + ":" + this.port;
    }
}