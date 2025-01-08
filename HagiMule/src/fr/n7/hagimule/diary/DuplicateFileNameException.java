package fr.n7.hagimule.diary;

/**
 * Exception jetée lorsqu'un fichier de même nom mais de taille différente est
 * ajouté à un annuaire.
 */
public class DuplicateFileNameException extends Exception {

    /**
     * Crée une exception.
     *
     * @param message le message de l'exception.
     */
    public DuplicateFileNameException(String message) {
        super(message);
    }
}