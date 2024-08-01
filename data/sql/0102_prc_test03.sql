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