/*
 Problem:  Chicken, rice and veggies
    Date:  Sunday, July 28, 2024 at 21:22:01

 1) Chicken, broilers or fryers, breast, meat only, cooked, roasted
 2) Broccoli, cooked, boiled, drained, without salt
 3) Rice, brown, medium-grain, cooked
*/

/* Minimize */
min: 
/* Calories */
 +                 1.77924000000000020 X01 +                 0.30396000000000000 X02 +                 1.05214000000000000 X03;
/* Subject To */
/*  1) Protein, Complete Protein (g) = 100.0 */
 +                 0.31020000000000000 X01 +                 0.00000000000000000 X02 +                 0.00000000000000000 X03  =               100.00000000000000000;
/*  2) Energy, Digestible (kcal) = 500.0 */
 +                 1.77924000000000020 X01 +                 0.30396000000000000 X02 +                 1.05214000000000000 X03  =              500.00000000000000000;
/*  3) Carbohydrates, Fiber (g) = 40.0 */
 +                 0.00000000000000000 X01 +                 0.03300000000000000 X02 +                 0.01800000000000000 X03  =                40.00000000000000000;

