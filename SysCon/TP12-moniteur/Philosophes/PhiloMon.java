import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Condition;

/* Squelette d'une solution avec un moniteur.
 * Il manque le moniteur (verrou + variables conditions).
 */
public class PhiloMon implements StrategiePhilo {

    // État d'un philosophe : pense, mange, demande ?
    private EtatPhilosophe[] etat;

    private int nbPhilosophes;

    /****************************************************************/

    public PhiloMon(int nbPhilosophes) {
        this.nbPhilosophes = nbPhilosophes;
        this.etat = new EtatPhilosophe[nbPhilosophes];
        for (int i = 0; i < nbPhilosophes; i++) {
            etat[i] = EtatPhilosophe.Pense;
        }
        /* XXXX */
    }

    public void demanderFourchettes(int no) throws InterruptedException {
        etat[no] = EtatPhilosophe.Demande;

        while ((etat[Main.PhiloGauche(no)] == EtatPhilosophe.Mange) ||
                (etat[Main.PhiloDroite(no)] == EtatPhilosophe.Mange)) {
            // attendre
        }

        etat[no] = EtatPhilosophe.Mange; // manger quand fourchettes libérées
        // j'ai les fourchette G et D
        IHMPhilo.poser(Main.FourchetteGauche(no), EtatFourchette.AssietteDroite);
        IHMPhilo.poser(Main.FourchetteDroite(no), EtatFourchette.AssietteGauche);
    }

    public void libererFourchettes(int no) {
        IHMPhilo.poser(Main.FourchetteGauche(no), EtatFourchette.Table);
        IHMPhilo.poser(Main.FourchetteDroite(no), EtatFourchette.Table);
        etat[no] = EtatPhilosophe.Pense;
        /* XXXX */
    }

    public String nom() {
        return "Moniteur";
    }

}
