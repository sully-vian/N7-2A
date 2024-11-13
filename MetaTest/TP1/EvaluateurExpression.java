import java.util.Map;

/**
 * Évaluateur d'une expression
 *
 * @author Vianney Hervy
 */
public class EvaluateurExpression implements VisiteurExpression<Integer> {

    /**
     * Map de la valeur des variables
     */
    private Map<String, Integer> variables;

    public EvaluateurExpression(Map<String, Integer> variables) {
        this.variables = variables;
    }

    @Override
    public Integer visiterAccesVariable(AccesVariable v) {
        Integer valeur = variables.get(v.getNom());
        if (valeur == null) {
            throw new RuntimeException("Variable non définie :" + v.getNom());
        }
        return valeur;
    }

    @Override
    public Integer visiterConstante(Constante c) {
        return c.getValeur();
    }

    @Override
    public Integer visiterExpressionBinaire(ExpressionBinaire e) {
        OperateurBinaire operateur = e.getOperateur();
        Integer resultatGauche = e.getOperandeGauche().accepter(this);
        Integer resultatDroite = e.getOperandeDroite().accepter(this);

        if (operateur instanceof Addition) {
            return resultatGauche + resultatDroite;
        } else if (operateur instanceof Multiplication) {
            return resultatGauche * resultatDroite;
        } else if (operateur instanceof Soustraction) {
            return resultatGauche - resultatDroite;
        } else {
            throw new RuntimeException("Opérateur inconnu !");
        }
    }

    @Override
    public Integer visiterAddition(Addition a) {
        throw new RuntimeException("Ne pas visiter les opérateur !");
    }

    @Override
    public Integer visiterMultiplication(Multiplication m) {
        throw new RuntimeException("Ne pas visiter les opérateur !");
    }

    @Override
    public Integer visiterSoustraction(Soustraction m) {
        throw new RuntimeException("Ne pas visiter les opérateur !");
    }

    @Override
    public Integer visiterExpressionUnaire(ExpressionUnaire e) {
        if (e.getOperateur() instanceof Negation) {
            return -e.getOperande().accepter(this);
        } else {
            throw new RuntimeException("Opérateur inconnu !");
        }
    }

    @Override
    public Integer visiterNegation(Negation n) {
        throw new RuntimeException("Ne pas visiter les opérateur !");
    }

}
