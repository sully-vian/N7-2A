// Time-stamp: <11 oct 2024 08:19 Philippe Queinnec>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux lecteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioLecteur implements LectRed
{

    public LectRed_PrioLecteur() {
    }

    public void demanderLecture() throws InterruptedException {
    }

    public void terminerLecture() throws InterruptedException {
    }

    public void demanderEcriture() throws InterruptedException {
    }

    public void terminerEcriture() throws InterruptedException {
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Lecteurs.";
    }
}
