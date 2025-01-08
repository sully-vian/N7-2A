package fr.n7.hagimule.client.downloader;

/**
 * Représente un fragment de fichier (fragment + numéro).
 */
public class FragmentData {

    private final int fragmentNumero;
    private final byte[] fragmentData;

    public FragmentData(int fragmentNumero, byte[] fragmentData) {
        this.fragmentNumero = fragmentNumero;
        this.fragmentData = fragmentData;
    }

    public int getNumero() {
        return this.fragmentNumero;
    }

    public byte[] getData() {
        return this.fragmentData;
    }
}