-- Ingredient
INSERT INTO INGREDIENT
VALUES (1, 'tomate', 'kilo');
INSERT INTO INGREDIENT
VALUES (2, 'steak', 'unite');
INSERT INTO INGREDIENT
VALUES (3, 'salade', 'kilo');
INSERT INTO INGREDIENT
VALUES (4, 'fromage', 'unite');
INSERT INTO INGREDIENT
VALUES (5, 'pomme de terre', 'kilo');
INSERT INTO INGREDIENT
VALUES (6, 'poulet', 'kilo');

-- Recipe
INSERT INTO RECIPE
VALUES (1, 'hamburger1');
INSERT INTO RECIPE
VALUES (2, 'hamburger2');
INSERT INTO RECIPE
VALUES (3, 'hamburger3');
INSERT INTO RECIPE
VALUES (4, 'frite');
INSERT INTO RECIPE
VALUES (5, 'potatoes');

--IngredientRecipe
-- des frites 
INSERT INTO INGREDIENT RECIPE
VALUES(5,4,0.4);

<<<<<<< HEAD
-- Uniquement  pour l'hamburger1
INSERT INTO INGREDIENTRECIPE
VALUES (1,1,2);
INSERT INTO INGREDIENTRECIPE
VALUES (2,1,1);
INSERT INTO INGREDIENTRECIPE
VALUES (3,1,0.1);
INSERT INTO INGREDIENTRECIPE
VALUES (4,1,2);

=======
>>>>>>> origin/master
--Menu

INSERT INTO MENU (id_menu,name_menu)
VALUES (0,'Le starter');
<<<<<<< HEAD
INSERT INTO MENU (id_menu,name_menu)
VALUES (1,'Le burger');
INSERT INTO MENU (id_menu,name_menu)
VALUES (2,'La frite');
=======

INSERT INTO MENU (id_menu,name_menu)
VALUES (1,'Le burger');

INSERT INTO MENU (id_menu,name_menu)
VALUES (2,'La frite');

>>>>>>> origin/master



