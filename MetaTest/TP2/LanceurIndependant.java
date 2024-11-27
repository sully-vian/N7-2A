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

        // Récupérer les méthodes "preparer" et "nettoyer"
        Method preparer;
        try {
            preparer = classe.getMethod("preparer");
        } catch (NoSuchMethodException e) {
            preparer = null;
        }
        Method nettoyer;
        try {
            nettoyer = classe.getMethod("nettoyer");
        } catch (NoSuchMethodException e) {
            nettoyer = null;
        }

        // Instancier l'objet qui sera le récepteur des tests
        Object objet;
        try {
            objet = classe.getDeclaredConstructor().newInstance();
        } catch (NoSuchMethodException e) {
            System.err.println("Le constructeur de la classe " + nomClasse + " n'est pas défini.");
            return;
        }

        // Exécuter les méthodes de test
        List<Method> methods = Arrays.stream(classe.getMethods())
                .filter(e -> e.getName().startsWith("tester"))
                .collect(Collectors.toList());

        for (Method methode : methods) {
            if (preparer != null) {
                preparer.invoke(objet);
            }

            try {
                this.nbTestsLances++;
                methode.invoke(objet);
            } catch (InvocationTargetException e) {
                this.nbErreurs++;
            } catch (Echec e) {
                this.nbEchecs++;
            }

            if (nettoyer != null) {
                nettoyer.invoke(objet);
            }
        }
    }

    public static void main(String... args) {
        LanceurIndependant lanceur = new LanceurIndependant(args);
    }

}
