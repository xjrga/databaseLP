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