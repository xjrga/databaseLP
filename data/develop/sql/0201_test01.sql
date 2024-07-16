SET SCHEMA LP2;
/
CREATE PROCEDURE test01 (
)
MODIFIES SQL DATA DYNAMIC RESULT SETS 2
--
BEGIN ATOMIC
--
DECLARE v_geq INT;
DECLARE v_leq INT;
DECLARE v_eq INT;
DECLARE v_objective_coeffs DOUBLE ARRAY;
DECLARE v_constraint0_coeffs DOUBLE ARRAY;
DECLARE v_constraint0_amount DOUBLE;
DECLARE v_constraint1_coeffs DOUBLE ARRAY;
DECLARE v_constraint1_amount DOUBLE;
--
DECLARE solutionCost CURSOR FOR SELECT LP2.getSolutionCost() as SolutionCost FROM (VALUES(0));
DECLARE solutionPoint CURSOR FOR SELECT LP2.getSolutionPoint() as SolutionPoint FROM (VALUES(0));
--
SET v_geq = 1;
SET v_leq = 2;
SET v_eq = 3;
SET v_objective_coeffs = ARRAY[.002,.004];
SET v_constraint0_coeffs = ARRAY[.09,.04];
SET v_constraint0_amount = 40;
SET v_constraint1_coeffs = ARRAY[-2,1];
SET v_constraint1_amount = 0;

CALL LP2.addLinearObjectiveFunction(v_objective_coeffs);
--
CALL LP2.addLinearConstraint(v_constraint0_coeffs, v_geq, v_constraint0_amount);
--
CALL LP2.addLinearConstraint(v_constraint1_coeffs, v_eq, v_constraint1_amount);
--
CALL LP2.solve();
--
OPEN solutionCost;
OPEN solutionPoint;
--
CALL LP2.clean();
--
END;
/
call test01();
/
