-- Ce fichier contiendra toutes les fonctions de la BDD
SET serveroutput ON;

-- Toutes les fonctions en relation avec les commandes sont ici
CREATE OR REPLACE PROCEDURE New_orders (id_utilisateur NUMBER) IS
BEGIN
	INSERT INTO ORDERS(id_order,id_user,total_prize)
	VALUES (sequence_id_orders.NEXTVAL,id_utilisateur,0);
END;

CREATE OR REPLACE PROCEDURE New_menuorder IS
BEGIN
	INSERT INTO MENUORDER (id_menu_order,id_order)
	VALUES (sequence_id_menuorders.NEXTVAL,sequence_id_orders.CURRVAL);
END;

CREATE OR REPLACE PROCEDURE New_recipeorder IS
BEGIN
	INSERT INTO RECIPEORDER (id_recipe_order,id_order)
	VALUES (sequence_id_recipeorders.NEXTVAL,sequence_id_orders.CURRVAL);
END;

CREATE OR REPLACE PROCEDURE Insert_order_date IS
chiffre_sequence_id_orders NUMBER;
BEGIN
	chiffre_sequence_id_orders:=sequence_id_orders.CURRVAL;
	UPDATE ORDERS 
	SET order_date=CURRENT_DATE
	WHERE id_order=chiffre_sequence_id_orders;
END;

CREATE PROCEDURE Nouvelle_commande(id_utilisateur NUMBER) IS
BEGIN
	New_orders(id_utilisateur);
	New_menuorder();
	New_recipeorder();
	Insert_order_date();
END;

CREATE PROCEDURE Mise_à_jour_prix_commande(addition NUMBER) IS
BEGIN 
	UPDATE ORDERS
	SET total_prize=total_prize+addition
	WHERE id_order=sequence_id_orders.CURRVAL;
END;

CREATE FUNCTION Renvoie_prix_recette (id_recette NUMBER) RETURN NUMBER IS
prix_recette NUMBER;
BEGIN
	SELECT price INTO prix_recette
	FROM RECIPE
	WHERE id_recipe=id_recette;
	RETURN prix_recette;
	
END;

CREATE FUNCTION Renvoie_prix_menu (id_menu_entree NUMBER) RETURN NUMBER IS
prix_menu NUMBER;
BEGIN
	SELECT price_menu INTO prix_menu
	FROM MENU
	WHERE id_menu_entree=id_menu;
	RETURN prix_menu;
	
END;

CREATE PROCEDURE Ajouter_recette_commande_courante(quantite_recette NUMBER) IS
prix_à_ajouter NUMBER;
BEGIN
	INSERT INTO RECIPEORDER (id_recipe,qte)
	VALUES (sequence_id_recipeorders.CURRVAL,quantite_recette);
	prix_à_ajouter=renvoie_prix_recette(sequence_id_recipeorders.CURRVAL)*quantite_recette;
	mise_à_jour_prix_commande(prix_à_ajouter);
END;

CREATE PROCEDURE Ajouter_menu_commande_courante() IS
prix_à_ajouter NUMBER;
BEGIN
	INSERT INTO MENUORDER (id_menu_order)
	VALUES (sequence_id_menuorders.CURRVAL);
	prix_à_ajouter=renvoie_prix_recette(sequence_id_menuorders.CURRVAL);
	mise_à_jour_prix_commande(prix_à_ajouter);
END;

CREATE PROCEDURE Delivrer_commande(id_commande NUMBER) IS
BEGIN
	INSERT INTO ORDERS (delivrance_date)
	VALUES(CURRENT_DATE)
	WHERE id_order=id_commande;
END;

CREATE PROCEDURE Renvoie_prix_commande (id_commande) IS
prix_commande ORDERS.total_prize%type;
BEGIN
	SELECT total_prize INTO prix_commande
	FROM ORDERS
	WHERE id_commande=id_order;
END;

