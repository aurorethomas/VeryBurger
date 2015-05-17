-- FUNCTIONS

--- This function calcul the total price for an order
CREATE OR REPLACE FUNCTION facture (numCommande NUMBER)
RETURN NUMBER IS
	recipePrice NUMBER(5);
	menuPrice NUMBER(5);
BEGIN
	SELECT (SUM(unit_price*qte)) INTO recipePrice
	FROM recipeOrder 
	WHERE id_order=numCommande;
	SELECT SUM(price_menu) INTO menuPrice
	FROM menuOrder NATURAL JOIN menu
	WHERE id_order=numCommande;
	RETURN menuPrice + recipePrice;
END;
/

--  Count the the total orders for an Employe
CREATE OR REPLACE FUNCTION nbrCommande (numEmploye NUMBER)
RETURN NUMBER IS
	totalCommande NUMBER(5);
BEGIN
	SELECT SUM(id_order) INTO totalCommande
	FROM orders
	WHERE id_user = numEmploye;
	RETURN totalCommande;
END;
/



