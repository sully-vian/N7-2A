package fr.n7.hagimule.diary;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Map;
import java.util.Set;

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
     * Renvoie la liste des noms des fichiers de l'annuaire.
     *
     * @return la liste des noms des fichiers de l'annuaire
     * @throws RemoteException
     */
    Set<String> getFileNames() throws RemoteException;

    /**
     * Ajoute un fichier à l'annuaire. Si un fichier du même nom existe déjà, l'hôte
     * est ajouté à la liste des hôtes ayant le fichier.
     *
     * @param fileInfo les informations sur le fichier
     * @param host     l'hôte hébergeant le fichier.
     * @throws RemoteException
     */
    void addFileInfo(FileInfo fileInfo, Host host) throws RemoteException;

    /**
     * Supprime un hôte de la liste des hôtes ayant le fichier donné. Ne fait rien
     * si le fichier n'existe pas ou si l'hôte n'est pas dans la liste.
     *
     * @param fileName le nom du fichier.
     * @param host     l'hôte hébergeant le fichier.
     * @throws RemoteException
     */
    void removeHost(String fileName, Host host) throws RemoteException;

    /**
     * Supprime l'hôte de tous les fichiers qu'il héberge.
     *
     * @param host l'hôte à supprimer.
     * @throws RemoteException
     */
    void removeHost(Host host) throws RemoteException;

    /**
     * Renvoie les informations sur le fichier de nom donné.
     *
     * @param fileName le nom du fichier dont on veut les informations.
     * @return les informations sur le fichier de nom donné, ou null si le fichier
     *         n'est pas répertorié.
     * @throws RemoteException
     */
    FileInfo getFileInfo(String fileName) throws RemoteException;

    /**
     * Renvoie les informations sur tous les fichiers répertoriés.
     *
     * @return les informations sur tous les fichiers répertoriés.
     * @throws RemoteException
     */
    Map<String, FileInfo> getContents() throws RemoteException;

    /**
     * Réinitialise le compte à rebours de l'hôte donné à {@value #DEATH_DELAY}
     *
     * @param host l'hôte dont le timer doit être réinitialisé.
     * @throws RemoteException
     */
    void resetHostTimer(Host host) throws RemoteException;

    /**
     * Met à jour le compte à rebours de tous les hôtes (décrémente de 1).
     * <p>
     * À appeler chaque seoconde.
     *
     * @throws RemoteException
     */
    void updateHostTimers() throws RemoteException;
}