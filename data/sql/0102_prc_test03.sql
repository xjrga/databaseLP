CREATE PROCEDURE test03 (
)
MODIFIES SQL DATA DYNAMIC RESULT SETS 3
--
BEGIN ATOMIC
--
DECLARE v_objective_coeffs DOUBLE ARRAY;
DECLARE ok BOOLEAN;
--
DECLARE solutionCost CURSOR FOR SELECT LP.getSolutionCost() as SolutionCost FROM (VALUES(0));
DECLARE solutionPoint CURSOR FOR SELECT LP.getSolutionPoint() as SolutionPoint FROM (VALUES(0));
DECLARE solved CURSOR FOR SELECT LP.solved() as solved FROM (VALUES(0));
--
SET v_objective_coeffs = ARRAY[1.7792400000000002,0.30396,1.05214];
--
CALL LP.addLinearObjectiveFunction(v_objective_coeffs);
--
FOR SELECT coeffs, relationshipid, q FROM Restriction DO
--
CALL LP.addLinearConstraint(coeffs, relationshipid, q);
--
END FOR;
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