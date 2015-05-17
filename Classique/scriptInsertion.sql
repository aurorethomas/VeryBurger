--CREE PAR RADU	
	
	
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
VALUES (7, 'pain', 'unite');
INSERT INTO INGREDIENT
VALUES (8, 'frite', 'kilo');
INSERT INTO INGREDIENT
VALUES (9, 'fanta', 'unite');
INSERT INTO INGREDIENT
VALUES (10, 'Coca-cola', 'unite');
INSERT INTO INGREDIENT
VALUES (11, 'pepsi', 'unite');


--Typerecipe
INSERT INTO TYPERECIPE
VALUES (0, 'boisson');
INSERT INTO TYPERECIPE
VALUES (1, 'sandwich');

-- Recipe
INSERT INTO RECIPE
VALUES (1, 'hamburger1', 5, 1);
INSERT INTO RECIPE
VALUES (2, 'hamburger2',7, 1);
INSERT INTO RECIPE
VALUES (3, 'hamburger3', 6, 1);
INSERT INTO RECIPE
VALUES (4, 'frite', 4, 1);
INSERT INTO RECIPE
VALUES (5, 'potatoes', 4, 1);
INSERT INTO RECIPE
VALUES (6, 'fanta', 5, 0);
INSERT INTO RECIPE
VALUES (7, 'Coca-cola', 5, 0);
INSERT INTO RECIPE
VALUES (8, 'Pepsi', 5, 0);

------IngredientRecipe--------
--boisson
INSERT INTO INGREDIENTRECIPE
VALUES (9,6,1);
INSERT INTO INGREDIENTRECIPE
VALUES (10,7,1);
INSERT INTO INGREDIENTRECIPE
VALUES (11,8,1);

-- Uniquement  pour l'hamburger1
INSERT INTO INGREDIENTRECIPE
VALUES (1,1,2);
INSERT INTO INGREDIENTRECIPE
VALUES (2,1,1);
INSERT INTO INGREDIENTRECIPE
VALUES (3,1,0.1);
INSERT INTO INGREDIENTRECIPE
VALUES (4,1,2);

-- des frites 
INSERT INTO INGREDIENTRECIPE
VALUES(7,4,0.4);

-- Uniquement  pour l'hamburger2
INSERT INTO INGREDIENTRECIPE
VALUES (1,2,2);
INSERT INTO INGREDIENTRECIPE
VALUES (2,2,1);
INSERT INTO INGREDIENTRECIPE
VALUES (3,2,0.1);
INSERT INTO INGREDIENTRECIPE
VALUES (4,2,2);
INSERT INTO INGREDIENTRECIPE
VALUES (6,2,0.1);
INSERT INTO INGREDIENTRECIPE
VALUES (7,2,2);


-- Uniquement  pour l'hamburger3
INSERT INTO INGREDIENTRECIPE
VALUES (1,3,2);
INSERT INTO INGREDIENTRECIPE
VALUES (3,3,0.1);
INSERT INTO INGREDIENTRECIPE
VALUES (6,3,0.1);
INSERT INTO INGREDIENTRECIPE
VALUES (7,3,2);

-- des potatoes
INSERT INTO INGREDIENTRECIPE
VALUES (8,5,1);
INSERT INTO INGREDIENTRECIPE
VALUES (7,5,0.2);
-----fin INGREDIENTRECIPE-------------

--Menu

INSERT INTO MENU 
VALUES (0,'Le starter', 12);
INSERT INTO MENU 
VALUES (1,'Le burger', 13);
INSERT INTO MENU 
VALUES (2,'La frite', 7);


-- elementmenu
INSERT INTO elementmenu
VALUES (1,0,1);
INSERT INTO elementmenu
VALUES (1,1,1);
INSERT INTO elementmenu
VALUES (1,2,1);

--positions
INSERT INTO positions
VALUES (0,'employé') ;
INSERT INTO positions
VALUES (1,'responsable');
INSERT INTO positions
VALUES (2,'directeur');

--users
INSERT INTO users values(0, 'Radu', 'Catalin', 0);
INSERT INTO users values(1, 'Adrian', 'bigAdrian', 2);
INSERT INTO users values(2, 'Luca', 'Rosaz', 1);
INSERT INTO users values(3, 'Philippe', 'Aleixo', 0);
INSERT INTO users values(4, 'Laurence', 'Gandois', 0);

--orders
INSERT INTO orders VALUES(0,0,'01/04/15', '07/04/15');
INSERT INTO orders VALUES(1,3,'05/04/15', '07/04/15');
INSERT INTO orders VALUES(2,2,'07/04/15', '10/04/15');
INSERT INTO orders VALUES(3,0,'15/04/15', '16/04/15');
INSERT INTO orders VALUES(4,4,'17/04/15', '18/04/15');

--purchase 
INSERT INTO purchase values(0, '10-1-2014', '25-12-2014', 2, 10, 'o', 1, 1, 20, '10-5-2015');
INSERT INTO purchase values(1, '1-5-2014', '25-12-2015', 0, 10, 'o', 1, 2, 10, '5-10-2015');
INSERT INTO purchase values(2, '15-7-2014', '2-12-2014', 3, 10, 'o', 4, 3, 25, '10-3-2015');
INSERT INTO purchase values(3, '7-7-2014', '5-2-2015', 2, 10, 'o', 3, 4, 15, '1-2-2015');
INSERT INTO purchase values(4, '21-9-2014', '1-12-2015', 1, 10, 'o', null, 5, 30, '21-5-2015');