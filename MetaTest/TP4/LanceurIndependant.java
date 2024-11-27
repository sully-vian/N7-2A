import java.lang.annotation.Annotation;
import java.lang.reflect.*;
import java.util.*;
import java.util.stream.Collectors;

/**
 * L'objectif est de faire un lanceur simple sans utiliser toutes les clases
 * de notre architecture JUnit. Il permet juste de valider la compréhension
 * de l'introspection en Java.
 */
public class LanceurIndependant {
	private int nbTestsLances;
	private int nbErreurs;
	private int nbEchecs;
	private List<Throwable> erreurs = new ArrayList<>();

	public LanceurIndependant(String... nomsClasses) {
		System.out.println();

		// Lancer les tests pour chaque classe
		for (String nom : nomsClasses) {
			try {
				System.out.print(nom + " : ");
				this.testerUneClasse(nom);
				System.out.println();
			} catch (ClassNotFoundException e) {
				System.out.println(" Classe inconnue !");
			} catch (Exception e) {
				System.out.println(" Problème : " + e);
				e.printStackTrace();
			}
		}

		// Afficher les erreurs
		for (Throwable e : erreurs) {
			System.out.println();
			e.printStackTrace();
		}

		// Afficher un bilan
		System.out.println();
		System.out.printf("%d tests lancés dont %d échecs et %d erreurs.\n",
				nbTestsLances, nbEchecs, nbErreurs);
	}

	public int getNbTests() {
		return this.nbTestsLances;
	}

	public int getNbErreurs() {
		return this.nbErreurs;
	}

	public int getNbEchecs() {
		return this.nbEchecs;
	}

	private void testerUneClasse(String nomClasse)
			throws ClassNotFoundException, InstantiationException,
			IllegalAccessException, InvocationTargetException {
		// Récupérer la classe
		Class<?> classe = Class.forName(nomClasse);

		// Récupérer les méthodes "annotées "@Avant" et "@Apres"
		List<Method> MethodesPreparer = Arrays.stream(classe.getMethods())
				.filter(e -> e.isAnnotationPresent(Avant.class))
				.collect(Collectors.toList());

		List<Method> MethodesNettoyer = Arrays.stream(classe.getMethods())
				.filter(e -> e.isAnnotationPresent(Apres.class))
				.collect(Collectors.toList());

		// Instancier l'objet qui sera le récepteur des tests
		Object objet;
		try {
			objet = classe.getDeclaredConstructor().newInstance();
		} catch (NoSuchMethodException e) {
			System.err.println("Le constructeur de la classe " + nomClasse + " n'est pas défini.");
			return;
		}

		// Exécuter les méthods de test
		List<Method> methodesTest = Arrays.stream(classe.getMethods())
				.filter(e -> e.isAnnotationPresent(UnTest.class))
				.filter(e -> e.getAnnotation(UnTest.class).enabled())
				.collect(Collectors.toList());
		System.out.println(methodesTest.size());

		for (Method methode : methodesTest) {
			invoquerMethodes(objet, MethodesPreparer);

			UnTest annotationTest = methode.getAnnotation(UnTest.class);
			invoquerMethodeTest(objet, methode, annotationTest);

			invoquerMethodes(objet, MethodesNettoyer);
		}
	}

	private static void invoquerMethodeTest(Object objet, Method methodeTest, UnTest annotationTest)
			throws IllegalAccessException, IllegalArgumentException {
		if (annotationTest.expected() != UnTest.None.class) {
			try {
				methodeTest.invoke(objet);
			} catch (Throwable e) {
				if (e instanceof annotationTest.expected()) {

				}
			}
		}
	}

	private static void invoquerMethodes(Object objet, List<Method> methodes)
			throws IllegalAccessException, IllegalArgumentException, InvocationTargetException {
		for (Method methode : methodes) {
			methode.invoke(objet);
		}
	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
	}

}
