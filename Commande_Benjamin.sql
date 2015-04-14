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

CREATE PROCEDURE new_order (utilisateur NUMBER) IS
BEGIN
	INSERT INTO ORDERS(id_order,id_user)
	VALUES (seq_commande.NEXTVAL,utilisateur);
END;

--Fonction ajoutant des plats à la commande
-- nb représente le nombre de plats

--On ajoute plat par plat

CREATE PROCEDURE ajout_recette_order (nb NUMBER,plat NUMBER)
prix NUMBER;
BEGIN
	SELECT price INTO prix 
	FROM RECIPE 
	WHERE id_recipe=plat;
	
	INSERT INTO RECIPEORDER(id_order,id_recipe,qte,unit_price)
	VALUES(seq_commande.CURRVAL,plat,nb,prix*nb);
END;

--Ajout d'un menu

CREATE PROCEDURE ajout_menu_order (menu NUMBER)
BEGIN
	INSERT INTO MENUORDER (id_menu_order,id_order,id_menu)
	VALUES(seq_menuorder.NEXTVAL,seq_commande.CURRVAL,menu);
	
	INSERT INTO RECIPEORDER(id_order,id_menu_order)
	VALUES (seq_commande.CURRVAL,seq_menuorder.CURRVAL);
	
	FOR variableBoucle IN [REVERSE] borneInf .. borneSup
	LOOP
		instructions;
	END LOOP;
	
END;



-- Supression d'une commande
DELETE FROM ORDERS
where id_order=seq_commande.CURRVAL();

--Affichage des Stock

CREATE PROCEDURE affichage_stock()
DECLARE
	name INGREDIENT.name%type;
	quantite PURCHASE.quantite_ingredient%type;
	quantity INGREDIENT.quantity_label%type;
	Cursor Curseur_stock IS
		SELECT name, quantite_ingredient,quantity-label
		FROM PURCHASE NATURAL JOIN INGREDIENT
BEGIN
	OPEN Curseur_stock;
	LOOP
		FETCH Curseur_stock INTO name,quantite,quantity;
		EXIT WHEN monCurseur%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Ingrédient : ' || name || '  ' || quantite || '   ' || quantity );
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Voici le nombre total de comédies : ' || monCurseur%rowCount);
	CLOSE MonCurseur;
END;

--Réapprovisionnement d'un ingrédient

--Ajout/supression employés, login employés

CREATE PROCEDURE login (nom STRING, id NUMBER)  IS
boolean ok;
BEGIN
	
	
	
