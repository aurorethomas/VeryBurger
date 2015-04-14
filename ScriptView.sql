
-- Liste des employés 
SET serveroutput ON;

CREATE VIEW vueUser AS
SELECT *
FROM USERS 
WITH CHECK OPTION;


-- Affichage des détails d'un menu
CREATE VIEW detailsMenu AS
SELECT quantity, label_type
FROM elementmenu JOIN typerecipe ON(id_recipe_type = id_type);
ORDER BY label_type ASC;


-- La carte pure et simple avec les prix des plats à l'unité et des menus.
CREATE VIEW cartedetailsPrix AS 
SELECT name_menu, price_menu, name_recipe, price_menu
FROM menu, recipe, 




--Nombre de commandes/sandwichs effectuées par tel ou tel employe
