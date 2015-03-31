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


CREATE TABLE ORDER 
(
	id_order INTEGER,
	id_menu INTEGER,
	id_user INTEGER,
	order_date DATE,
	delivrance_date DATE,
	CONSTRAINT PK_ORDER PRIMARY KEY (id_order),
	CONSTRAINT FK_USER_ORDER FOREIGN KEY (id_user) REFERENCES USER(id_user)
	
);

CREATE TABLE USER 
(
	id_user INTEGER,
	Firstname_user VARCHAR(30),
	Surname_user VARCHAR(30),
	position INTEGER,
	CONSTRAINT PK_USER PRIMARY KEY (id_user),
	CONSTRAINT FK_USERS_POSITION FOREIGN KEY (position) REFERENCES POSITION(id_position)
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
	quantite_ingredient INTEGER,
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
	label_position VARCHAR(30),
	CONSTRAINT PK_POSITION PRIMARY KEY (id_position)
);

CREATE TABLE ELEMENTORDER
(
	order INTEGER,
	menu INTEGER, 
	quantity INTEGER,
	CONSTRAINT PK_ELEMENTORDER PRIMARY KEY (order, menu),
	CONSTRAINT FK_ELEMENTMENU_id_menu FOREIGN KEY (menu) REFERENCES MENU(id_menu)
);
