drop schema lp if exists cascade;
/
create schema lp;
/
set schema lp;
/


create table message
(
        txt longvarchar
);
/
create table relationship
(
        relationshipid integer,
        name longvarchar,
        constraint relationship_primary_key primary key (relationshipid)
);
/
create table restriction
(
        restrictionid integer,
        name longvarchar,
        relationshipid integer,
        q double,
        coeffs double array default array[],
        constraint restriction_primary_key primary key (restrictionid)
);
/

alter table restriction add constraint r1_restriction foreign key (relationshipid) references relationship (relationshipid) on delete set null;
/

create procedure message_insert (
in v_txt longvarchar
)
modifies sql data begin atomic
insert into message (
txt
) values (
v_txt
);
end;
/
create procedure relationship_insert (
in v_relationshipid integer,
in v_name longvarchar
)
modifies sql data begin atomic
insert into relationship (
relationshipid,
name
) values (
v_relationshipid,
v_name
);
end;
/
create procedure restriction_insert (
in v_restrictionid integer,
in v_name longvarchar,
in v_relationshipid integer,
in v_q double,
in v_coeffs double array
)
modifies sql data begin atomic
insert into restriction (
restrictionid,
name,
relationshipid,
q,
coeffs
) values (
v_restrictionid,
v_name,
v_relationshipid,
v_q,
v_coeffs
);
end;
/

CREATE PROCEDURE clean()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.clean'
/
CREATE PROCEDURE addLinearObjectiveFunction(IN c DOUBLE ARRAY)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.addLinearObjectiveFunction'
/
CREATE PROCEDURE addLinearConstraint(IN c DOUBLE ARRAY, IN rel INT, IN amount DOUBLE)
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.addLinearConstraint'
/
CREATE PROCEDURE solve()
NO SQL
LANGUAGE JAVA
PARAMETER STYLE JAVA
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.solve'
/
CREATE FUNCTION getSolutionPoint() RETURNS DOUBLE ARRAY
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.getSolutionPoint'
/
CREATE FUNCTION getSolutionCost() RETURNS DOUBLE
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.getSolutionCost'
/
CREATE FUNCTION solved() RETURNS BOOLEAN
LANGUAGE JAVA DETERMINISTIC NO SQL
EXTERNAL NAME 'CLASSPATH:io.github.xjrga.databaselp.LPModelStatic.solved'
/

create procedure test01 (
)
modifies sql data dynamic result sets 2
--
begin atomic
--
declare v_geq int;
declare v_leq int;
declare v_eq int;
declare v_objective_coeffs double array;
declare v_constraint0_coeffs double array;
declare v_constraint0_amount double;
declare v_constraint1_coeffs double array;
declare v_constraint1_amount double;
declare v_constraint2_coeffs double array;
declare v_constraint2_amount double;
declare ok boolean;
--
declare solutioncost cursor for select lp.getsolutioncost() as solutioncost from (values(0));
declare solutionpoint cursor for select lp.getsolutionpoint() as solutionpoint from (values(0));
declare solved cursor for select lp.solved() as solved from (values(0));
declare solutionpoint_array cursor for select lp.getsolutionpoint() as solutionpoint from (values(0));
declare solutionpoint_table cursor for select c2 as variable, c1 as value from unnest(lp.getsolutionpoint()) with ordinality;
--
set v_geq = 1;
set v_leq = 2;
set v_eq = 3;
set v_objective_coeffs = array[1.7792400000000002,0.30396,1.05214];
set v_constraint0_coeffs = array[0.3102,0,0];
set v_constraint0_amount = 100;
set v_constraint1_coeffs = array[1.7792400000000002,0.30396,1.05214];
set v_constraint1_amount = 2000;
set v_constraint2_coeffs = array[0,0.033,0.018];
set v_constraint2_amount = 40;

call lp.addlinearobjectivefunction(v_objective_coeffs);
--
call lp.addlinearconstraint(v_constraint0_coeffs, v_eq, v_constraint0_amount);
--
call lp.addlinearconstraint(v_constraint1_coeffs, v_eq, v_constraint1_amount);
--
call lp.addlinearconstraint(v_constraint2_coeffs, v_eq, v_constraint2_amount);
--
call lp.solve();
--
set ok = lp.solved();
--
if ok then
--
call message_insert('true');
--
else
--
call message_insert('false');
--
end if;
--
open solved;
open solutioncost;
open solutionpoint_array;
open solutionpoint_table;
--
call lp.clean();
--
end;
/

