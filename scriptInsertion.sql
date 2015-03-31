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
INSERT INTO INGREDIENT
VALUES (10, 'pain', 'unite');
INSERT INTO INGREDIENT
VALUES (10, 'frite', 'kilo');

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



INSERT INTO users values(0, 'Radu', 'Catalin', 4);
INSERT INTO users values(1, 'Adrian', 'bigAdrian', 2);
INSERT INTO users values(2, 'Luca', 'Rosaz', 0);
INSERT INTO users values(3, 'Philippe', 'Aleixo', 1);
INSERT INTO users values(4, 'Laurence', 'Gandois', 3);



INSERT INTO orders VALUES(0,0,1);
INSERT INTO orders VALUES(1,1,2);
INSERT INTO orders VALUES(2,2,1);
INSERT INTO orders VALUES(3,0,5);
INSERT INTO orders VALUES(4,2,6);

INSERT INTO purchase values(0, '10-1-2014', '25-12-2014', 2, 10, 'o', 1, 20, '10-5-2015');
INSERT INTO purchase values(1, '1-5-2014', '25-12-2015', 0, 10, 'o', 1, 10, '5-10-2015');
INSERT INTO purchase values(2, '15-7-2014', '2-12-2014', 3, 10, 'o', 4, 25, '10-3-2015');
INSERT INTO purchase values(3, '7-7-2014', '5-2-2015', 2, 10, 'o', 3, 15, '1-2-2015');
INSERT INTO purchase values(4, '21-9-2014', '1-12-2015', 1, 10, 'o', 6, 30, '21-5-2015');
