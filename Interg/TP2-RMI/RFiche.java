import java.rmi.*;

/**
 * L'interface de l'objey RMI retourné lors de la consultation auprès d'un
 * serveur.
 */
public interface RFiche extends Remote {
	public String getNom() throws RemoteException;

	public String getEmail() throws RemoteException;
}
