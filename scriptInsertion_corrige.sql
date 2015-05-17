-- CREE PAR RADU	
	
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


-- Typerecipe
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

-- Menu

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

-- positions
INSERT INTO positions
VALUES (0,'employé') ;
INSERT INTO positions
VALUES (1,'responsable');
INSERT INTO positions
VALUES (2,'directeur');

-- users
INSERT INTO users values(0, 'Radu', 'Catalin', 0);
INSERT INTO users values(1, 'Adrian', 'bigAdrian', 2);
INSERT INTO users values(2, 'Luca', 'Rosaz', 1);
INSERT INTO users values(3, 'Philippe', 'Aleixo', 0);
INSERT INTO users values(4, 'Laurence', 'Gandois', 0);

-- Purchase
-- On met tous les ingrédients à 500 pour le moment, ça sert de plage de test
-- On ne prend pas en compte la date pour le moment seulement les quantités
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(0,1,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(1,2,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(2,3,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(3,4,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(4,5,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(5,6,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(6,7,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(7,8,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(8,9,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(9,10,500);
INSERT INTO purchase(id_purchase,id_ingredient,quantite_ingredient) values(10,11,500);

