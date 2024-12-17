import java.rmi.RemoteException;
import java.rmi.Remote;

/**
 * L'interface d'un serveur.
 */
public interface Carnet extends Remote {

	public void setCarnetVoisin(Carnet carnetVoisin) throws RemoteException;

	public void ajouter(SFiche sf) throws RemoteException;

	public RFiche consulter(String n, boolean forward) throws RemoteException;
}
