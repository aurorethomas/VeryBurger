CREATE PROCEDURE recetteEffectue(idRecipeOrder NUMBER) IS

BEGIN
	UPDATE recipeorder
	SET delivrance_date=sysdate
	WHERE id_recipe_order=idRecipeOrder;
	SELECT id_ingredient,quantity_ingredient
	FROM ingredientrecipe
	WHERE id_recipe=(SELECT id_recipe FROM recipeorder WHERE id_recipe_order=idRecipeOrder)
	-- répéter le tout qte fois recipe_order
	-- to do : faire un curseur avec tous les ingrédients
	-- pour chaque ingrédient, boucle répétée qté fois
	-- mettre en no available autant de purchase que de qte de chaque ingrédient 
	Commit;
END