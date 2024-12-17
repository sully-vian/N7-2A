import java.io.Serializable;

/**
 * l'interface de l'objet sérialisable pour l'enregistrement auprès d'un serveur.
 */
public interface SFiche extends Serializable {

	public String getNom();

	public String getEmail();
}
