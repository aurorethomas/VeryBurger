-- scriptProcedureAlternatif.sql

-- Ce fichier contiendra toutes les fonctions de la BDD
SET serveroutput ON;

-- Creation d'une commande
CREATE PROCEDURE new_orders (id_utilisateur NUMBER) IS
BEGIN
	INSERT INTO ORDERS(id_order,id_user,total_prize)
	VALUES (sequence_id_orders.NEXTVAL,id_utilisateur,0);
END;

-- Creation d'une menu
CREATE PROCEDURE new_menuorder () IS
BEGIN
	INSERT INTO MENUORDER (id_menu_order,id_order)
	VALUES (sequence_id_menuorders.NEXTVAL,sequence_id_orders.CURRVAL);
END;


CREATE PROCEDURE new_recipeorder()
BEGIN
	INSERT INTO RECIPEORDER (id_recipe_order,id_order)
	VALUES (sequence_id_recipeorders.NEXTVAL,sequence_id_orders.CURRVAL);
END;

CREATE PROCEDURE insert_order_date() IS
BEGIN
	INSERT INTO ORDERS (order_date)
	VALUES (CURRENT_DATE)
	WHERE id_order=sequence_id_orders.CURRVAL;
END;

CREATE PROCEDURE nouvelle_commande(id_utilisateur NUMBER) IS
BEGIN
	new_orders(id_utilisateur);
	new_menuorder();
	new_recipeorder();
	insert_order_date();
END;

CREATE PROCEDURE mise_à_jour_prix_commande(addition NUMBER) IS
BEGIN 
	UPDATE ORDERS
	SET total_prize=total_prize+addition;
END;



CREATE PROCEDURE ajouter_recette_commande_courante(id_recette NUMBER,quantite_recette NUMBER) IS
BEGIN
	INSERT INTO RECIPEORDER (id_recipe,qte)
	VALUES (id_recette, quantite_recette);
END;

-- Information sur un employé
CREATE OR REPLACE PROCEDURE infoEmploye (numEmploye NUMBER)IS
	nameEmploye VARCHAR(30);
	surnameEmploye VARCHAR(30);
	positionEmploye VARCHAR(30);
BEGIN
    SELECT firstname_user, surname_user, label_position INTO nameEmploye, surnameEmploye, positionEmploye
    FROM users NATURAL JOIN positions
    WHERE id_user = numEmploye and id_position = position;
		DBMS_OUTPUT.PUT_LINE(' Name : '|| nameEmploye ||  ' ; '  ||' Surname : '|| surnameEmploye||  ' ; ' ||' Position : ' || positionEmploye); 
END;


-- Informations sur tous les employés
CREATE OR REPLACE PROCEDURE infoAllEmploye IS
	nameEmploye VARCHAR(30);
	surnameEmploye VARCHAR(30);
	positionEmploye VARCHAR(30);
Cursor employe IS 
        SELECT firstname_user, surname_user, label_position
        FROM users NATURAL JOIN positions
        WHERE id_position = position;
BEGIN
	OPEN employe;
	LOOP
		FETCH employe INTO nameEmploye, surnameEmploye, positionEmploye; 
		EXIT WHEN employe%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(' Name : '|| nameEmploye ||  ' ; '  ||' Surname : '|| surnameEmploye||  ' ; ' ||' Position : ' || positionEmploye);  
	END LOOP;
	Close employe;
END;



-- test procédure infoEmploye
DECLARE
BEGIN
	infoEmploye(2);
END;

-- test procédure infoAllEmploye
DECLARE
BEGIN
	infoAllEmploye();
END;


/*----------------------------------------------------------------*/

CREATE SEQUENCE sequence_id_orders;

-- Ajouter commande vide 
CREATE OR REPLACE PROCEDURE new_orders (id_utilisateur NUMBER) IS
BEGIN
	INSERT INTO ORDERS(id_order, id_user, order_date)
	VALUES (sequence_id_orders.NEXTVAL,id_utilisateur, sysdate);
END;

--test procédure new_orders
BEGIN
	new_orders(2);
END;
/*----------------------------------------------------------------*/
CREATE SEQUENCE sequence_id_menuorders;    --Commande 1 menu 

CREATE OR REPLACE PROCEDURE new_menuorder (id_menu NUMBER) IS
BEGIN
	INSERT INTO MENUORDER 
	VALUES (sequence_id_menuorders.NEXTVAL,sequence_id_orders.CURRVAL, id_menu);
END;

--test procédure new_menuorder
BEGIN
	new_menuorder(2);
END;
/*----------------------------------------------------------------*/
CREATE SEQUENCE sequence_id_recipe_order;

CREATE OR REPLACE PROCEDURE new_recipeorder (nb NUMBER, plat NUMBER)IS
prix NUMBER;
BEGIN
	SELECT price INTO prix 
	FROM RECIPE 
	WHERE id_recipe=plat;
	
	INSERT INTO RECIPEORDER(id_recipe_order, id_order, id_recipe, qte ,unit_price)
	VALUES(sequence_id_recipe_order.NEXTVAL, sequence_id_orders.CURRVAL, plat ,nb ,prix*nb);
END;

--test procédure new_recipeorder
BEGIN
	new_recipeorder(2, 2);
