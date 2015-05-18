-- Cette fonction met une date de livraison et déclenche ainsi un trigger
CREATE OR REPLACE PROCEDURE commande_preparee(id_comm INTEGER) IS
BEGIN
	UPDATE orders o
	SET o.delivrance_date=sysdate
	WHERE o.id_order=id_comm;
	Commit;
END;
/

-- Ce trigger se déclenche lorsque une commande est indiquée comme livrée et va retirer du stock les ingrédients correspondant
CREATE OR REPLACE TRIGGER trig_commande_preparee
	AFTER UPDATE OF delivrance_date
	ON ORDERS
	FOR EACH ROW
	WHEN (NEW.delivrance_date IS NOT NULL)
DECLARE
	id_men INTEGER;
	CURSOR curseurMenus IS
		SELECT id_menu
		FROM menuOrder m
		WHERE m.id_order=:NEW.id_order;
BEGIN
	OPEN curseurMenus;
	LOOP
		FETCH curseurMenus INTO id_men;
		EXIT WHEN curseurMenus%notfound;
		consommer_menu(id_men);
	END LOOP;
	CLOSE curseurMenus;
END;
/


CREATE OR REPLACE PROCEDURE consommer_menu(id_men INTEGER) IS
	CURSOR curseurRecettes IS
		SELECT id_recipe_
		FROM elementmenu
		WHERE id_menu=id_men;
	id_recette INTEGER;
BEGIN
	OPEN curseurRecettes;
	LOOP
		FETCH curseurRecettes INTO id_recette;
		EXIT WHEN curseurRecettes%notfound;
		consommer_recette(id_recette);
	END LOOP;
	CLOSE curseurRecettes;
END;
/


CREATE OR REPLACE PROCEDURE consommer_recette(id_rec INTEGER) IS
	CURSOR curseurIngredients IS
		SELECT id_ingredient,quantity_ingredientrecipe
		FROM ingredientrecipe
		WHERE id_recipe=id_rec;
	id_ing INTEGER;
	qte INTEGER;
BEGIN
	OPEN curseurIngredients;
	LOOP
		FETCH curseurIngredients INTO id_ing,qte;
		EXIT WHEN curseurIngredients%notfound;
		UPDATE ingredient
		SET quantity_ingredient=quantity_ingredient-qte
		WHERE id_ingredient=id_ing;
	END LOOP;
	CLOSE curseurIngredients;
END;
/
