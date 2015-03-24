-- CREATION DES TABLES PROJETS STARTBURGER

CREATE TABLE INGREDIENT
(
	id_ingredient INTEGER,
	name VARCHAR(30),
	labelquantity VARCHAR(30),
	CONSTRAINT PK_INGREDIENT PRIMARY KEY (id_ingredient)
	
);

CREATE TABLE MENU
(
	id_menu INTEGER,
	name_menu VARCHAR(30),
	CONSTRAINT PK_MENU PRIMARY KEY (id_menu)
	
	
	
);


CREATE TABLE ORDERS
(
	id_orders INTEGER,
	id_menu INTEGER,
	id_users_throw INTEGER,
	CONSTRAINT PK_ORDERS PRIMARY KEY (id_orders),
	CONSTRAINT FK_ORDERS_id_menu FOREIGN KEY (id_menu) REFERENCES MENU(id_menu)
);

CREATE TABLE USERS
(
	id_user INTEGER,
	Firstname_user VARCHAR(30),
	Surname_user VARCHAR(30),
	id_orders INTEGER,
	CONSTRAINT PK_USER PRIMARY KEY (id_user),
	CONSTRAINT FK_USERS_orders FOREIGN KEY (id_user) REFERENCES ORDERS(id_orders)
);

CREATE TABLE PURCHASE
(
	id_purchase INTEGER,
	purchaseDate DATE,
	throwDate DATE,
	throw_user_id INTEGER,
	purchasePrice INTEGER,
	available CHAR(1),
	id_ingredient INTEGER,
	expireDate DATE,
	CONSTRAINT PK_PURCHASE PRIMARY KEY (id_purchase,id_ingredient),
	CONSTRAINT FK_id_ingredient_PURCHASE FOREIGN KEY(id_ingredient) REFERENCES INGREDIENT(id_ingredient),
	CONSTRAINT FK_id_throw FOREIGN KEY (throw_user_id) REFERENCES USERS(id_user)
  
);

CREATE TABLE RECIPE
(
	id_recipe INTEGER,
	name_recipe VARCHAR(30),
	CONSTRAINT PK_RECIPE PRIMARY KEY (id_recipe)
	
);


CREATE TABLE  INGREDIENTRECIPE
(
  	id_ingredient INTEGER,
	id_recipe INTEGER,
	quantity_ingredient INTEGER,
	CONSTRAINT PK_ING PRIMARY KEY (id_recipe, id_ingredient),
	CONSTRAINT FK_id_ingredient_ING FOREIGN KEY (id_ingredient) REFERENCES INGREDIENT(id_ingredient),
	CONSTRAINT FK_id_recipe_ING FOREIGN KEY (id_recipe) REFERENCES RECIPE(id_recipe)
);



CREATE TABLE ELEMENTMENU
(
	id_menu INTEGER,
	id_recipe INTEGER,
	qte INTEGER,
	CONSTRAINT PK_ELEMENTMENU PRIMARY KEY (id_menu,id_recipe),
	CONSTRAINT FK_ELEMENTMENU_id_menu FOREIGN KEY (id_menu) REFERENCES MENU(id_menu),
	CONSTRAINT FK_ELEMENTMENU_id_recipe FOREIGN KEY (id_recipe) REFERENCES RECIPE(id_recipe)
);


CREATE TABLE POSITION
(
	id_position INTEGER,
	id_user INTEGER,
	position VARCHAR(30),
	CONSTRAINT PK_POSITION PRIMARY KEY (id_position),
	CONSTRAINT FK_POSITION_id_user FOREIGN KEY (id_user) REFERENCES USERS(id_user)
);