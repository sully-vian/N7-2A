/**
 * Exception levée quand une valeur négative est encontrée dans l'analyseur.
 */
public class MalformedFileException extends Exception {
    public MalformedFileException(String message) {
        super(message);
    }
}
