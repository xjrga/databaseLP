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