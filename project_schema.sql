/**********************************************************************
 * NAME: Trevor Diuco
 * CLASS: CPSC 321
 * Last Modified: December 9, 2021
 * DESCRIPTION: Project Schema file
 **********************************************************************/

DROP TABLE IF EXISTS
   review,
   ingredient_list_add_on,
   ingredient_list_spirit,
   cocktail_recipe,
   add_on_user_has,
   spirit_user_has,
   application_user,
   add_on,
   spirit;

CREATE TABLE spirit(
   spirit_name VARCHAR(20),
   abv_percentage         INT(2) NOT NULL,
   PRIMARY KEY(spirit_name)
);

CREATE TABLE add_on(
   add_on_name VARCHAR(20),
   PRIMARY KEY (add_on_name)
);

CREATE TABLE application_user(
   username    VARCHAR(20),
   age         INT(2),
   fav_spirit  VARCHAR(20) NOT NULL,
   PRIMARY KEY(username),
   FOREIGN KEY (fav_spirit) REFERENCES spirit(spirit_name)
);

CREATE TABLE spirit_user_has(
   username    VARCHAR(20),
   spirit      VARCHAR(20),
   PRIMARY KEY (username, spirit),
   FOREIGN KEY (username)  REFERENCES application_user(username),
   FOREIGN KEY (spirit)    REFERENCES spirit(spirit_name)
);

CREATE TABLE add_on_user_has(
   username    VARCHAR(20),
   add_on      VARCHAR(20),
   PRIMARY KEY (username, add_on),
   FOREIGN KEY (username)  REFERENCES application_user(username),
   FOREIGN KEY (add_on)    REFERENCES add_on(add_on_name)
);

CREATE TABLE cocktail_recipe(
   cocktail_name        VARCHAR(20),
   abv                  INT(2) NOT NULL,
   main_spirit          VARCHAR(20) NOT NULL,
   main_add_on          VARCHAR(20),
   PRIMARY KEY (cocktail_name),
   FOREIGN KEY (main_spirit) REFERENCES spirit(spirit_name),
   FOREIGN KEY (main_add_on) REFERENCES add_on(add_on_name)
);

CREATE TABLE ingredient_list_spirit(
   cocktail_name   VARCHAR(20),
   spirit         VARCHAR(20),
   amount         VARCHAR(20) NOT NULL,
   PRIMARY KEY (cocktail_name, spirit),
   FOREIGN KEY (cocktail_name) REFERENCES cocktail_recipe(cocktail_name),
   FOREIGN KEY (spirit) REFERENCES spirit(spirit_name)
);

CREATE TABLE ingredient_list_add_on(
   cocktail_name  VARCHAR(20),
   add_on            VARCHAR(20),
   amount            VARCHAR(20),
   PRIMARY KEY (cocktail_name, add_on),
   FOREIGN KEY (cocktail_name) REFERENCES cocktail_recipe(cocktail_name),
   FOREIGN KEY (add_on) REFERENCES add_on(add_on_name)
);

CREATE TABLE review(
   username          VARCHAR(20),
   cocktail          VARCHAR(20),
   ratingDate        DATE,
   userRating        INT(1) NOT NULL,
   PRIMARY KEY (username, cocktail, ratingDate),
   FOREIGN KEY (username) REFERENCES application_user(username),
   FOREIGN KEY (cocktail) REFERENCES cocktail_recipe(cocktail_name),
   CHECK (userRating <= 5 AND userRating >= 0)
);

INSERT INTO spirit
VALUES ('Light Rum', 40),
       ('Dark Rum', 40),
       ('Vodka', 40),
       ('Whiskey',45),
       ('Bourbon', 45),
       ('Scotch', 45),
       ('Vermouth', 15),
       ('Amaretto', 25),
       ('Coffee Liqueur', 20),
       ('Irish Cream Liqueur', 17),
       ('Orange Liqueur', 35),
       ('Gin', 35),
       ('Liqueur', 25),
       ('Silver Tequila', 40),
       ('Gold Tequila', 40),
       ('Brandy', 40),
       ('Triple Sec', 30),
       ('Sour Apple Schnapps', 15);

