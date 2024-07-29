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