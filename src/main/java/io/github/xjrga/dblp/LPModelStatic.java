package io.github.xjrga.dblp;

import java.sql.Array;
import java.sql.SQLException;

/**
 * @author Jorge R Garcia de Alba &lt;jorge.r.garciadealba@gmail.com&gt;
 */
public class LPModelStatic {

  private static final LPModelConcrete INSTANCE = LPModelConcrete.INSTANCE;

  public LPModelStatic() {}

  public static void addLinearObjectiveFunction(Array coefficients) {
    INSTANCE.addLinearObjectiveFunction(toPrimitiveDouble(coefficients));
  }

  public static void addLinearConstraint(Array coefficients, int rel, double amount) {
    INSTANCE.addLinearConstraint(toPrimitiveDouble(coefficients), rel, amount);
  }

  public static void solve() {
    INSTANCE.solve();
  }

  public static Array getSolutionPoint() {
    return INSTANCE.getSolutionPoint();
  }

  public static double getSolutionCost() {
    return INSTANCE.getSolutionCost();
  }

  public static void clean() {
    INSTANCE.clean();
  }

  private static double[] toPrimitiveDouble(Array a) {
    double[] c = null;
    try {
      Object[] o = (Object[]) a.getArray();
      c = new double[o.length];
      for (int i = 0; i < o.length; i++) {
        c[i] = (Double) o[i];
      }
    } catch (SQLException ex) {
      ex.printStackTrace();
    }
    return c;
  }

  public static boolean solved() {
    return INSTANCE.solved();
  }
}
