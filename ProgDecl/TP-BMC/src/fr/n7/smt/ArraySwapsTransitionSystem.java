package fr.n7.smt;

import com.microsoft.z3.ArrayExpr;
import com.microsoft.z3.BoolExpr;
import com.microsoft.z3.BoolSort;
import com.microsoft.z3.Context;
import com.microsoft.z3.Expr;
import com.microsoft.z3.IntSort;
import com.microsoft.z3.Model;

/**
 * A transition system representing swaps of an array. The state of the
 * transition system is represented by a Z3 array containing integer
 * values.
 *
 * @author Christophe Garion
 */
public class ArraySwapsTransitionSystem extends TransitionSystem {

    private final int MAX_STEPS = 3;
    private Context context;
    private int length;
    private int[] values;
    private ArrayExpr<IntSort, IntSort>[] arrays;

    /**
     * <pre>
     * actions[1][8][6]
     * </pre>
     *
     * veut dire que l’on va échanger les cases d’indices 8 et 6 en étape 2.
     */
    private BoolExpr[][][] actions;

    // as Java does not support arrays of generic types, we suppress
    // corresponding warnings
    @SuppressWarnings("unchecked")
    public ArraySwapsTransitionSystem(int length,
            int values[]) {
        // init attributes
        this.context = Z3Utils.getZ3Context();
        this.length = length;
        this.values = values;

        // taille 4 car état initial et après chaque swap
        this.arrays = new ArrayExpr[4];

        // init this.arrays components
        for (int i = 0; i < this.arrays.length; i++) {
            this.arrays[i] = this.context.mkArrayConst("array" + i,
                    this.context.getIntSort(),
                    this.context.getIntSort());
        }

        // init actions
        this.actions = new BoolExpr[MAX_STEPS][this.length][this.length];

        // init this.actions components
        for (int s = 0; s < MAX_STEPS; s++) {
            for (int i = 0; i < this.length; i++) {
                for (int j = 0; j < this.length; j++) {
                    this.actions[s][i][j] = this.context.mkBoolConst(
                            "swap_" + s + "_" + i + "_" + j);
                }
            }
        }
    }

    @Override
    public BoolExpr initialStateFormula() {
        // arrays[0] vaut "values"
        BoolExpr init = context.mkTrue();
        for (int i = 0; i < this.length; i++) {
            Expr<IntSort> selected = context.mkSelect(arrays[0], context.mkInt(i));
            BoolExpr eq = context.mkEq(context.mkInt(values[i]), selected);
            init = context.mkAnd(init, eq);
        }
        return init;
    }

    @Override
    public BoolExpr finalStateFormula(int step) {
        // si pas dernière étape, on ne fait rien
        if (step != MAX_STEPS - 1) {
            return null;
        }

        // return true if the array is sorted
        BoolExpr finalState = context.mkTrue();
        for (int i = 0; i < this.length - 1; i++) {
            Expr<IntSort> selected1 = context.mkSelect(arrays[step], context.mkInt(i));
            Expr<IntSort> selected2 = context.mkSelect(arrays[step], context.mkInt(i + 1));
            BoolExpr eq = context.mkLe(selected1, selected2);
            finalState = context.mkAnd(finalState, eq);
        }
        return finalState;
    }

    /**
     * Renvoie une formule Z3 représentant les contraintes de transition
     * entre l'étape s et l'étape s+1.
     * C'est à dire que action[s][i][j] <==> swap(s, i, j)
     * et que l'on doit choisir exactement une action à chaque étape.
     */
     @Override
    public BoolExpr transitionFormula(int step) {
        BoolExpr oneSwap = this.oneSwap(step);

        BoolExpr transition = context.mkTrue();
        for (int i = 0; i < this.length; i++) {
            for (int j = 0; j < this.length; j++) {
                // on ne fait pas d'échange sur la même case
                if (i != j) {
                    transition = context.mkAnd(transition,
                            context.mkImplies(actions[step][i][j],
                                    swap(step, i, j)));
                }
            }
        }
        transition = context.mkAnd(transition, oneSwap);
        return transition;
    }

