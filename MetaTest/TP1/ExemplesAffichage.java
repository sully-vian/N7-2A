import java.util.Map;

/**
 * Exemples d'affichage d'expressions arithmétiques
 *
 * @author Xavier Crégut
 * @version $Revision$
 */

public class ExemplesAffichage {

	static final private OperateurBinaire plus = new Addition();
	static final private OperateurBinaire fois = new Multiplication();
	static final private OperateurUnaire negation = new Negation();

	static public Expression expression1() {
		return new ExpressionUnaire(negation,
				new ExpressionBinaire(fois,
						new Constante(2),
						new ExpressionBinaire(plus,
								new Constante(1),
								new AccesVariable("x"))));
	}

	static public Expression expression2() {
		return new ExpressionBinaire(plus,
				new Constante(5),
				new ExpressionBinaire(fois,
						new AccesVariable("x"),
						new Constante(4)));
	}

	public static void main(String[] args) {
		AfficheurInfixe infixe = new AfficheurInfixe();
		AfficheurPostfixe postfixe = new AfficheurPostfixe();
		CalculHauteur calculHauteur = new CalculHauteur();
		EvaluateurExpression evaluateurExpression = new EvaluateurExpression(Map.of("x", -2));

		// Infixe
		String e1infixe = expression1().accepter(infixe);
		System.out.println("Infixe: e1 = " + e1infixe);
		String e2infixe = expression2().accepter(infixe);
		System.out.println("Infixe: e2 = " + e2infixe);

		// Postfixe
		String e1postfixe = expression1().accepter(postfixe);
		System.out.println("Postfixe: e1 = " + e1postfixe);
		String e2postfixe = expression2().accepter(postfixe);
		System.out.println("Postfixe: e2 = " + e2postfixe);

		// CalculHauteur
		Integer e1calculHauteur = expression1().accepter(calculHauteur);
		System.out.println("Hauteur: e1 = " + e1calculHauteur);
		Integer e2calculHauteur = expression2().accepter(calculHauteur);
		System.out.println("Hauteur: e2 = " + e2calculHauteur);

		// EvaluateurExpression
		Integer e1evaluateurExpression = expression1().accepter(evaluateurExpression);
		System.out.println("Evaluation: e1 = " + e1evaluateurExpression);
		Integer e2evaluateurExpression = expression2().accepter(evaluateurExpression);
		System.out.println("Evaluation: e2 = " + e2evaluateurExpression);

	}
}
