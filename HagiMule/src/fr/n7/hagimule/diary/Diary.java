package fr.n7.hagimule.diary;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.HashSet;

import fr.n7.hagimule.Host;

/**
 * Annuaire.
 * <p>
 * Enregistre les fichiers des clients connectés.
 * <p>
 * Accessible par RMI donc les méthodes doivent lever RemoteException et
 * retourner des objets sérialisables.
 */
public interface Diary extends Remote {

    /**
     * Renvoie la liste des fichiers de l'annuaire.
     *
     * @return la liste des fichiers de l'annuaire
     * @throws RemoteException
     */
    HashSet<String> getFileNames() throws RemoteException;

    /**
     * Renvoie la liste des hôtes ayant le fichier donné. null si le fichier n'est
     * pas répertorié.
     *
     * @param file le fichier.
     * @return la liste des adresses des hôtes ayant le fichier donné, vide si le
     *         fichier n'est pas répertorié.
     * @throws RemoteException
     */
    HashSet<Host> getHosts(String file) throws RemoteException;

    /**
     * Ajoute un hôte à la liste des hôtes ayant le fichier donné de la taille
     * donnée.
     * Le fichier est ajouté s'il n'est pas répertorié.
     *
     * @param file     le fichier.
     * @param fileSize la taille du fichier en octets.
     * @param host     l'hôte hébergeant le fichier.
     * @throws RemoteException
     * @throws DuplicateFileNameException si le fichier est déjà répertorié avec une
     *                                    taille différente.
     */
    void addFile(String file, long fileSize, Host host) throws RemoteException, DuplicateFileNameException;

    /**
     * Supprime un hôte de la liste des hôtes ayant le fichier donné.
     * Ne fait rien si le fichier n'existe pas ou si l'hôte n'est pas dans la liste.
     *
     * @param file le fichier
     * @param host l'hôte hébergeant le fichier
     * @throws RemoteException
     */
    void removeHost(String file, Host host) throws RemoteException;

    /**
     * Renvoie la taille du fichier donné.
     *
     * @param file le fichier
     * @return la taille du fichier en octets, ou null si le fichier n'existe pas.
     * @throws RemoteException
     */
    Long getFileSize(String file) throws RemoteException;
}