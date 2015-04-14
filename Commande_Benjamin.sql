--Création de commandes (orders)

--IMPORTANT: CE SCRIPT N'A PAS ENCORE ETE TESTE!

--Créateur: Benjamin



SET serveroutput ON;

-- Création d'un séquence pour les id_orders
CREATE SEQUENCE seq_commande;

--Création séquence pour les menuorder
CREATE SEQUENCE seq_menuorder;

-- la variable utilisateur désigne l'id_user de la personne
-- utilisant la machine 


--PASSE AU COMPILATEUR, NON TESTEE AVEC DES DONNEES
CREATE PROCEDURE new_order (utilisateur NUMBER) IS
BEGIN
	INSERT INTO ORDERS(id_order,id_user)
	VALUES (seq_commande.NEXTVAL,utilisateur);
END;

--Fonction ajoutant des plats à la commande
-- nb représente le nombre de plats

--On ajoute plat par plat

--PASSE AU COMPILATEUR, NON TESTEE AVEC DES DONNEES

CREATE OR REPLACE PROCEDURE ajout_recette_order (nb NUMBER,plat NUMBER)IS
prix NUMBER;
BEGIN
	SELECT price INTO prix 
	FROM RECIPE 
	WHERE id_recipe=plat;
	
	INSERT INTO RECIPEORDER(id_order,id_recipe,qte,unit_price)
	VALUES(seq_commande.CURRVAL,plat,nb,prix*nb);
END;
--Ajout d'un menu

CREATE OR REPLACE PROCEDURE ajout_menu_order (menu NUMBER) IS
id NUMBER;
BEGIN
	INSERT INTO MENUORDER (id_menu_order,id_order,id_menu)
	VALUES(seq_menuorder.NEXTVAL,seq_commande.CURRVAL,menu);
	
	INSERT INTO RECIPEORDER(id_order,id_menu_order)
	VALUES (seq_commande.CURRVAL,seq_menuorder.CURRVAL);
	
	FOR id	IN (SELECT COUNT id_recipe FROM RECIPE WHERE )
	LOOP
		instructions;
	END LOOP;
	
END;

--Affichage de la commande

-- Supression d'une commande
DELETE FROM ORDERS
where id_order=seq_commande.CURRVAL();

--Affichage des Stock

--PASSE AU COMPILATEUR, NON TESTEE AVEC DES DONNEES
CREATE OR REPLACE PROCEDURE affichage_stock IS
	nom INGREDIENT.name%type;
	quantite PURCHASE.quantite_ingredient%type;
	quantity INGREDIENT.quantity_label%type;
	Cursor Curseur_stock IS
		SELECT nom, quantite_ingredient,quantity_label
		FROM PURCHASE JOIN INGREDIENT ON PURCHASE.id_ingredient=INGREDIENT.id_ingredient;
BEGIN
	OPEN Curseur_stock;
	LOOP
		FETCH Curseur_stock INTO nom,quantite,quantity;
		EXIT WHEN Curseur_stock%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Ingrédient : ' || nom || '  ' || quantite || '   ' || quantity );
	END LOOP;
	CLOSE Curseur_stock;
END;

--Réapprovisionnement d'un ingrédient

--Ajout/supression employés, login employés

CREATE PROCEDURE login (nom STRING, id NUMBER)  IS
boolean ok;
BEGIN
	
	
--Nettoyage

DROP SEQUENCE seq_commande;
DROP SEQUENCE seq_menuorder;
DROP PROCEDURE affichage_stock;
DROP PROCEDURE new_order;
DROP PROCEDURE ajout_recette_order;
DROP PROCEDURE ajout_menu_order;
