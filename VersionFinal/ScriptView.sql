-- VIEW du projet veryBurger


CREATE VIEW VUE_AFFICHAGE_COMMANDE AS 
	SELECT name_menu
	FROM menuOrder NATURAL JOIN menu;


-- Test de la vue 
-- SELECT * FROM VUE_AFFICHAGE_COMMANDE;


CREATE VIEW VUE_AFFICHAGE_LISTE_MENU AS
	SELECT id_menu, name_menu, price_menu
	FROM menu;

-- Test de la vue 
-- SELECT * FROM VUE_AFFICHAGE_LISTE_MENU