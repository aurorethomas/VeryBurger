--Sans menu
SELECT id_order,name_recipe,qte
FROM ORDERS NATURAL JOIN RECIPEORDER NATURAL JOIN RECIPE
ORDER BY name_recipe DESC

--avec menu
SELECT id_order,name_recipe,qte
FROM ORDERS NATURAL JOIN MENUORDER NATURAL JOIN MENU NATURAL JOIN ELEMENTMENU NATURAL JOIN TYPERECIPE NATURAL JOIN RECIPE
ORDER BY name_recipe DESC

--Vive les crevettes! c'est bon pour le poil de torse!