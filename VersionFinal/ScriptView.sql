-- VIEW du projet veryBurger

-- affiche tous les menus
CREATE VIEW VUE_AFFICHAGE_COMMANDE AS 
	SELECT name_menu
	FROM menuOrder NATURAL JOIN menu;


-- Test de la vue 
-- SELECT * FROM VUE_AFFICHAGE_COMMANDE;

-- On souhaite afficher uniquement les menus qui sont réalisables, donc pour lesquels ont possède suffisamment d'ingrédient
CREATE OR REPLACE VIEW VUE_AFFICHAGE_LISTE_MENU AS
	SELECT  DISTINCT id_menu, name_menu, price_menu
	FROM menu NATURAL JOIN elementMenu
	WHERE id_recipe_ IN (SELECT id_recipe FROM recipe where id_recipe not in (
  SELECT DISTINCT id_recipe FROM ingredientRecipe
  WHERE id_ingredient IN (
    SELECT id_ingredient
    FROM ingredient
    where id_ingredient not in (
      SELECT id_ingredient 
      from ingredientRecipe NATURAL JOIN ingredient
      WHERE quantity_ingredientRecipe < quantity_ingredient))))
	ORDER BY id_menu;

-- Test de la vue 
-- SELECT * FROM VUE_AFFICHAGE_LISTE_MENU