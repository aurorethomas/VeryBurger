--Bloc nettoyant une BDD sur Oracle, on a juste besoin de changer TABLE en FUNCTION pour supprimer les fonctions


BEGIN
    FOR c IN (SELECT object_name,
                     object_type
              FROM user_objects
              WHERE object_type IN ('Table') AND object_name NOT LIKE '%$%') LOOP
        EXECUTE IMMEDIATE 'DROP '
                             || c.object_type || ' "'
                             || c.object_name || '" CASCADE CONSTRAINTS';
    END LOOP;
END;