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
public class LectRed_PrioRedacteur implements LectRed {

    private Lock moniteur = new ReentrantLock();
    private Condition accesLecture; // file acces lecture
    private Condition accesEcriture; // file acces écriture
    private int nbLecteurs; // nb lecteurs lisant
    private int nbEcrivains; // nb écrivains écrivant
    private int nbEcrivainsEnAttente;

    public LectRed_PrioRedacteur() {
        accesLecture = moniteur.newCondition();
        accesEcriture = moniteur.newCondition();
        nbLecteurs = 0;
        nbEcrivains = 0;
        nbEcrivainsEnAttente = 0;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock();
        while ((nbEcrivains > 0) || (nbEcrivainsEnAttente > 0)) {
            accesLecture.await(); // bloquant mais on utilise while pour retester la condition en sortant
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
        while ((nbLecteurs > 0) || (nbEcrivains > 0)) {
            nbEcrivainsEnAttente++;
            accesEcriture.await();
            nbEcrivainsEnAttente--;
        }
        nbEcrivains++;
        moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock();
        nbEcrivains--;
        if (nbEcrivainsEnAttente > 0) {
            accesEcriture.signal(); // les écrivains passent en premier
        } else {
            accesLecture.signal();
        }
        moniteur.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Rédacteurs.";
    }
}
