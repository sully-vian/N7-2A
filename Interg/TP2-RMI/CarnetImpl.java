import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.Map;

/**
 * La classe d'un serveur.
 */
public class CarnetImpl extends UnicastRemoteObject implements Carnet {

    private Map<String, RFiche> personnes;
    private Carnet carnetVoisin;
    public static final int PORT = 4000;

    public static void main(String[] args) {

        try {

            Carnet carnet1 = new CarnetImpl();
            Carnet carnet2 = new CarnetImpl();

            carnet1.setCarnetVoisin(carnet2);
            carnet2.setCarnetVoisin(carnet1);
            Registry registry = LocateRegistry.createRegistry(PORT);
            registry.rebind("Carnet1", carnet1);
            registry.rebind("Carnet2", carnet2);
        } catch (RemoteException e) {
            System.err.println(e.toString());
        }
    }

    public CarnetImpl() throws RemoteException {
        super();
        this.personnes = new HashMap<>();
    }

    public void setCarnetVoisin(Carnet carnetVoisin) {
        this.carnetVoisin = carnetVoisin;
    }

    public void ajouter(SFiche sf) throws RemoteException {
        System.out.println("Ajout de " + sf.getNom());
        RFiche rf = new RFicheImpl(sf.getNom(), sf.getEmail());
        this.personnes.put(sf.getNom(), rf);

        System.out.println(this.personnes);
    }

    public RFiche consulter(String n, boolean forward) throws RemoteException {
        RFiche rf;
        if ((rf = this.personnes.get(n)) == null && forward) {
            rf = this.carnetVoisin.consulter(n, false);
        }
        return rf;
    }
}