create procedure test02 (
)
modifies sql data dynamic result sets 2
--
begin atomic
--
declare v_geq int;
declare v_leq int;
declare v_eq int;
declare v_objective_coeffs double array;
declare v_constraint0_coeffs double array;
declare v_constraint0_amount double;
declare v_constraint1_coeffs double array;
declare v_constraint1_amount double;
declare v_constraint2_coeffs double array;
declare v_constraint2_amount double;
declare ok boolean;
--
declare solutioncost cursor for select lp.getsolutioncost() as solutioncost from (values(0));
declare solutionpoint cursor for select lp.getsolutionpoint() as solutionpoint from (values(0));
declare solved cursor for select lp.solved() as solved from (values(0));
declare solutionpoint_array cursor for select lp.getsolutionpoint() as solutionpoint from (values(0));
declare solutionpoint_table cursor for select c2 as variable, c1 as value from unnest(lp.getsolutionpoint()) with ordinality;
--
set v_geq = 1;
set v_leq = 2;
set v_eq = 3;
set v_objective_coeffs = array[1.7792400000000002,0.30396,1.05214];
set v_constraint0_coeffs = array[0.3102,0,0];
set v_constraint0_amount = 100;
set v_constraint1_coeffs = array[1.7792400000000002,0.30396,1.05214];
set v_constraint1_amount = 500;
set v_constraint2_coeffs = array[0,0.033,0.018];
set v_constraint2_amount = 40;

call lp.addlinearobjectivefunction(v_objective_coeffs);
--
call lp.addlinearconstraint(v_constraint0_coeffs, v_eq, v_constraint0_amount);
--
call lp.addlinearconstraint(v_constraint1_coeffs, v_eq, v_constraint1_amount);
--
call lp.addlinearconstraint(v_constraint2_coeffs, v_eq, v_constraint2_amount);
--
call lp.solve();
--
set ok = lp.solved();
--
if ok then
--
call message_insert('true');
--
else
--
call message_insert('false');
--
end if;
--
open solved;
open solutioncost;
open solutionpoint_array;
open solutionpoint_table;
--
call lp.clean();
--
end;
/

create procedure test03 (
)
modifies sql data dynamic result sets 3
--
begin atomic
--
declare v_objective_coeffs double array;
declare ok boolean;
--
declare solutioncost cursor for select lp.getsolutioncost() as solutioncost from (values(0));
declare solutionpoint cursor for select lp.getsolutionpoint() as solutionpoint from (values(0));
declare solved cursor for select lp.solved() as solved from (values(0));
declare solutionpoint_array cursor for select lp.getsolutionpoint() as solutionpoint from (values(0));
declare solutionpoint_table cursor for select c2 as variable, c1 as value from unnest(lp.getsolutionpoint()) with ordinality;
--
set v_objective_coeffs = array[1.7792400000000002,0.30396,1.05214];
--
call lp.addlinearobjectivefunction(v_objective_coeffs);
--
for select coeffs, relationshipid, q from restriction do
--
call lp.addlinearconstraint(coeffs, relationshipid, q);
--
end for;
--
call lp.solve();
--
set ok = lp.solved();
--
if ok then
--
call message_insert('true');
--
else
--
call message_insert('false');
--
end if;
--
open solved;
open solutioncost;
open solutionpoint_array;
open solutionpoint_table;
--
call lp.clean();
--
end;
/

call relationship_insert(1,'>=');
/
call relationship_insert(2,'<=');
/
call relationship_insert(3,'=');
/
--
call restriction_insert(1,'Protein, Complete Protein (g) = 100.0',3,100,array[0.3102,0,0]);
/
call restriction_insert(2,'Energy, Digestible (kcal) = 2000.0',3,2000,array[1.7792400000000002,0.30396,1.05214]);
/
call restriction_insert(3,'Carbohydrates, Fiber (g) = 40.0',3,40,array[0,0.033,0.018]);
/

delete from message;
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


