-- CREATION DES TABLES PROJETS STARTBURGER


CREATE TABLE MENU
(
	id_menu INTEGER,
	name_menu VARCHAR(30),
	price_menu DOUBLE PRECISION,
	CONSTRAINT PK_MENU PRIMARY KEY (id_menu)	
);


CREATE TABLE TYPERECIPE
(
	id_type INTEGER,
	label_type VARCHAR(30),
	CONSTRAINT PK_TYPERECIPE PRIMARY KEY(id_type)
);


CREATE TABLE INGREDIENT
(
	id_ingredient INTEGER,
	name VARCHAR(30),
	quantity_label VARCHAR(30),
	CONSTRAINT PK_INGREDIENT PRIMARY KEY (id_ingredient)
);


CREATE TABLE ELEMENTMENU
(
	id_recipe_type INTEGER,
	id_menu INTEGER,
	quantity INTEGER,
	CONSTRAINT PK_ELEMENTMENU PRIMARY KEY(id_recipe_type, id_menu),
	CONSTRAINT FK_ELEMENTMENU_MENU FOREIGN KEY (id_menu) REFERENCES MENU(id_menu),
	CONSTRAINT FK_ELEMENTMENU_TYPERECIPE FOREIGN KEY (id_recipe_type) REFERENCES TYPERECIPE(id_type)
);

CREATE TABLE POSITIONS
(
	id_position INTEGER,
	label_position VARCHAR(30),
	CONSTRAINT PK_POSITIONS PRIMARY KEY (id_position)
);

CREATE TABLE USERS
(
	id_user INTEGER,
	firstname_user VARCHAR(30),
	surname_user VARCHAR(30),
	position INTEGER,
	CONSTRAINT PK_USER PRIMARY KEY (id_user),
	CONSTRAINT FK_USER_POSITIONS FOREIGN KEY (position) REFERENCES POSITIONS(id_position)
);

CREATE TABLE ORDERS
(
	id_order INTEGER,
	id_user INTEGER,
	order_date DATE,
	delivrance_date DATE,
	CONSTRAINT PK_ORDER PRIMARY KEY (id_order),
	CONSTRAINT FK_USER_ORDER FOREIGN KEY (id_user) REFERENCES USERS(id_user)
	
);


CREATE TABLE PURCHASE
(
	id_purchase INTEGER,
	purchaseDate DATE,
	throwDate DATE,
	throw_user_id INTEGER,
	purchasePrice DOUBLE PRECISION,
	available CHAR(1),
	id_order INTEGER,
	id_ingredient INTEGER,
	quantite_ingredient INTEGER,
	expireDate DATE,
	CONSTRAINT PK_PURCHASE PRIMARY KEY (id_purchase,id_ingredient),
	CONSTRAINT FK_id_ingredient_PURCHASE FOREIGN KEY(id_ingredient) REFERENCES INGREDIENT(id_ingredient),
	CONSTRAINT FK_PURCHASE_ORDER FOREIGN KEY(id_order) REFERENCES ORDERS(id_order),
	CONSTRAINT FK_id_throw FOREIGN KEY (throw_user_id) REFERENCES USERS(id_user)
);

CREATE TABLE RECIPE
(
	id_recipe INTEGER,
	name_recipe VARCHAR(30),
	price DOUBLE PRECISION,
	id_type INTEGER,
	CONSTRAINT FK_RECIPE_TYPERECIPE FOREIGN KEY (id_type) REFERENCES TYPERECIPE(id_type),
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

CREATE TABLE MENUORDER
(
	id_menu_order INTEGER,
	id_order INTEGER,
	id_menu INTEGER,
	CONSTRAINT PK_ELEMENTORDER PRIMARY KEY (id_menu_order),
	CONSTRAINT FK_MENUORDER_MENU FOREIGN KEY (id_menu) REFERENCES MENU(id_menu),
	CONSTRAINT FK_MENUORDER_ORDER FOREIGN KEY (id_order) REFERENCES ORDERS(id_order)
);

CREATE TABLE RECIPEORDER
(
	id_order INTEGER,
	id_recipe INTEGER,
	qte INTEGER,
	unit_price DOUBLE PRECISION,
	id_menu_order INTEGER,
	CONSTRAINT PK_RECIPEORDER PRIMARY KEY (id_order,id_recipe,id_menu_order),
	CONSTRAINT FK_RECIPEORDER_ORDER FOREIGN KEY (id_order) REFERENCES ORDERS(id_order),
	CONSTRAINT FK_RECIPEORDER_RECIPE FOREIGN KEY (id_recipe) REFERENCES RECIPE(id_recipe)
);



