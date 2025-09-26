package fr.n7.hagimule.client;

import java.rmi.RemoteException;
import java.util.Set;

import fr.n7.hagimule.Host;
import fr.n7.hagimule.diary.Diary;
import fr.n7.hagimule.diary.FileInfo;

/**
 * Interface de l'annuaire tel qu'il est vu par les clients.
 * <p>
 * Ne permet que les opérations spécifiques aux clients.
 */
public interface ClientDiary extends Diary {

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
     * Réinitialise le compte à rebours de l'hôte donné à {@value #DEATH_DELAY}
     * (défini dans l'implémentation).
     *
     * @param host l'hôte dont le timer doit être réinitialisé.
     * @throws RemoteException
     */
    void resetHostTimer(Host host) throws RemoteException;
}