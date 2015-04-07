--Alerte pour moins de 10 unités  et pour 0 unités pour tous les produits après le update dans la table PURCHASEalert
create or replace trigger monDeclancheur 
	before update on purchase FOR EACH ROW
declare  toto integer;
BEGIN	
	IF updating THEN
	toto:= (:new.id_ingredient);
		nonQuantité(toto);
	end if;
END;