    /**
     * Renvoie une formule Z3 représentant les contraines pour la transition à
     * l'étape s lorsque l'on échange les indices i et j.
     * C'est à dire que le tableau à l'étape s+1 est le même que celui à l'étape s
     * sauf pour les indices i et j qui sont échangés.
     */
    private BoolExpr swap(int s, int i, int j) {
        BoolExpr swap = context.mkTrue();

        for (int k = 0; k < this.length; k++) {
            if (k != i && k != j) {
                Expr<IntSort> selected1 = context.mkSelect(arrays[s], context.mkInt(k));
                Expr<IntSort> selected2 = context.mkSelect(arrays[s + 1], context.mkInt(k));
                swap = context.mkAnd(swap, context.mkEq(selected1, selected2));
            }
        }

        // on échange les cases i et j
        Expr<IntSort> selected1 = context.mkSelect(arrays[s], context.mkInt(i));
        Expr<IntSort> selected2 = context.mkSelect(arrays[s], context.mkInt(j));
        Expr<IntSort> selected3 = context.mkSelect(arrays[s + 1], context.mkInt(i));
        Expr<IntSort> selected4 = context.mkSelect(arrays[s + 1], context.mkInt(j));

        swap = context.mkAnd(swap,
                context.mkEq(selected1, selected4),
                context.mkEq(selected2, selected3));
        return swap;
    }

    /**
     * Renvoie une formule Z3 représenntant la crontrainte exprimant le fait qu'on
     * doive choisir exactement une action à l'étape s.
     */
    private BoolExpr oneSwap(int s) {
        return context.mkAnd(atLeastOne(s), atMostOne(s));
    }

    /**
     * Renvoie une formule Z3 représenntant la crontrainte exprimant le fait qu'on
     * doive choisir au moins une action à l'étape s.
     */
    private BoolExpr atLeastOne(int s) {
        BoolExpr atLeastOne = context.mkFalse();
        for (int i = 0; i < this.length; i++) {
            for (int j = 0; j < this.length; j++) {
                atLeastOne = context.mkOr(atLeastOne, actions[s][i][j]);
            }
        }
        return atLeastOne;
    }

    /**
     * Renvoie une formule Z3 représenntant la crontrainte exprimant le fait qu'on
     * doive choisir au plus une action à l'étape s.
     */
    private BoolExpr atMostOne(int s) {
        BoolExpr atMostOne = context.mkTrue();
        for (int i = 0; i < this.length; i++) {
            for (int j = 0; j < this.length; j++) {
                for (int k = 0; k < this.length; k++) {
                    for (int l = 0; l < this.length; l++) {
                        if (i != k || j != l) {
                            atMostOne = context.mkAnd(atMostOne,
                                    context.mkImplies(actions[s][i][j],
                                            context.mkNot(actions[s][k][l])));
                        }
                    }
                }
            }
        }
        return atMostOne;
    }

    @Override
    public void printParams() {
        System.out.println("\nArrays swaps transition system parameters:");

        StringBuilder sb = new StringBuilder("");

        sb.append("[ ");

        for (int i = 0; i < this.length; i++) {
            sb.append(this.values[i] + (i != length - 1 ? ", " : ""));
        }

        sb.append(" ]");

        System.out.println("- starting array: " + sb);
    }

    private String arrayToString(ArrayExpr<IntSort, IntSort> array, Model m, int length) {
        StringBuilder sb = new StringBuilder("");

        sb.append("[ ");

        for (int i = 0; i < length; i++) {
            sb.append(m.eval(this.context.mkSelect(array,
                    this.context.mkInt(i)),
                    true) +
                    (i != length - 1 ? ", " : ""));
        }

        sb.append(" ]");

        return sb.toString();
    }

    private String decisionToString(Model m, int step) {
        String decision = null;

        for (int i = 0; i < this.length; i++) {
            for (int j = 0; j < this.length; j++) {
                Expr<BoolSort> interp = m.getConstInterp(actions[step][i][j]);
                if (interp == null) {
                    System.out.println("interp = null");
                } else if (interp.isTrue()) {
                    if (decision == null) {
                        decision = actions[step][i][j].toString();
                    } else {
                        System.err.println("*** Problem: at least two decisions for the same step! ***");
                        System.err.println("   " + decision.toString() + " and " +
                                actions[step][i][j].toString());
                        System.exit(1);
                    }
                }
            }
        }

        return decision;
    }

    @Override
    public void printModel(Model m, int steps) {
        for (int s = 0; s <= MAX_STEPS; s++) {
            System.out.println("  " + s + ". array: " +
                    this.arrayToString(this.arrays[s], m, this.length));
            if (s != MAX_STEPS) {
                System.out.println("     decision: " + this.decisionToString(m, s));
            }
        }
    }
}