INSERT INTO add_on
VALUES ('Strawberries'),
       ('Lime'),
       ('Sugar'),
       ('Almond Syrup'),
       ('Ginger Beer'),
       ('Beer'),
       ('Sweet and Sour Mix'),
       ('Cola'),
       ('Cranberry Juice'),
       ('Lemon'),
       ('Apple Juice'),
       ('Orange'),
       ('Mint Leaves'),
       ('Angostura Bitters'),
       ('Bitters'),
       ('Lime Juice'),
       ('Campari Bitters'),
       ('Olive Juice'),
       ('Grenadine'),
       ('Club Soda'),
       ('Salt'),
       ('Orange Juice'),
       ('Sprite');

INSERT INTO application_user
VALUES ('tsdiuco', 21, 'Dark Rum'),
       ('ecgustin', NULL, 'Vodka'),
       ('awcalmette', 21, 'Whiskey'),
       ('dmkar', 22, 'Vodka');

INSERT INTO spirit_user_has
VALUES ('tsdiuco', 'Dark Rum'),
       ('tsdiuco', 'Light Rum'),
       ('ecgustin', 'Silver Tequila'),
       ('ecgustin', 'Gold Tequila'),
       ('ecgustin', 'Vodka'),
       ('ecgustin', 'Bourbon'),
       ('ecgustin', 'Scotch'),
       ('awcalmette', 'Whiskey'),
       ('awcalmette', 'Gin'),
       ('awcalmette', 'Silver Tequila'),
       ('dmkar', 'Whiskey'),
       ('dmkar', 'Gin'),
       ('dmkar', 'Vodka'),
       ('dmkar', 'Amaretto'),
       ('dmkar', 'Triple Sec');

INSERT INTO add_on_user_has
VALUES ('tsdiuco', 'Lime Juice'),
       ('tsdiuco', 'Orange Juice'),
       ('tsdiuco', 'Ginger Beer'),
       ('tsdiuco', 'Beer'),
       ('ecgustin', 'Beer'),
       ('ecgustin', 'Lemon'),
       ('ecgustin', 'Orange'),
       ('ecgustin', 'Apple Juice'),
       ('ecgustin', 'Sugar'),
       ('ecgustin', 'Lime'),
       ('awcalmette', 'Orange Juice'),
       ('awcalmette', 'Beer'),
       ('awcalmette', 'Ginger Beer'),
       ('dmkar', 'Grenadine'),
       ('dmkar', 'Club Soda'),
       ('dmkar', 'Orange Juice'),
       ('dmkar', 'Salt'),
       ('dmkar', 'Cola');

INSERT INTO cocktail_recipe
VALUES ('Strawberry Daiquiri', 31,   'Light Rum',   'Strawberries'),
       ('Mai Tai',             29,   'Dark Rum',    NULL),
       ('Hurricane',           19,   'Light Rum',   'Orange Juice'),
       ('Dark and Stormy',     15,   'Dark Rum',    'Ginger Beer'),
       ('Long Island Iced Tea',28,   'Vodka',       'Sweet and Sour Mix'),
       ('Kamikaze',            23,   'Vodka',       'Lime Juice'),
       ('Cosmopolitan',        22,   'Vodka',       'Cranberry Juice'),
       ('Old Fashioned',       35,   'Bourbon',     'Orange'),
       ('Mint Julep',          33,   'Bourbon',     'Mint Leaves'),
       ('Manhattan',           27,   'Whiskey',     'Bitters'),
       ('Gin Gimlet',          32,   'Gin',         'Sugar'),
       ('Negroni',             25,   'Gin',         'Campari Bitters'),
       ('Dirty Martini',       25,   'Gin',         'Olive Juice'),
       ('Tequila Shot',        40,   'Gold Tequila','Lime'),
       ('Margarita',           16,   'Silver Tequila','Orange Juice'),
       ('Tequila Sunrise',     16,   'Silver Tequila','Orange Juice');

