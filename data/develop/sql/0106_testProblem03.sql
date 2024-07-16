SET SCHEMA LP1;
/
CREATE PROCEDURE testProblem03 (
)
MODIFIES SQL DATA DYNAMIC RESULT SETS 3
--
BEGIN ATOMIC
--
DECLARE v_geq INT;
DECLARE v_leq INT;
DECLARE v_eq INT;
--
DECLARE solutionPointValueAt CURSOR FOR SELECT LP1.getSolutionPointValueAt(i) as SolutionPoint FROM (SELECT rownum()-1 as i FROM INFORMATION_SCHEMA.Columns) WHERE i < 2;
DECLARE solutionCost CURSOR FOR SELECT LP1.getSolutionCost() as SolutionCost FROM (VALUES(0));
DECLARE solutionModel CURSOR FOR SELECT LP1.printModel() as Model FROM (VALUES(0));
DECLARE solutionPointValue CURSOR FOR SELECT LP1.getSolutionPoint() as SolutionPoint FROM (VALUES(0));
DECLARE LhsByConstraint CURSOR FOR SELECT LP1.getLhsByConstraint(i) as ConstraintRow FROM (SELECT rownum()-1 as i FROM INFORMATION_SCHEMA.Columns) WHERE i < 2;
DECLARE LhsByVariable CURSOR FOR SELECT LP1.getLhsByVariable(i) as ConstraintColumn FROM (SELECT rownum()-1 as i FROM INFORMATION_SCHEMA.Columns) WHERE i < 2;
DECLARE LhsValueAt CURSOR FOR SELECT LP1.getLhsValueAt(y,x) as ConstraintElementValue FROM (SELECT x, y FROM (SELECT rownum() -1 AS x FROM INFORMATION_SCHEMA.Columns WHERE rownum() -1 < 2) a, (SELECT rownum() -1 AS y FROM INFORMATION_SCHEMA.Columns WHERE rownum() -1 < 2) b);
DECLARE Rhs CURSOR FOR SELECT LP1.getRhs() as ConstraintValue FROM (VALUES(0));
DECLARE RhsByConstraint CURSOR FOR SELECT LP1.getRhsByConstraint(i) as ConstraintValue FROM (SELECT rownum()-1 as i FROM INFORMATION_SCHEMA.Columns) WHERE i < 2;
--
SET v_geq = 1;
SET v_leq = 2;
SET v_eq = 3;
--
CALL LP1.createModel();
CALL LP1.setMaximize();
--
CALL LP1.setNumberOfVariables(2);
CALL LP1.setNumberOfConstraints(2);
--
CALL LP1.addCoefficientSpace(0);
CALL LP1.setCoefficientSpace(0);
CALL LP1.addCoefficient(25);
CALL LP1.addCoefficient(30);
CALL LP1.addLinearObjectiveFunction(0);
--
CALL LP1.addCoefficientSpace(1);
CALL LP1.setCoefficientSpace(1);
CALL LP1.addCoefficient(20);
CALL LP1.addCoefficient(30);
CALL  LP1.addLinearConstraint(1,2,690);
--
CALL LP1.addCoefficientSpace(2);
CALL LP1.setCoefficientSpace(2);
CALL LP1.addCoefficient(5);
CALL LP1.addCoefficient(4);
CALL  LP1.addLinearConstraint(2,2,120);
--
CALL LP1.solveModel();
--
OPEN solutionPointValueAt;
OPEN solutionCost;
OPEN solutionModel;
OPEN solutionPointValue;
OPEN LhsByConstraint;
OPEN LhsByVariable;
OPEN LhsValueAt;
OPEN Rhs;
OPEN RhsByConstraint;
--
CALL LP1.clean();
--
END;
/

--drop procedure testProblem03;
--call testProblem03();
