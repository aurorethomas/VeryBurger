-- Procedures et fonctions

-- auteur : Aurore

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