CREATE PROCEDURE Affichage_numero_commande (id_commande NUMBER) IS
numero_commande NUMBER;
BEGIN
	SELECT id_order INTO numero_commande
	FROM ORDERS
	WHERE id_order=id_commande;
	DBMS_OUTPUT.PUT_LINE('Numéro de commande : ' || numero_commande || '   ');
END;

CREATE PROCEDURE Affichage_recette_commande (id_commande NUMBER) IS
nom_recette RECIPE.name_recipe%type;
quantite_recette RECIPEORDER.qte%type;
CURSOR liste_recette_commande IS
	SELECT name_recipe,qte
	FROM RECIPEORDER NATURAL JOIN RECIPE
	WHERE id_order=id_commande;
BEGIN
	OPEN liste_recette_commande
	LOOP
		FETCH liste_recette_commande INTO nom_recette,quantite_recette
		EXIT WHEN liste_recette_commande%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(nom_recette || '  X' || quantite_recette)
	END LOOP;
	CLOSE liste_recette_commande
END;
 
CREATE PROCEDURE Affichage_menu_commande (id_commande NUMBER) IS
nom_menu MENU.name_menu%type;
CURSOR liste_menu_commande IS
	SELECT name_menu 
	FROM MENUORDER NATURAL JOIN MENU
	WHERE id_order=id_order;
BEGIN
	OPEN liste_menu_commande
	LOOP
		FETCH liste_menu_commande INTO nom_menu
		EXIT WHEN liste_menu_commande%NOTFOUND;
	END LOOP;
	CLOSE liste_menu_commande;
END;

CREATE PROCEDURE Affichage_commande_recapitulatif (id_commande NUMBER) IS
BEGIN
	Affichage_numero_commande(id_commande);
	DBMS_OUTPUT.PUT_LINE('Listes des plats selectionnés : ');
	Affichage_recette_commande(id_commande);
	DBMS_OUTPUT.PUT_LINE('Listes des menus selectionnés : ');
	Affichage_menu_commande (id_commande);
	DBMS_OUTPUT.PUT_LINE('Total à payer : ');
	Renvoie_prix_commande(id_commande);
END;

-- Fonctions s'occupant de l'affichage des recettes
CREATE PROCEDURE Affichage_nom_recette (id_recette NUMBER) IS
nom_recette RECIPE.name_recipe%type;
BEGIN
	SELECT name_recipe INTO nom_recette
	FROM RECIPE
	WHERE id_recipe=id_recette;
	DBMS_OUTPUT.PUT_LINE(nom_recette);
END;

CREATE PROCEDURE Affichage_ingredients_recette (id_recette NUMBER) IS
nom_ingredient INGREDIENT.name%type;
quantite_ingredient INGREDIENTRECIPE.quantity_ingredient%type;
nom_quantite_ingredient INGREDIENT.quantity_label%type;
CURSOR liste_ingredients_recette
	SELECT name,quantity_ingredient,quantity_label
	FROM INGREDIENT NATURAL JOIN INGREDIENTRECIPE
	WHERE id_recipe=id_recette;
BEGIN
	OPEN liste_ingredient_recette
	LOOP
		FETCH liste_ingredient_recette INTO nom_ingredient,quantite_ingredient,nom_quantite_ingredient
		DBMS_OUTPUT.PUT_LINE(nom_ingredient || '  ' || quantite_ingredient || '  ' || nom_quantite_ingredient);
		EXIT WHEN liste_ingredient_recette%NOTFOUND;
	END LOOP;
	CLOSE liste_ingredient_recette;
END;

CREATE PROCEDURE Affichage_recette_cuisine(id_recette NUMBER) IS
BEGIN
	Affichage_nom_recette(id_recette);
	Affichage_ingredients_recette(id_recette);
END;

	
-- Fonction gérant les stocks
CREATE FUNCTION Total_en_stock_ingrédient (id_ingredient_voulu NUMBER)RETURN NUMBER IS
nombre_ingredient_en_stock PURCHASE.quantite_ingredient%type;
BEGIN
	SELECT SUM(quantite_ingredient) INTO nombre_ingredient_en_stock
	FROM INGREDIENT NATURAL JOIN PURCHASE
	WHERE id_ingredient=id_ingredient_voulu;
	RETURN nombre_ingredient_en_stock;
