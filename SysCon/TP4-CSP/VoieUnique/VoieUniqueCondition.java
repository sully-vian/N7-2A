// Time-stamp: <06 jui 2023 11:59 Philippe Queinnec>

import java.security.Guard;

import CSP.*;

/** Réalisation de la voie unique avec des canaux JCSP. */
/* Version avec condition d'acceptation */
public class VoieUniqueCondition implements VoieUnique {

    enum ChannelId {
        EntrerNS, EntrerSN, Sortir
    };

    private Channel<ChannelId> entrerNS;
    private Channel<ChannelId> entrerSN;
    private Channel<ChannelId> sortir;

    public VoieUniqueCondition() {
        this.entrerNS = new Channel<>(ChannelId.EntrerNS);
        this.entrerSN = new Channel<>(ChannelId.EntrerSN);
        this.sortir = new Channel<>(ChannelId.Sortir);
        (new Thread(new Scheduler())).start();
    }

    public void entrer(Sens sens) {
        System.out.println("In  entrer " + sens);
        switch (sens) {
            case NS:
                entrerNS.write(true);
                break;
            case SN:
                entrerSN.write(true);
                break;
        }
        System.out.println("Out entrer " + sens);
    }

    public void sortir(Sens sens) {
        System.out.println("In  sortir " + sens);
        sortir.write(true);
        System.out.println("Out sortir " + sens);
    }

    public String nomStrategie() {
        return "Condition";
    }

    /****************************************************************/

    class Scheduler implements Runnable {
        private int nbNS = 0;
        private int nbSN = 0;
        private int nbMax = 3;

        public void run() {
            GuardedChannel<ChannelId> gEntrerNS = new GuardedChannel<>(entrerNS, () -> (nbNS < 3 && nbSN == 0));
            GuardedChannel<ChannelId> gEntrerSN = new GuardedChannel<>(entrerSN, () -> (nbSN < 3 && nbNS == 0));
            GuardedChannel<ChannelId> gSortir = new GuardedChannel<>(sortir);
            Alternative<ChannelId> alt = new Alternative<>(gEntrerNS, gEntrerSN, gSortir);
            while (true) {
                switch (alt.select()) {
                    case EntrerNS:
                        gEntrerNS.read();
                        nbNS++;
                        break;
                    case EntrerSN:
                        gEntrerSN.read();
                        nbSN++;
                        break;
                    case Sortir:
                        gSortir.read();
                        if (nbSN == 0) {
                            nbNS--;
                        } else {
                            nbSN--;
                        }
                        break;
                }
            }
        }
    } // class Scheduler
}