END;
/*----------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE price_order (id_order_ NUMBER)IS --Calcule le prix total d’une commande
	totalPrice NUMBER :=0;
	price NUMBER;
	id_temp NUMBER;
		cursor coureurMenuorder is 
			select id_menu from menuorder where id_order=id_order_;
BEGIN
	open coureurMenuorder;
	loop
	fetch coureurMenuorder into id_temp;
	exit when coureurMenuorder %notfound;
	select price_menu into price from menu where id_menu=id_temp;
	totalPrice:= totalPrice + price;
	END loop;
	close coureurMenuorder;
	
	SELECT SUM(unit_price) into price FROM recipeorder WHERE id_order=id_order_;
	totalPrice:= totalPrice+price;
	DBMS_OUTPUT.PUT_LINE('Prix total :  '|| totalPrice);
END;	

--test procédure price_order
BEGIN
	price_order(2);
END;
/*----------------------------------------------------------------*/
/*----------------------------------------------------------------*/
cursor coureurRecipeorder is 
			select id_recipe from recipeorder where id_order=id_order_;
open coureurRecipeorder;
	loop
	fetch coureurRecipeorder into id_temp;
	exit when coureurRecipeorder %notfound;
	select unit_price from recipeorder where id_ingredient=id_temp;
	totalPrice:= totalPrice + price;
	END loop;
	close coureurRecipeorder;
/*----------------------------------------------------------------*/


-- Suppression des éléments du fichier 
drop sequence sequence_id_orders;
drop procedure new_orders;

drop sequence sequence_id_menuorders;
drop procedure new_menuorder; 

drop sequence sequence_id_recipe_order;
drop procedure new_recipeorder;

drop PROCEDURE price_order;
/*----------------------------------------------------------------*/



-- Affiche les infos nécessaire à l'impression d'un ticket de caisse 
CREATE OR REPLACE PROCEDURE infoCommande(numCommande NUMBER) IS
	numMenu NUMBER;
	nomMenu VARCHAR(30);
	qte NUMBER;
	nomRecette VARCHAR(30);
	prix NUMBER;
Cursor menuCommande IS 
		select id_menu, name_menu  
		from menuorder natural join menu
		where id_order = numCommande;
Cursor recetteCommande IS
		select qte, name_recipe
		from recipe natural join recipeorder
		where id_order =numCommande;
BEGIN
	DBMS_OUTPUT.PUT_LINE('La commande numéro ' || numCommande || ' contient : ');
	OPEN menuCommande;
	LOOP
		FETCH menuCommande INTO numMenu, nomMenu;
		EXIT WHEN menuCommande%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Le menu : ' || nomMenu );
		ContenuMenu(numMenu);  
	END LOOP;
	Close menuCommande;
	DBMS_OUTPUT.PUT_LINE('La commande contient aussi des recettes hors menu : ' );
	OPEN recetteCommande;
	LOOP
		FETCH recetteCommande INTO qte, nomRecette;
		EXIT WHEN recetteCommande%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE( qte || ' ' || nomRecette );
	END LOOP;
	CLOSE recetteCommande;
 	price_order(numCommande);
END;


-- procedure qui affiche le contenu d'un menu ( qte + label)
CREATE OR REPLACE PROCEDURE ContenuMenu(numMenu NUMBER) IS
	qte NUMBER(5);
	categorie VARCHAR(30);
	Cursor infoMenu IS 
		select quantity, label_type
		from elementmenu natural join typerecipe 
		where id_type = id_recipe_type and id_menu = numMenu;
BEGIN
	OPEN infoMenu;
	LOOP 
		FETCH infoMenu INTO qte, categorie;
		EXIT WHEN infoMenu%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(qte || ' ' || categorie);
	END LOOP;
	CLOSE infoMenu;
END;

-- Donne tous les ingredients et la quantité necessaire pour une recette ( ainsi que le prix de la recette )
CREATE OR REPLACE PROCEDURE infoRecette(nomRecette STRING) IS
	nomIngredient VARCHAR(30);
	qte NUMBER;
	prix NUMBER;
Cursor maRecette IS 
		select quantity_ingredientrecipe, name
		from ingredient natural join ingredientrecipe natural join recipe
		where name_recipe = nomRecette;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Ingredient nécessaire à la fabrication de :  ' || nomRecette);
	OPEN maRecette;
	LOOP
		FETCH maRecette INTO qte, nomIngredient;
		EXIT WHEN maRecette%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(qte || ' ' || nomIngredient); 
	END LOOP;
	Close maRecette;

	select price INTO prix
	from recipe
	where name_recipe = nomRecette;
	DBMS_OUTPUT.PUT_LINE('Cette recette est en vente au prix de : ' || prix || 'euros');
END;


--Consommation d'une recette (les ingrédients sont retirés dans les stock) 

CREATE OR REPLACE PROCEDURE MAJstock (nomRecette STRING)IS
	nomIngredient VARCHAR(30);
	qte NUMBER;
Cursor maRecette IS 
		select quantity_ingredientrecipe, name
		from ingredient natural join ingredientrecipe natural join recipe
		where name_recipe = nomRecette;
BEGIN
	OPEN maRecette;
	LOOP
		FETCH maRecette INTO qte, nomIngredient;
		EXIT WHEN maRecette%NOTFOUND;
		UPDATE ingredient
		SET quantity_ingredient = quantity_ingredient - qte
		WHERE name = nomIngredient;
	END LOOP;
	Close maRecette;
	DBMS_OUTPUT.PUT_LINE('Les stocks viennent d''être mis à jour' );
END;