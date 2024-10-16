import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/**
 * Lecteurs/rédacteurs
 * stratégie d'ordonnancement: équitable (absence de famine),
 * implantation: avec un moniteur.
 */
public class LectRed_Equitable implements LectRed {

    private Lock moniteur = new ReentrantLock();
    private Condition accesLecture; // file acces lecture
    private Condition accesEcriture; // file acces écriture
    private int nbLecteurs; // nb lecteurs lisant
    private int nbEcrivains; // nb écrivains écrivant
    private int nbLecteursEnAttente;
    private int nbEcrivainsEnAttente;

    public LectRed_Equitable() {
        accesLecture = moniteur.newCondition();
        accesEcriture = moniteur.newCondition();
        nbLecteurs = 0;
        nbEcrivains = 0;
        nbLecteursEnAttente = 0;
        nbEcrivainsEnAttente = 0;
    }

    public void demanderLecture() throws InterruptedException {
        moniteur.lock();
        // si on met le while,on a attente réciproque pour une demande de chaque type qui se regardent
        if ((nbEcrivains > 0) || (nbEcrivainsEnAttente > 0)) {
            nbLecteursEnAttente++;
            accesLecture.await();
            nbLecteursEnAttente--;
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
        if ((nbLecteurs > 0) || (nbEcrivains > 0)) {
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
        if (nbLecteursEnAttente > 0) {
            accesLecture.signal();
        } else {
            accesEcriture.signal();
        }
        moniteur.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Équitable";
    }
}