INSERT INTO ingredient_list_spirit
VALUES ('Strawberry Daiquiri', 'Light Rum',   '2 shots'),
       ('Strawberry Daiquiri', 'Triple Sec',  '.5 shots'),
       ('Long Island Iced Tea','Vodka',       '.5 shots'),
       ('Long Island Iced Tea','Light Rum',   '.5 shots'),
       ('Long Island Iced Tea','Gin',         '.5 shots'),
       ('Long Island Iced Tea','Gold Tequila',     '.5 shots'),
       ('Long Island Iced Tea','Triple Sec',  '.5 shots'),
       ('Mai Tai',             'Dark Rum',    '1 shot'),
       ('Mai Tai',             'Light Rum',   '1 shot'),
       ('Mai Tai',             'Triple Sec',   '.75 shot'),
       ('Mai Tai',             'Amaretto',    '.5 shot'),
       ('Kamikaze',            'Vodka',       '.5 shot'),
       ('Kamikaze',            'Triple Sec',  'Splash'),
       ('Dark and Stormy',     'Dark Rum',    '2 shots'),
       ('Old Fashioned',       'Bourbon',     '1.5 shots'),
       ('Gin Gimlet',          'Gin',         '1 shot'),
       ('Tequila Shot',        'Gold Tequila','1 shot');

INSERT INTO ingredient_list_add_on
VALUES ('Strawberry Daiquiri',    'Strawberries',            '5 crushed'),
       ('Strawberry Daiquiri',    'Lime',                    'Juice Of .5'),
       ('Strawberry Daiquiri',    'Sugar',                   'Teaspoon'),
       ('Long Island Iced Tea',   'Sweet and Sour Mix',      '1 shot'),
       ('Long Island Iced Tea',   'Cola',                    '1 shot'),
       ('Mai Tai',                'Almond Syrup',            '1 Drop'),
       ('Kamikaze',               'Sweet and Sour Mix',      'Splash'),
       ('Dark and Stormy',        'Ginger Beer',             '4 shots'),
       ('Dark and Stormy',        'Lime',                    'Juice of .5'),
       ('Old Fashioned',          'Bitters',                 '2 dashes'),
       ('Old Fashioned',          'Orange',                  '1 slice'),
       ('Old Fashioned',          'Lime',                    '1 slice'),
       ('Old Fashioned',          'Sugar',                   '1 teaspoon'),
       ('Gin Gimlet',             'Lime Juice',              '.5 shot'),
       ('Gin Gimlet',             'Lime',                    'Garnish'),
       ('Tequila Shot',           'Salt',                    'Garnish'),
       ('Tequila Shot',           'Lime',                    'Wedge');

INSERT INTO review
VALUES ('tsdiuco',    'Dark and Stormy',      "2021-07-31", 5),
       ('tsdiuco',    'Long Island Iced Tea', "2021-09-25", 4),
       ('tsdiuco',    'Tequila Shot',         "2021-10-12", 2),
       ('ecgustin',   'Tequila shot',         "2021-10-12", 5),
       ('ecgustin',   'Long Island Iced Tea', "2020-05-09", 5),
       ('ecgustin',   'Old Fashioned',        "2019-12-24", 3),
       ('awcalmette', 'Dark and Stormy',      "2021-07-31", 3),
       ('awcalmette', 'Kamikaze',             "2020-04-29", 5),
       ('awcalmette', 'Strawberry Daiquiri',  "2020-09-13", 5),
       ('dmkar',      'Gin Gimlet',           "2021-10-12", 2),
       ('dmkar',      'Mai Tai',              "2019-12-31", 5),
       ('dmkar',      'Old Fashioned',        "2021-11-10", 1);