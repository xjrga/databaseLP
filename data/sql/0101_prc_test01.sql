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
DECLARE v_constraint2_coeffs DOUBLE ARRAY;
DECLARE v_constraint2_amount DOUBLE;
DECLARE ok BOOLEAN;
--
DECLARE solutionCost CURSOR FOR SELECT LP.getSolutionCost() as SolutionCost FROM (VALUES(0));
DECLARE solutionPoint CURSOR FOR SELECT LP.getSolutionPoint() as SolutionPoint FROM (VALUES(0));
DECLARE solved CURSOR FOR SELECT LP.solved() as solved FROM (VALUES(0));
--
SET v_geq = 1;
SET v_leq = 2;
SET v_eq = 3;
SET v_objective_coeffs = ARRAY[1.7792400000000002,0.30396,1.05214];
SET v_constraint0_coeffs = ARRAY[0.3102,0,0];
SET v_constraint0_amount = 100;
SET v_constraint1_coeffs = ARRAY[1.7792400000000002,0.30396,1.05214];
SET v_constraint1_amount = 2000;
SET v_constraint2_coeffs = ARRAY[0,0.033,0.018];
SET v_constraint2_amount = 40;

CALL LP.addLinearObjectiveFunction(v_objective_coeffs);
--
CALL LP.addLinearConstraint(v_constraint0_coeffs, v_eq, v_constraint0_amount);
--
CALL LP.addLinearConstraint(v_constraint1_coeffs, v_eq, v_constraint1_amount);
--
CALL LP.addLinearConstraint(v_constraint2_coeffs, v_eq, v_constraint2_amount);
--
CALL LP.solve();
--
SET ok = LP.solved();
--
IF ok THEN
--
CALL Message_insert('true');
--
ELSE
--
CALL Message_insert('false');
--
END IF;
--
OPEN solved;
OPEN solutionCost;
OPEN solutionPoint;
--
CALL LP.clean();
--
END;
/