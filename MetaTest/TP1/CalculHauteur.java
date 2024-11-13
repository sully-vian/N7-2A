/**
 * Calcul de la "hauteur" d'un arbre d'une expression
 * 
 * @author Vianney Hervy
 */
public class CalculHauteur implements VisiteurExpression<Integer> {

    @Override
    public Integer visiterAccesVariable(AccesVariable v) {
        return 1;
    }

    @Override
    public Integer visiterConstante(Constante c) {
        return 1;
    }

    @Override
    public Integer visiterExpressionBinaire(ExpressionBinaire e) {
        return 1 + Math.max(e.getOperandeGauche().accepter(this), e.getOperandeDroite().accepter(this));
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
    public Integer visiterExpressionUnaire(ExpressionUnaire e) {
        return 1 + e.getOperande().accepter(this);
    }

    @Override
    public Integer visiterNegation(Negation n) {
        throw new RuntimeException("Ne pas visiter les opérateur !");
    }

    @Override
    public Integer visiterSoustraction(Soustraction m) {
        throw new RuntimeException("Ne pas visiter les opérateur !");
    }

}
