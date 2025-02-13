import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Analyser des données d'un fichier, une donnée par ligne avec 4 informations
 * séparées par des blancs : x, y, ordre (ignorée), valeur.
 */
public class Analyseur {
	/** Conserve la somme des valeurs associées Ã  une position. */
	private Map<Position, Double> cumuls;

	/** Construire un analyseur vide. */
	public Analyseur() {
		cumuls = new HashMap<>();
	}

	/** Charger l'analyseur avec les données du fichier fileName. */
	public void charger(String fileName) throws MalformedFileException, InvalideValueException {
		Map<Position, Double> tempCumuls = new HashMap<>();
		try (BufferedReader in = new BufferedReader(new FileReader(fileName))) {
			String ligne = null;
			while ((ligne = in.readLine()) != null) {
				String[] mots = ligne.split("\\s+");
				if (mots.length != 4) { // 4 mots sur chaque ligne
					throw new MalformedFileException("Le fichier " + fileName
							+ " ne correspond pas au format 1.");
				}
				int x = Integer.parseInt(mots[0]);
				int y = Integer.parseInt(mots[1]);
				Position pos = new Position(x, y);
				double valeur = Double.parseDouble(mots[3]);
				if (valeur < 0) {
					throw new InvalideValueException("Interruption du chargement du fichier " +
							fileName + " (" + valeur + " < " + 0 + ")");
				}
				tempCumuls.put(pos, valeur(pos) + valeur);
				// p.setY(p.getY() + 1); // p.y += 1;
			}
			for (Position pos : tempCumuls.keySet()) {
				cumuls.put(pos, valeur(pos));
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Charger l'analyseur avec les données du fichier fileName de format -f2.txt.
	 */
	public void chargerF2(String fileName) throws MalformedFileException, InvalideValueException {
		Map<Position, Double> tempCumuls = new HashMap<>();
		try (BufferedReader in = new BufferedReader(new FileReader(fileName))) {
			String ligne = null;
			while ((ligne = in.readLine()) != null) {
				String[] mots = ligne.split("\\s+");
				if (mots.length != 6) { // 6 mots sur chaque ligne
					throw new MalformedFileException("Le fichier " + fileName
							+ " ne correspond à aucun format.");
				}
				int x = Integer.parseInt(mots[1]);
				int y = Integer.parseInt(mots[2]);
				Position pos = new Position(x, y);
				double valeur = Double.parseDouble(mots[4]);
				if (valeur < 0) {
					throw new InvalideValueException(
							"Interruption du chargement du fichier ("
									+ valeur + " < " + 0 + ")");
				}
				tempCumuls.put(pos, valeur(pos) + valeur);
				// p.setY(p.getY() + 1); // p.y += 1;
			}
			for (Position pos : tempCumuls.keySet()) {
				cumuls.put(pos, valeur(pos));
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/** Obtenir la valeur associée à une position. */
	public double valeur(Position position) {
		Double valeur = cumuls.get(position);
		return valeur == null ? 0.0 : valeur;
	}

	/** Obtenir toutes les données. */
	public Map<Position, Double> donnees() {
		return Collections.unmodifiableMap(this.cumuls);
	}

	/** Affichier les données. */
	public static void main(String[] args) {
		Analyseur a = new Analyseur();
		for (String fileName : args) {
			System.out.println("Chargement de " + fileName + "...");
			try {
				try {
					a.charger(fileName);
				} catch (MalformedFileException dummy) {
					a.chargerF2(fileName);
				}
			} catch (MalformedFileException e) {
				System.out.println(e.getMessage());
				System.out.println("Poursuite de l'exécution...");
			} catch (InvalideValueException e) {
				System.out.println(e.getMessage());
				System.out.println("Poursuite de l'exécution...");
			}
			System.out.println("");
		}
		System.out.println(a.donnees());
		System.out.println("Nombres de positions : " + a.donnees().size());
	}
}