END;

CREATE PROCEDURE Affichage_stock_ingrédient (id_ingredient_voulu NUMBER) IS
BEGIN
	SELECT name,SUM(quantite_ingredient)
	FROM INGREDIENT NATURAL JOIN PURCHASE
	WHERE id_ingredient=id_ingredient_voulu;
END;

CREATE FUNCTION Ingredient_en_stock_suffisant(id_ingredient NUMBER,quantite_voulue NUMBER) RETURN BOOLEAN IS
en_stock BOOLEAN;
BEGIN
	en_stock=(quantite_voulue>=Total_en_stock_ingrédient(id_ingredient));
	RETURN en_stock;
END;

CREATE FUNCTION Achat_disponible(id_achat) RETURN BOOLEAN IS
nombre_à_transcrire_en_booleen PURCHASE.available%type;
disponible BOOLEAN;
BEGIN
	SELECT available FROM PURCHASE INTO nombre_à_transcrire_en_booleen
	WHERE id_purchase=id_achat;
	IF (nombre_à_transcrire_en_booleen=0) THEN
		disponible=true;
	ELSE
		disponible=false;
	END IF;
	RETURN disponible;
END;

CREATE PROCEDURE Nettoyage_achats() IS
id_achat_à_vérifier PURCHASE.id_purchase%type;
CURSOR liste_achats
	SELECT id_purchase FROM PURCHASE;
BEGIN
	OPEN liste_achats
	LOOP
		FETCH liste_achats INTO id_achat_à_vérifier
		IF !Achat_disponible(id_achat_à_vérifier) THEN
			Supprimer_achat(id_achat_à_vérifier);
		END IF;
		EXIT WHEN liste_achats%NOTFOUND
	END LOOP;
	CLOSE liste_achats;
END;
		
CREATE FUNCTION Nombre_ingredient_Achat(id_achat NUMBER) RETURN NUMBER IS
nombre_ingredient_achat
BEGIN
	SELECT quantite_ingredient INTO nombre_ingredient_achat
	FROM PURCHASE
	WHERE id_purchase=id_achat;
	
	RETURN nombre_ingredient_achat;
END;
		
CREATE FUNCTION Achat_sans_ingredient(id_achat NUMBER) RETURN BOOLEAN IS
BEGIN
	RETURN (Nombre_ingredient_Achat(id_achat)==0);
END;

CREATE PROCEDURE Maj_disponibilité_achats() IS
id_achat_à_vérifier PURCHASE.id_purchase%type;
CURSOR liste_achats
	SELECT id_purchase FROM PURCHASE;
BEGIN
	OPEN liste_achats
	LOOP
		FETCH liste_achats INTO id_achat_à_vérifier
			IF Achat_sans_ingredient(id_achat_à_vérifier) THEN
				Achat_devient_indisponible(id_achat_à_vérifier);
			END IF;
		EXIT WHEN liste_achats%NOTFOUND
	END LOOP;
	CLOSE liste_achats;
END;


CREATE PROCEDURE Achat_devient_indisponible(id_achat NUMBER) IS
BEGIN 
	UPDATE PURCHASE
	SET available:=FALSE
	WHERE id_purchase=id_achat;
END;

CREATE PROCEDURE Supprimer_achat(id_achat) IS
BEGIN
	DELETE FROM PURCHASE WHERE id_purchase=id_achat;
END;

-- Plus l'achat est vieux plus son id est petit
CREATE FUNCTION Renvoie_id_achat_le_plus_ancien_pour_ingredient(id_ingredient_voulu) RETURN NUMBER IS
id_achat_le_plus_ancien NUMBER;
BEGIN
	SELECT MIN(id_purchase) INTO id_achat_le_plus_ancien
	FROM PURCHASE
	WHERE id_ingredient=id_ingredient_voulu;
	RETURN id_achat_le_plus_ancien;
