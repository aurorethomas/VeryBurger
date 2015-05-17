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