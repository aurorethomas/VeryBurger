CREATE OR REPLACE PROCEDURE annulerCommande(idCommande NUMBER) IS
BEGIN
	DELETE FROM recipeorder
	WHERE id_order=idCommande;
	DELETE FROM menuorder
	WHERE id_order=idCommande;
	DELETE FROM orders
	WHERE id_order=idCommande;
	Commit;
END;
/

CREATE OR REPLACE PROCEDURE viderCommande(idCommande NUMBER) IS
BEGIN
	DELETE FROM recipeorder
	WHERE id_order=idCommande;
	DELETE FROM menuorder
	WHERE id_order=idCommande;
	Commit;
END;
/