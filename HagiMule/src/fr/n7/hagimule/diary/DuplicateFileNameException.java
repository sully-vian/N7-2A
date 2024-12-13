package fr.n7.hagimule.diary;

/**
 * Exception lancée lorsqu'un fichier de même nom mais de taille différente est
 * ajouté à un annuaire.
 */
public class DuplicateFileNameException extends Exception {

    public DuplicateFileNameException(String message) {
        super(message);
    }
}