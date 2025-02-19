package pack;

import java.util.ArrayList;
import java.util.List;

public class Personne {
    private static int idCounter = 0;

    private int id;
    private String nom;
    private String prenom;
    private List<Adresse> adresses;

    public Personne(String nom, String prenom) {
        this.id = idCounter++;
        this.nom = nom;
        this.prenom = prenom;
        this.adresses = new ArrayList<>();
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public void addAdresse(Adresse adresse) {
        this.adresses.add(adresse);
    }

    public List<Adresse> getAdresses() {
        return this.adresses;
    }

    public int getId() {
        return this.id;
    }
}