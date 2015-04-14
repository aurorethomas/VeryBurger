-- FUNCTIONS

-- This function calcul the total price for an order
CREATE OR REPLACE FUNCTION facture (numCommande NUMBER)
RETURN NUMBER IS
	prixTotal NUMBER(5) := 0 ;
BEGIN
	SELECT (SUM(unit_price) +SUM(price_menu)) INTO prixTotal
	FROM menu NATURAL JOIN menuOrder NATURAL JOIN recipeOrder NATURAL JOIN recipe
	WHERE id_order=numCommande;
	RETURN prixTotal;
END;
/
