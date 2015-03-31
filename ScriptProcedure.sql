--Utiliser dans le trigger monDeclancheur
SET serveroutput ON;
create or replace procedure nonQuantité (toto number) is
	quantite number;
	nom varchar(30);
BEGIN
  select quantite_ingredient into quantite from purchase where id_ingredient=toto;
  select ingredient.name into nom from ingredient where id_ingredient=toto;
	if(quantite=0)
	then DBMS_OUTPUT.PUT_LINE('alert ! pas de '|| nom);
	end if;
END;
/
--Utiliser dans le trigger monDeclancheur
SET serveroutput ON;
create or replace procedure nonQuantité (toto number) is
	quantite number:=0;
	temp number;
	nom varchar(30);
	cursor monCursor is 
		select quantite_ingredient from purchase where id_ingredient=toto;	
BEGIN
  open monCursor;
	loop
	fetch monCursor into temp;
	exit when monCursor %notfound;
	quantite:= quantite + temp;
	END loop;
	select ingredient.name into nom from ingredient where id_ingredient=toto;
		if(quantite=0)
			then DBMS_OUTPUT.PUT_LINE('alert ! pas de '|| nom);
		elsif(quantite<10)
				then DBMS_OUTPUT.PUT_LINE('alert ! moins de 10 '|| nom);
	end if;
END;