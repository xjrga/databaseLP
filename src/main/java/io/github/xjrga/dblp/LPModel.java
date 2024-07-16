package io.github.xjrga.dblp;

import java.sql.Array;

public interface LPModel {

  void addLinearObjectiveFunction(double[] coefficients);

  void addLinearConstraint(double[] coefficients, int rel, double amount);

  double getSolutionCost();

  Array getSolutionPoint();

  void solve();

  void clean();
}