END;

CREATE PROCEDURE Retirer_ingredient_de_lachat(id_achat NUMBER,id_ingredient_à_retirer NUMBER,quantite_à_retirer NUMBER) IS
BEGIN
	UPDATE PURCHASE
	SET quantite_ingredient:=quantite_ingredient-quantite_à_retirer
	WHERE id_purchase=id_achat AND id_ingredient=id_ingredient_à_retirer;
END;

CREATE FUNCTION Achat_peut_supporter_retrait(id_achat NUMBER,quantite_à_retirer NUMBER) RETURN BOOLEAN IS
quantite_stock_achat NUMBER;
BEGIN
	SELECT quantite_ingredient INTO quantite_stock_achat
	FROM PURCHASE
	WHERE id_purchase=id_achat;
	RETURN quantite_stick_achat>=quantite_à_retirer;
END;

CREATE FUNCTION Vide_achat(id_achat) IS
BEGIN
	UPDATE PURCHASE
	SET quantite_ingredient:=0;
	WHERE id_purchase=id_achat;
END;

CREATE FUNCTION Renvoie_reste_à_retirer_après_retrait_achat(id_achat NUMBER, quantite_à_retirer NUMBER) RETURN NUMBER IS
quantite_stock_achat NUMBER;
BEGIN
	SELECT quantite_ingredient INTO quantite_stock_achat
	FROM PURCHASE
	WHERE id_purchase=id_achat;
	RETURN quantite_à_retirer-quantite_stock_achat;
END;

CREATE PROCEDURE Retirer_ingredient_du_stock(id_ingredient_voulu NUMBER,quantite_à_retirer NUMBER) IS
reste_à_retirer NUMBER;
id_achat_plus_vieux NUMBER
BEGIN
	reste_à_retirer:=quantite_à_retirer;
	WHILE (reste_à_retirer!=0) 
	LOOP
		Maj_disponibilité_achats();
		Nettoyage_achats();
		id_achat_plus_vieux:=Renvoie_id_achat_le_plus_ancien_pour_ingredient(id_ingredient_voulu);
		IF (Ingredient_en_stock_suffisant(id_ingredient)) THEN
			IF (Achat_peut_supporter_retrait(id_achat_plus_vieux,reste_à_retirer)) THEN
				Retirer_ingredient_de_lachat(id_achat_plus_vieux,id_ingredient_voulu,reste_à_retirer);
				reste_à_retirer:=0;
			ELSE 
				reste_à_retirer:=Renvoie_reste_à_retirer_après_retrait_achat(id_achat_plus_vieux,reste_à_retirer);
				Vide_achat(id_achat_plus_vieux);
			END IF;
		ELSE
			DBMS_OUTPUT.PUT_LINE('Stock Insuffisant!!!');
			reste_à_retirer:=0;
		END IF;
	END LOOP;
END;

CREATE PROCEDURE Recette_consommee(id_recette) IS
id_ingredient_consomme INGREDIENT.name%type;
quantite_ingredient_consomme INGREDIENTRECIPE.quantity_ingredient%type;
CURSOR liste_ingredients_recette
	SELECT id_ingredient,quantity_ingredient
	FROM INGREDIENT NATURAL JOIN INGREDIENTRECIPE
	WHERE id_recipe=id_recette;
BEGIN
	OPEN liste_ingredient_recette
	LOOP
		FETCH liste_ingredient_recette INTO id_ingredient_consomme,quantite_ingredient_consomme
			Retirer_ingredient_du_stock(id_ingredient_consomme,quantite_ingredient_consomme);
		EXIT WHEN liste_ingredient_recette%NOTFOUND;
	END LOOP;
	CLOSE liste_ingredient_recette
	
END;

CREATE PROCEDURE Affichage_tout_le_stock() IS
BEGIN
	SELECT id_purchase,name,quantite_ingredient
	FROM PURCHASE NATURAL JOIN INGREDIENT;
END;


	

	