-- Sequences pour la BDD

CREATE SEQUENCE sequence_id_orders;

CREATE SEQUENCE sequence_id_menuorders;

-- Création d'une commande

CREATE OR REPLACE FUNCTION Get_id_commande RETURN NUMBER IS
id_commande_active NUMBER;
BEGIN
	id_commande_active:=sequence_id_orders.NEXTVAL;
	RETURN id_commande_active;
END;

CREATE OR REPLACE Procedure New_orders(id_commande NUMBER)  IS
BEGIN
	INSERT INTO ORDERS(id_order,price_total)
	VALUES (id_commande,0);
END;
/

CREATE OR REPLACE PROCEDURE Insert_order_date(id_commande NUMBER) IS
BEGIN
	UPDATE ORDERS 
	SET order_date=CURRENT_DATE
	WHERE id_order=id_commande;
COMMIT;
END;
/


CREATE OR REPLACE FUNCTION Nouvelle_commande RETURN NUMBER IS
id_commande_A_recuperer NUMBER;
BEGIN
	id_commande_A_recuperer :=Get_id_commande();
	New_orders(id_commande_A_recuperer );
	Insert_order_date(id_commande_A_recuperer);
	RETURN id_commande_A_recuperer;
END;

DECLARE
N NUMBER;
BEGIN
N:=Nouvelle_commande();
END;
/


-- Ajout d'un menu dans une commande

CREATE OR REPLACE PROCEDURE Ajouter_menu_commande (id_commande_en_cours NUMBER,id_menu_ajoute NUMBER,qte NUMBER) IS
id_menuorder_seq NUMBER;
nombre_de_menus_ajoutes NUMBER;
BEGIN
	id_menuorder_seq:=sequence_id_menuorders.NEXTVAL;
	nombre_de_menus_ajoutes:=0;
	
	WHILE nombre_de_menus_ajoutes<qte
	LOOP
		INSERT INTO MENUORDER (id_menu_order,id_menu,id_order)
		VALUES (sequence_id_menuorders.NEXTVAL,id_menu_ajoute,id_commande_en_cours);
		nombre_de_menus_ajoutes:=nombre_de_menus_ajoutes+1;
	END LOOP;

END;

-- Valide une commande
CREATE OR REPLACE PROCEDURE valider_commande (id_commande NUMBER) IS
BEGIN
	UPDATE orders 
	SET delivrance_date=SYSDATE 
	WHERE id_order = id_commande;
COMMIT;
END;
/

-- Vue recette à faire
CREATE VIEW VUE_AFFICHAGE_RECETTE_A_FAIRE (id_commande NUMBER) AS
	SELECT name_recipe
	FROM MENUORDER NATURAL JOIN MENU NATURAL JOIN ELEMENTMENU JOIN RECIPE ON id_recipe_=id_recipe
	WHERE id_order=id_commande;

-- CalculPrix
CREATE OR REPLACE FUNCTION Calcul_prix_commande(id_commande NUMBER) RETURN DOUBLE PRECISION IS
prix_total DOUBLE PRECISION;
id_menu_invalide EXCEPTION;
max_id_commande NUMBER;
BEGIN
	
	SELECT MAX(id_order) INTO max_id_commande
	FROM ORDERS;
	
	IF id_commande>max_id_commande THEN RAISE id_menu_invalide;
	END IF;

	SELECT SUM(price_menu) INTO prix_total
	FROM MENUORDER NATURAL JOIN MENU
	WHERE id_commande=id_order;
	RETURN (prix_total);
EXCEPTION
	WHEN id_menu_invalide THEN
		DBMS_OUTPUT.PUT_LINE('Erreur');
END;
/
-- Vérification 
/*
DECLARE
P DOUBLE PRECISION;
BEGIN
P:=Calcul_prix_commande(1);
DBMS_OUTPUT.PUT_LINE(P);
END;
*/

	
CREATE OR REPLACE FUNCTION Ingredient_en_stock_suffisant(id_ingredient_voulu NUMBER,quantite_voulu NUMBER) RETURN BOOLEAN IS
quantite_en_stock NUMBER;
BEGIN
	SELECT quantity_ingredient INTO quantite_en_stock
	FROM INGREDIENT
	WHERE id_ingredient=id_ingredient_voulu;
	RETURN quantite_en_stock>=quantite_voulu;
END;
/
/*DECLARE
B BOOLEAN;
BEGIN
B:=Ingredient_en_stock_suffisant(1,5);
DBMS_OUTPUT.PUT_LINE(B);
END;*/

CREATE OR REPLACE FUNCTION Ingredient_recette_en_stock(id_recette_voulu NUMBER) RETURN BOOLEAN IS
id_ingredient_voulu NUMBER;
quantite_a_verifier NUMBER;
recette_faisable BOOLEAN;
CURSOR liste_ingredient IS
	SELECT id_ingredient,quantity_ingredientrecipe
	FROM INGREDIENTRECIPE
	WHERE id_recipe=id_recette_voulu;
BEGIN
	recette_faisable:=TRUE;
	OPEN liste_ingredient ;
	LOOP
		FETCH liste_ingredient INTO id_ingredient_voulu,quantite_a_verifier;
		IF Ingredient_en_stock_suffisant(id_ingredient_voulu,quantite_a_verifier)!=TRUE THEN recette_faisable:=FALSE;
    END IF;
		EXIT WHEN liste_ingredient%NOTFOUND;
	END LOOP;
END;
/

CREATE VIEW VUE_VERIF_RECETTE8STOCK IS
	SELECT id_recipe 
	FROM id_recipe 
	WHERE Ingredient_recette_en_stock(id_recipe)=TRUE;
/

create or replace function calcul_prixcommande (id_commande integer) RETURN double precision IS
  prixCommande double precision;
  nbcommande integer;
  idmenu integer;
  prix double precision;
  nbmenu integer;
  commandeAbsente EXCEPTION;
  
  CURSOR Curseur_menuorder(id_commande integer)IS  -- Le curseur récupère les informations relatives à un acteur possédant le même nom que celui passé en paramètre. 
    SELECT menuorder.id_menu, COUNT(menuorder.id_menu_order), menu.price_menu
    FROM menuorder JOIN menu ON(menu.id_menu = menuorder.id_menu)
    WHERE id_order = id_commande
    GROUP BY menuorder.id_menu, menu.price_menu;
    
BEGIN
  SELECT COUNT(*) INTO nbcommande
  FROM orders 
  WHERE id_order=id_commande;
  
  IF nbcommande!=1 THEN
    RAISE commandeAbsente;   -- On lance une exception 
  END IF;
  
  prixCommande := 0;
  OPEN Curseur_menuorder(id_commande);
    LOOP
      FETCH Curseur_menuorder INTO idmenu, nbmenu, prix;
      EXIT WHEN Curseur_menuorder%NOTFOUND;   
      prixCommande := prixCommande + nbmenu * prix;
    END LOOP;
    CLOSE Curseur_menuorder;
    
    INSERT INTO orders(price_total) VALUES(prixCommande) WHERE orders.id_order = id_commande;
    RETURN prixCommande;
    
  EXCEPTION  -- On traite les exceptions
      WHEN  CommandeAbsente THEN
        DBMS_OUTPUT.PUT_LINE('ERREUR: Aucune commande ne correspondau numéro '||id_commande);
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur Inconnue');
END;
/


