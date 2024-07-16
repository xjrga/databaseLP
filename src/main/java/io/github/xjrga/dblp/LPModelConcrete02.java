package io.github.xjrga.dblp;

import java.sql.Array;
import java.util.ArrayList;
import org.apache.commons.math3.optim.OptimizationData;
import org.apache.commons.math3.optim.PointValuePair;
import org.apache.commons.math3.optim.linear.LinearConstraint;
import org.apache.commons.math3.optim.linear.LinearConstraintSet;
import org.apache.commons.math3.optim.linear.LinearObjectiveFunction;
import org.apache.commons.math3.optim.linear.NonNegativeConstraint;
import org.apache.commons.math3.optim.linear.Relationship;
import org.apache.commons.math3.optim.linear.SimplexSolver;
import org.apache.commons.math3.optim.nonlinear.scalar.GoalType;
import org.hsqldb.jdbc.JDBCArrayBasic;

/**
 * @author Jorge R Garcia de Alba &lt;jorge.r.garciadealba@gmail.com&gt;
 */
public enum LPModelConcrete02 implements LPModel02 {
  INSTANCE();

  public final int GEQ = 1;
  public final int LEQ = 2;
  public final int EQ = 3;
  private LinearObjectiveFunction linearObjectiveFunction = null;
  private final ArrayList<LinearConstraint> constraints = new ArrayList();
  private double cost = Double.NEGATIVE_INFINITY;
  private double[] point = new double[] {Double.NEGATIVE_INFINITY, Double.NEGATIVE_INFINITY};

  @Override
  public void addLinearObjectiveFunction(double[] coefficients) {
    byte constantTerm = 0;
    linearObjectiveFunction = new LinearObjectiveFunction(coefficients, constantTerm);
  }

  @Override
  public void addLinearConstraint(double[] coefficients, int rel, double amount) {
    constraints.add(new LinearConstraint(coefficients, getRelationship(rel), amount));
  }

  @Override
  public void solve() {
    SimplexSolver s = new SimplexSolver();
    LinearConstraintSet linearConstraintSet = new LinearConstraintSet(constraints);
    NonNegativeConstraint nonNegativeConstraint = new NonNegativeConstraint(true);
    OptimizationData[] data =
        new OptimizationData[] {
          linearObjectiveFunction, linearConstraintSet, GoalType.MINIMIZE, nonNegativeConstraint
        };
    PointValuePair optimize = s.optimize(data);
    point = optimize.getPoint();
    cost = optimize.getSecond();
  }

  @Override
  public void clean() {
    linearObjectiveFunction = null;
    constraints.clear();
    cost = Double.NEGATIVE_INFINITY;
    point = new double[] {Double.NEGATIVE_INFINITY, Double.NEGATIVE_INFINITY};
  }

  @Override
  public double getSolutionCost() {
    return cost;
  }

  @Override
  public Array getSolutionPoint() {
    return doubleToArray(point);
  }

  private Array doubleToArray(double[] arr) {
    Object[] objects = new Object[arr.length];
    for (int i = 0; i < arr.length; i++) {
      objects[i] = arr[i];
    }
    Array array = new JDBCArrayBasic(objects, org.hsqldb.types.Type.SQL_DOUBLE);
    return array;
  }

  private Relationship getRelationship(int rel) {
    Relationship relationship = null;
    switch (rel) {
      case 1:
        relationship = Relationship.GEQ;
        break;
      case 2:
        relationship = Relationship.LEQ;
        break;
      case 3:
        relationship = Relationship.EQ;
        break;
      default:
        relationship = Relationship.GEQ;
        break;
    }
    return relationship;
  }
}
