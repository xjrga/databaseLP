CREATE SCHEMA LinearProgramming;
/
SET SCHEMA LinearProgramming;
/
CREATE PROCEDURE  setNumberOfVariables(IN n INTEGER)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.setNumberOfVariables'
/
CREATE PROCEDURE  setNumberOfConstraints(IN n INTEGER)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.setNumberOfConstraints'
/
CREATE PROCEDURE  clean()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.clean'
/
CREATE PROCEDURE  createModel()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.createModel'
/
CREATE PROCEDURE  addLinearObjectiveFunction(IN storageId INTEGER)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.addLinearObjectiveFunction'
/
CREATE PROCEDURE  addLinearConstraint(IN storageId INTEGER, IN rel INT, IN amount DOUBLE)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.addLinearConstraint'
/
CREATE PROCEDURE  setMaximize()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.setMaximize'
/
CREATE PROCEDURE  solveModel()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.solveModel'
/
CREATE FUNCTION printModel() RETURNS LONGVARCHAR
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.printModel'
/
CREATE PROCEDURE  addCoefficientSpace(IN storageId INTEGER)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.addCoefficientSpace'
/
CREATE PROCEDURE  setCoefficientSpace(IN storageId INTEGER)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.setCoefficientSpace'
/
CREATE PROCEDURE  addCoefficient(IN coefficient DOUBLE)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.addCoefficient'
/
CREATE FUNCTION getSolutionPoint() RETURNS DOUBLE ARRAY
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getSolutionPoint'
/
CREATE FUNCTION getSolutionPointValueAt(IN x INTEGER) RETURNS DOUBLE
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getSolutionPointValueAt'
/
CREATE FUNCTION getSolutionCost() RETURNS DOUBLE
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getSolutionCost'
/
CREATE FUNCTION getVariableCount() RETURNS INTEGER
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getVariableCount'
/
CREATE FUNCTION getConstraintCount() RETURNS INTEGER
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getConstraintCount'
/
CREATE FUNCTION getLhsByConstraint(IN y INTEGER) RETURNS DOUBLE ARRAY
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getLhsByConstraint'
/
CREATE FUNCTION getLhsByVariable(IN x INTEGER) RETURNS DOUBLE ARRAY
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getLhsByVariable'
/
CREATE FUNCTION getLhsValueAt(IN y INTEGER, IN x INTEGER) RETURNS DOUBLE
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getLhsValueAt'
/
CREATE FUNCTION getRhs() RETURNS DOUBLE ARRAY
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getRhs'
/
CREATE FUNCTION getRhsByConstraint(IN y INTEGER) RETURNS DOUBLE
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.linearprogrammingfunctions.LPModelStatic.getRhsByConstraint'
/


