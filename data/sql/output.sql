DROP SCHEMA LP IF EXISTS CASCADE;
/
CREATE SCHEMA LP;
/
SET SCHEMA LP;
/
CREATE TABLE Message
(
        Txt LONGVARCHAR
);
/
CREATE TABLE Relationship
(
        relationshipId INTEGER,
        name LONGVARCHAR,
        CONSTRAINT Relationship_primary_key PRIMARY KEY (relationshipId)
);
/
CREATE TABLE Restriction
(
        restrictionId INTEGER,
        name LONGVARCHAR,
        relationshipId INTEGER,
        q DOUBLE,
        coeffs DOUBLE ARRAY DEFAULT ARRAY[],
        CONSTRAINT Restriction_primary_key PRIMARY KEY (restrictionId)
);
/

ALTER TABLE Restriction ADD CONSTRAINT R1_Restriction FOREIGN KEY (relationshipId) REFERENCES Relationship (relationshipId) ON DELETE SET NULL;
/

CREATE PROCEDURE Message_insert (
IN v_txt LONGVARCHAR
)
MODIFIES SQL DATA BEGIN ATOMIC
INSERT INTO Message (
txt
) VALUES (
v_txt
);
END;
/
CREATE PROCEDURE Relationship_insert (
IN v_relationshipId INTEGER,
IN v_name LONGVARCHAR
)
MODIFIES SQL DATA BEGIN ATOMIC
INSERT INTO Relationship (
relationshipId,
name
) VALUES (
v_relationshipId,
v_name
);
END;
/
CREATE PROCEDURE Restriction_insert (
IN v_restrictionId INTEGER,
IN v_name LONGVARCHAR,
IN v_relationshipId INTEGER,
IN v_q DOUBLE,
IN v_coeffs DOUBLE ARRAY
)
MODIFIES SQL DATA BEGIN ATOMIC
INSERT INTO Restriction (
restrictionId,
name,
relationshipId,
q,
coeffs
) VALUES (
v_restrictionId,
v_name,
v_relationshipId,
v_q,
v_coeffs
);
END;
/

CREATE PROCEDURE clean()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.clean'
/
CREATE PROCEDURE addLinearObjectiveFunction(IN c DOUBLE ARRAY)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.addLinearObjectiveFunction'
/
CREATE PROCEDURE addLinearConstraint(IN c DOUBLE ARRAY, IN rel INT, IN amount DOUBLE)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.addLinearConstraint'
/
CREATE PROCEDURE solve()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.solve'
/
CREATE FUNCTION getSolutionPoint() RETURNS DOUBLE ARRAY
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.getSolutionPoint'
/
CREATE FUNCTION getSolutionCost() RETURNS DOUBLE
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.getSolutionCost'
/
CREATE FUNCTION solved() RETURNS BOOLEAN
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.dblp.LPModelStatic.solved'
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

CREATE PROCEDURE test02 (
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
SET v_constraint1_amount = 500;
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

call Relationship_insert(1,'>=');
/
call Relationship_insert(2,'<=');
/
call Relationship_insert(3,'=');
/
--
call Restriction_insert(1,'Protein, Complete Protein (g) = 100.0',3,100,ARRAY[0.3102,0,0]);
/
call Restriction_insert(2,'Energy, Digestible (kcal) = 2000.0',3,2000,ARRAY[1.7792400000000002,0.30396,1.05214]);
/
call Restriction_insert(3,'Carbohydrates, Fiber (g) = 40.0',3,40,ARRAY[0,0.033,0.018]);
/

DELETE FROM Message;
/
--pass
call test01();
/
--fail
call test02();
/
--pass
call test03();
/


