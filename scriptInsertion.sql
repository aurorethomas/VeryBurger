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
VALUES (7,'Pain','tranche');

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
--  frites 
INSERT INTO INGREDIENT RECIPE
VALUES(5,4,0.4);

--potatoes
INSERT INTO INGREDIENT RECIPE
VALUES(5,5,0.4);

--hamburger 3

INSERT INTO INGREDIENT RECIPE
VALUES(2,3,1);

INSERT INTO INGREDIENT RECIPE
VALUES(6,3,1);

INSERT INTO INGREDIENT RECIPE
VALUES(7,3,1);

INSERT INTO INGREDIENT RECIPE
VALUES(7,3,1);

--Menu

INSERT INTO MENU (id_menu,name_menu)
VALUES (0,'Le starter');

INSERT INTO MENU (id_menu,name_menu)
VALUES (1,'Le burger');

INSERT INTO MENU (id_menu,name_menu)
VALUES (2,'La frite');


