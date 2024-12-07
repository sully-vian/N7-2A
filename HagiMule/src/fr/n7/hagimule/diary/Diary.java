package fr.n7.hagimule.diary;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.HashSet;

/**
 * Annuaire.
 * <p>
 * Enregistre les fichiers des clients connectés.
 * <p>
 * Accessible par RMI.
 */
public interface Diary extends Remote {

    /**
     * Renvoie la liste des fichiers de l'annuaire.
     *
     * @return la liste des fichiers de l'annuaire
     * @throws RemoteException
     */
    HashSet<String> getFiles() throws RemoteException;

    /**
     * Renvoie la liste des hôtes ayant le fichier donné.
     *
     * @param file le fichier.
     * @return la liste des adresses des hôtes ayant le fichier donné, vide si le
     *         fichier n'est pas répertorié.
     * @throws RemoteException
     */
    HashSet<String> getHosts(String file) throws RemoteException;

    /**
     * Ajoute un hôte à la liste des hôtes ayant le fichier donné.
     *
     * @param file le fichier
     * @param host l'adresse de l'hôte hébergeant le fichier
     * @throws RemoteException
     */
    void addHost(String file, String host) throws RemoteException;

    /**
     * Supprime un hôte de la liste des hôtes ayant le fichier donné.
     * Ne fait rien si le fichier n'existe pas ou si l'hôte n'est pas dans la liste.
     *
     * @param file le fichier
     * @param host l'adresse de l'hôte hébergeant le fichier
     * @throws RemoteException
     */
    void removeHost(String file, String host) throws RemoteException;
}