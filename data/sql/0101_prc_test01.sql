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