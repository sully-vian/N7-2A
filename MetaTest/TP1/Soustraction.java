/**
 * Op�rateur binaire de soustraction.
 *
 * @author Vianney Hervy
 */
public class Soustraction implements OperateurBinaire {

    public <R> R accepter(VisiteurExpression<R> visiteur) {
        return visiteur.visiterSoustraction(this);
    }

}
