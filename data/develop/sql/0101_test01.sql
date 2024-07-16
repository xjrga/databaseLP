SET SCHEMA LP;
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
DECLARE solutionCost CURSOR FOR SELECT LP.getSolutionCost() as SolutionCost FROM (VALUES(0));
DECLARE solutionPoint CURSOR FOR SELECT LP.getSolutionPoint() as SolutionPoint FROM (VALUES(0));
--
SET v_geq = 1;
SET v_leq = 2;
SET v_eq = 3;
SET v_objective_coeffs = ARRAY[.002,.004];
SET v_constraint0_coeffs = ARRAY[.09,.04];
SET v_constraint0_amount = 40;
SET v_constraint1_coeffs = ARRAY[-2,1];
SET v_constraint1_amount = 0;

CALL LP.addLinearObjectiveFunction(v_objective_coeffs);
--
CALL LP.addLinearConstraint(v_constraint0_coeffs, v_geq, v_constraint0_amount);
--
CALL LP.addLinearConstraint(v_constraint1_coeffs, v_eq, v_constraint1_amount);
--
CALL LP.solve();
--
OPEN solutionCost;
OPEN solutionPoint;
--
CALL LP.clean();
--
END;
/
call test01();
/
