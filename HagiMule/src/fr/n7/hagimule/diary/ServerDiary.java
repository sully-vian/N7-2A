package fr.n7.hagimule.diary;

import java.rmi.RemoteException;

/**
 * Interface de l'annuaire tel qu'il est vu par le serveur.
 * <p>
 * Permet des opérations spécifiques au serveur.
 */
interface ServerDiary extends Diary {

    /**
     * Met à jour le compte à rebours de tous les hôtes (décrémente de 1).
     * <p>
     * À appeler chaque seoconde.
     *
     * @throws RemoteException
     */
    void updateHostTimers() throws RemoteException;
}