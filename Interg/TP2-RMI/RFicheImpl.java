import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

/**
 * La classe de l'objet RMI retourné par le serveur.
 */
public class RFicheImpl extends UnicastRemoteObject implements RFiche {

    private String nom;
    private String email;

    public RFicheImpl(String nom, String email) throws RemoteException {
        this.nom = nom;
        this.email = email;
    }

    @Override
    public String getNom() {
        return this.nom;
    }

    @Override
    public String getEmail() {
        return this.email;
    }

    @Override
    public String toString() {
        return " (" + nom + ", " + email + ")";
    }

}
