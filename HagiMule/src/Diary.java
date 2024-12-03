/**
 * Annuaire.
 * Enregistre les fichiers des clients connectés.
 * Accessible par RMI.
 */
public interface Diary {

    /**
     * Obtenir la liste des fichiers connus de l'annuaire.
     *
     */
    public void sendFiles();

    /**
     * Obtenir la liste des clients qui possèdent un fichier.
     *
     * @param filename Le nom du fichier.
     */
    public void sendClientIPs(String filename);

    /**
     * Ajouter le client comme seveur d'un fichier.
     *
     * @param filename Le nom du fichier.
     * @param clientIP L'adresse IP du client.
     */
    public void AddEntry(String filename, String clientIP);

    /**
     * Retirer le client comme serveur d'un fichier.
     *
     * @param filename Le nom du fichier.
     * @param clientIP L'adresse IP du client.
     */
    public void removeEntry(String filename, String clientIP);

    /**
     * Écrire le dictonnaire de l'annuaire dans le fichier de sauvegarde.
     */
    public void writeMap();

    /**
     * Lire le dictionnaire de l'annuaire depuis le fichier de sauvegarde.
     */
    public void readMap();
}