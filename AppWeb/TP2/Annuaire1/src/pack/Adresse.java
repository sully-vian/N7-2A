package pack;

public class Adresse {

    private static int idCounter = 0;

    private int id;
    private String rue;
    private String ville;

    public Adresse(String rue, String ville) {
        this.id = idCounter++;
        this.rue = rue;
        this.ville = ville;
    }

    public String getRue() {
        return rue;
    }

    public String getVille() {
        return this.ville;
    }

    public int getId() {
        return this.id;
    }
}