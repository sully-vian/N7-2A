package fr.n7.hagimule.diary;

import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.Map;

/**
 * Interface de base de l'annuaire.
 */
public interface Diary extends Remote {

    /**
     * Renvoie les informations sur tous les fichiers répertoriés.
     *
     * @return les informations sur tous les fichiers répertoriés.
     * @throws RemoteException
     */
    Map<String, FileInfo> getContents() throws RemoteException;

}
