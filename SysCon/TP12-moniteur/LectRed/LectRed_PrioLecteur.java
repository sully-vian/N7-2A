// Time-stamp: <11 oct 2024 08:19 Philippe Queinnec>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/**
 * Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux lecteurs,
 * implantation: avec un moniteur.
 */
public class LectRed_PrioLecteur implements LectRed {

    private Lock moniteur = new ReentrantLock();
    private Condition accesLecture; // file acces lecture
    private Condition accesEcriture; // file acces écriture
    private int nbLecteurs; // nb lecteurs lisant
    private int nbEcrivains; // nb écrivains écrivant

    public LectRed_PrioLecteur() {
        accesLecture = moniteur.newCondition();
        accesEcriture = moniteur.newCondition();
        nbLecteurs = 0;
        nbEcrivains = 0;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock();
        while (nbEcrivains > 0) {
            accesLecture.await();
        }
        nbLecteurs++;
        accesLecture.signal(); // réveil en chaîne
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        moniteur.lock();
        nbLecteurs--;
        if (nbLecteurs == 0) {
            accesEcriture.signal();
        }
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        moniteur.lock();
        while ((nbEcrivains > 0) || (nbLecteurs > 0)) {
            accesEcriture.await();
        }
        nbEcrivains++;
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock();
        nbEcrivains--;
        accesLecture.signal();
        moniteur.unlock();
    }


    public String nomStrategie() {
        return "Stratégie: Priorité Lecteurs.";
    }
}
