package pack;

import java.util.ArrayList;
import java.util.Collection;

public class Facade {

    private Collection<Personne> listePersonnes;
    private Collection<Adresse> listeAdresses;

    public Facade() {
        this.listePersonnes = new ArrayList<>();
        this.listeAdresses = new ArrayList<>();
    }

    public void ajoutPersonne(String nom, String prenom) {
        Personne personne = new Personne(nom, prenom);
        this.listePersonnes.add(personne);

    }

    public void ajoutAdresse(String rue, String ville) {
        Adresse adresse = new Adresse(rue, ville);
        this.listeAdresses.add(adresse);
    }

    public Collection<Personne> listePersonnes() {
        return this.listePersonnes;
    }

    public Collection<Adresse> listeAdresses() {
        return this.listeAdresses;
    }

    public void associer(int personneId, int adresseId) {
        Personne personne = this.listePersonnes.stream().filter(p -> p.getId() == (personneId)).findFirst().get();
        Adresse adresse = this.listeAdresses.stream().filter(a -> a.getId() == (adresseId)).findFirst().get();
        personne.addAdresse(adresse);
    }
}