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
   age         INT(2) NOT NULL,
   fav_spirit  VARCHAR(20) NOT NULL,
   PRIMARY KEY(username),
   FOREIGN KEY (fav_spirit) REFERENCES spirit(spirit_name)
);

CREATE TABLE spirit_user_has(
   username    VARCHAR(20),
   spirit      VARCHAR(20),
   PRIMARY KEY (username, spirit),
   FOREIGN KEY (username)  REFERENCES application_user(username) ON DELETE CASCADE,
   FOREIGN KEY (spirit)    REFERENCES spirit(spirit_name)
);

CREATE TABLE add_on_user_has(
   username    VARCHAR(20),
   add_on      VARCHAR(20),
   PRIMARY KEY (username, add_on),
   FOREIGN KEY (username)  REFERENCES application_user(username) ON DELETE CASCADE,
   FOREIGN KEY (add_on)    REFERENCES add_on(add_on_name)
);

CREATE TABLE cocktail_recipe(
   cocktail_name        VARCHAR(50),
   abv                  INT(2) NOT NULL,
   main_spirit          VARCHAR(20) NOT NULL,
   PRIMARY KEY (cocktail_name),
   FOREIGN KEY (main_spirit) REFERENCES spirit(spirit_name)
);

CREATE TABLE ingredient_list_spirit(
   cocktail_name   VARCHAR(50),
   spirit         VARCHAR(20),
   amount         DECIMAL(3,2) NOT NULL,
   amount_unit    VARCHAR(20) NOT NULL,
   PRIMARY KEY (cocktail_name, spirit),
   FOREIGN KEY (cocktail_name) REFERENCES cocktail_recipe(cocktail_name),
   FOREIGN KEY (spirit) REFERENCES spirit(spirit_name)
);

CREATE TABLE ingredient_list_add_on(
   cocktail_name  VARCHAR(50),
   add_on            VARCHAR(20),
   amount         DECIMAL(3,2) NOT NULL,
   amount_unit    VARCHAR(20) NOT NULL,
   PRIMARY KEY (cocktail_name, add_on),
   FOREIGN KEY (cocktail_name) REFERENCES cocktail_recipe(cocktail_name),
   FOREIGN KEY (add_on) REFERENCES add_on(add_on_name)
);

CREATE TABLE review(
   username          VARCHAR(20),
   cocktail          VARCHAR(50),
   userRating        INT(1),
   PRIMARY KEY (username, cocktail, userRating),
   FOREIGN KEY (username) REFERENCES application_user(username) ON DELETE CASCADE,
   FOREIGN KEY (cocktail) REFERENCES cocktail_recipe(cocktail_name),
   CHECK (userRating <= 5 AND userRating >= 0)
);

INSERT INTO spirit
VALUES ('Rum', 40),
       ('Vodka', 40),
       ('Whiskey',45),
       ('Gin', 40),
       ('Tequila', 40),
       ('Triple Sec', 25),
       ('Amaretto', 25),
       ('Sour Apple Schnapps', 15),
       ('Kahlua', 20),
       ('Vermouth', 15),
       ('Frangelico', 15),
       ('Southern Comfort', 15),
       ('Sloe Gin', 15),
       ('Coconut Rum', 15),
       ('Butterscotch Liqueur', 15),
       ('Cointreau', 15),
       ('Apple Schnapps', 15),
       ('Jägermeister', 15);

INSERT INTO add_on
VALUES ('Salt'),
       ('Lime Wedge'),
       ('Sweet and Sour Mix'),
       ('Lime Juice'),
       ('Orange Juice'),
       ('Sprite'),
       ('Grenadine'),
       ('Cranberry Juice'),
       ('Sugar'),
       ('Pineapple Juice'),
       ('Lemon Slice'),
       ('Bitters'),
       ('Olive Juice'),
       ('Club Soda'),
       ('Lemon Juice'),
       ('Orange Slice'),
       ('Mint Leafs'),
       ('Orange Peel'),
       ('Cola'),
       ('Apple Juice'),
       ('Cream'),
       ('Beer'),
       ('Ginger Beer'),
       ('Passion Fruit Juice'),
       ('Almond Syrup'),
       ('Strawberries');

INSERT INTO application_user
VALUES ('tsdiuco', 21, 'Rum'),
       ('ecgustin', 23, 'Vodka'),
       ('awcalmette', 21, 'Whiskey'),
       ('dmkar', 22, 'Vodka');

INSERT INTO spirit_user_has
VALUES ('tsdiuco', 'Rum'),
       ('tsdiuco', 'Vodka'),
       ('ecgustin', 'Tequila'),
       ('ecgustin', 'Vodka'),
       ('ecgustin', 'Whiskey'),
       ('awcalmette', 'Whiskey'),
       ('awcalmette', 'Gin'),
       ('awcalmette', 'Tequila'),
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
       ('ecgustin', 'Apple Juice'),
       ('ecgustin', 'Sugar'),
       ('awcalmette', 'Orange Juice'),
       ('awcalmette', 'Beer'),
       ('awcalmette', 'Ginger Beer'),
       ('dmkar', 'Grenadine'),
       ('dmkar', 'Club Soda'),
       ('dmkar', 'Orange Juice'),
       ('dmkar', 'Salt'),
       ('dmkar', 'Cola');

INSERT INTO cocktail_recipe
VALUES ('Strawberry Daiquiri', 31, 'Rum'),
       ('Mai Tai', 29, 'Rum'),
       ('Hurricane', 19, 'Rum'),
       ('Dark and Stormy', 15, 'Rum'),
       ('Flaming Dr. Pepper', 14, 'Rum'),
       ('Long Island Iced Tea', 28, 'Vodka'),
       ('Kamikaze', 23, 'Vodka'),
       ('Cosmopolitan', 22, 'Vodka'),
       ('Apple Martini', 18, 'Vodka'),
       ('White Russian', 15, 'Vodka'),
       ('Old Fashioned', 35, 'Whiskey'),
       ('Mint Julep', 33, 'Whiskey'),
       ('Rob Roy', 31, 'Whiskey'),
       ('Manhattan', 27, 'Whiskey'),
       ('Whiskey Sour', 27, 'Whiskey'),
       ('Gin Gimlet', 32, 'Gin'),
       ('Negroni', 26, 'Gin'),
       ('Dirty Martini', 25, 'Gin'),
       ('Singapore Sling', 16, 'Gin'),
       ('Tom Collins', 16, 'Gin'),
       ('Chocolate Cake', 32, 'Frangelico'),
       ('Alabama Slammer', 25, 'Southern Comfort'),
       ('B-52', 23, 'Kahlua'),
       ('Surfer on Acid', 19, 'Jägermeister'),
       ('Buttery Nipple', 15, 'Butterscotch Liqueur'),
       ('Tequila Shot', 40, 'Tequila'),
       ('Margarita', 16, 'Tequila'),
       ('Mexican Martini', 16, 'Tequila'),
       ('Tequila Sunrise', 16, 'Tequila'),
       ('Frozen Cranberry Margarita', 14, 'Tequila');

INSERT INTO ingredient_list_spirit
VALUES ('Strawberry Daiquiri',         'Rum', 2   , 'shots'),
       ('Strawberry Daiquiri',         'Triple Sec', .5, 'shots'),
       ('Mai Tai',                     'Rum', 2, 'shots'),
       ('Mai Tai',                     'Triple Sec', .75, 'shots'),
       ('Mai Tai',                     'Amaretto', .5, 'shots'),
       ('Hurricane',                   'Rum', 2, 'shots'),
       ('Dark and Stormy',             'Rum', 2, 'shots'),
       ('Flaming Dr. Pepper',          'Rum', .25, 'shots'),
       ('Flaming Dr. Pepper',          'Amaretto', .75, 'shots'),
       ('Long Island Iced Tea',        'Vodka', .5, 'shots'),
       ('Long Island Iced Tea',        'Rum', .5, 'shots'),
       ('Long Island Iced Tea',        'Gin', .5, 'shots'),
       ('Long Island Iced Tea',        'Tequila', .5, 'shots'),
       ('Long Island Iced Tea',        'Triple Sec', .5, 'shots'),
       ('Kamikaze',                    'Vodka', 1, 'shots'),
       ('Kamikaze',                    'Triple Sec', 1, 'splash'),
       ('Cosmopolitan',                'Vodka', 1, 'shot'),
       ('Cosmopolitan',                'Triple Sec', .5, 'shot'),
       ('Apple Martini',               'Vodka', 1, 'shot'),
       ('Apple Martini',               'Apple Schnapps', 1, 'shot'),
       ('White Russian',               'Vodka', 1, 'shot'),
       ('White Russian',               'Kahlua', .5, 'shot'),
       ('Old Fashioned',               'Whiskey', 1.5, 'shots'),
       ('Mint Julep',                  'Whiskey', 2, 'shots'),
       ('Rob Roy',                     'Whiskey', 2, 'shots'),
       ('Rob Roy',                     'Vermouth', 2, 'shots'),
       ('Manhattan',                   'Whiskey', 2, 'shots'),
       ('Manhattan',                   'Vermouth', .5, 'shots'),
       ('Whiskey Sour',                'Whiskey', 1, 'shots'),
       ('Gin Gimlet',                  'Gin', 1, 'shot'),
       ('Alabama Slammer',             'Amaretto', .5, 'shot'),
       ('Alabama Slammer',             'Southern Comfort', .5, 'shot'),
       ('Alabama Slammer',             'Sloe Gin', .5, 'shot'),
       ('Negroni',                     'Gin', .75, 'shots'),
       ('Negroni',                     'Vermouth', .75, 'shots'),
       ('Dirty Martini',               'Gin', 1.5, 'shots'),
       ('Dirty Martini',               'Vermouth', .5, 'shots'),
       ('Singapore Sling',             'Gin', 2, 'shots'),
       ('Singapore Sling',             'Whiskey', 1, 'shots'),
       ('Tom Collins',                 'Gin', 2, 'shots'),
       ('Chocolate Cake',              'Frangelico', .5, 'shots'),
       ('Chocolate Cake',              'Vodka', .5, 'shots'),
       ('B-52',                        'Kahlua', .5, 'shots'),
       ('B-52',                        'Amaretto', .5, 'shots'),
       ('Surfer on Acid',              'Jägermeister', .5, 'shot'),
       ('Surfer on Acid',              'Coconut Rum', .5, 'shot'),
       ('Buttery Nipple',              'Butterscotch Liqueur', .75, 'shot'),
       ('Tequila Shot',                'Tequila', 1, 'shot'),
       ('Margarita',                   'Tequila', 2, 'shots'),
       ('Margarita',                   'Triple Sec', .75, 'shots'),
       ('Mexican Martini',             'Tequila', 1.5, 'shots'),
       ('Mexican Martini',             'Cointreau', 1, 'shot'),
       ('Tequila Sunrise',             'Tequila', 2, 'shots'),
       ('Frozen Cranberry Margarita',  'Tequila', 1, 'shot'),
       ('Frozen Cranberry Margarita',  'Triple Sec', 1, 'shot');

INSERT INTO ingredient_list_add_on
VALUES ('Strawberry Daiquiri',         'Strawberries', 5, 'crushed'),
       ('Strawberry Daiquiri',         'Lime Juice', 1, 'shot'),
       ('Strawberry Daiquiri',         'Sugar', 1, 'pinch'),
       ('Mai Tai',                     'Lime Juice', 1, 'shot'),
       ('Mai Tai',                     'Almond Syrup', 1, 'drop'),
       ('Hurricane',                   'Orange Juice', 1, 'shot'),
       ('Hurricane',                   'Passion Fruit Juice', 1, 'shot'),
       ('Hurricane',                   'Lime Juice', 1, 'shot'),
       ('Dark and Stormy',             'Ginger Beer', 4, 'shots'),
       ('Dark and Stormy',             'Lime Juice', .5, 'shots'),
       ('Flaming Dr. Pepper',          'Beer', 2, 'shots'),
       ('Long Island Iced Tea',        'Sweet and Sour Mix', 1, 'shots'),
       ('Long Island Iced Tea',        'Cola', 1, 'shots'),
       ('Kamikaze',                    'Lime Juice', 1, 'splash'),
       ('Kamikaze',                    'Sweet and Sour Mix', 1, 'splash'),
       ('Cosmopolitan',                'Cranberry Juice', 1, 'splash'),
       ('Cosmopolitan',                'Lime Juice', 1, 'splash'),
       ('Apple Martini',               'Apple Juice', 1, 'shot'),
       ('White Russian',               'Cream', 1, 'splash'),
       ('Old Fashioned',               'Bitters', 2, 'dashes'),
       ('Old Fashioned',               'Orange Slice', 2, ''),
       ('Old Fashioned',               'Lemon Slice', 2, ''),
       ('Old Fashioned',               'Sugar', 1, 'teaspoon'),
       ('Mint Julep',                  'Mint Leafs', 6, ''),
       ('Mint Julep',                  'Sugar', 1, 'teaspoon'),
       ('Rob Roy',                     'Bitters', 1, 'dash'),
       ('Manhattan',                   'Bitters', 2, 'dashes'),
       ('Manhattan',                   'Orange Peel', 1, 'twist'),
       ('Whiskey Sour',                'Sugar', .5, 'teaspoon'),
       ('Whiskey Sour',                'Lemon Juice', 1, 'shot'),
       ('Gin Gimlet',                  'Lime Juice', .5, 'shot'),
       ('Gin Gimlet',                  'Sugar', 1, 'pinch'),
       ('Gin Gimlet',                  'Lemon Slice', 1, ''),
       ('Alabama Slammer',             'Orange Juice', 1, 'splash'),
       ('Alabama Slammer',             'Sweet and Sour Mix', 1, 'splash'),
       ('Negroni',                     'Bitters', .75, 'shots'),
       ('Dirty Martini',               'Olive Juice', .5, 'shots'),
       ('Singapore Sling',             'Grenadine', 1, 'shots'),
       ('Singapore Sling',             'Club Soda', 3, 'shots'),
       ('Singapore Sling',             'Sweet and Sour Mix', 1, 'shot1'),
       ('Tom Collins',                 'Club Soda', 3, 'shots'),
       ('Tom Collins',                 'Lime Juice', 1, 'shot'),
       ('Tom Collins',                 'Sugar', 1, 'pinch'),
       ('Chocolate Cake',              'Sugar', 1, 'pinch'),
       ('Chocolate Cake',              'Lemon Slice', 1, ''),
       ('B-52',                        'Cream', 1, 'splash'),
       ('Surfer on Acid',              'Pineapple Juice', .5, 'shot'),
       ('Buttery Nipple',              'Cream', .25, 'shot'),
       ('Tequila Shot',                'Salt', 1, 'pinch'),
       ('Tequila Shot',                'Lime Juice', .25, 'shot'),
       ('Margarita',                   'Sweet and Sour Mix', 2, 'shots'),
       ('Margarita',                   'Lime Juice', 1, 'shot'),
       ('Margarita',                   'Orange Juice', .5, 'shot'),
       ('Margarita',                   'Salt', 1, 'pinch'),
       ('Mexican Martini',             'Sweet and Sour Mix', 1.5, 'shot'),
       ('Mexican Martini',             'Lime Juice', .75, 'shot'),
       ('Mexican Martini',             'Orange Juice', .75, 'shot'),
       ('Mexican Martini',             'Sprite', 1, 'shot'),
       ('Tequila Sunrise',             'Grenadine', 2, 'dashes'),
       ('Tequila Sunrise',             'Orange Juice', 4, 'shots'),
       ('Frozen Cranberry Margarita',  'Sweet and Sour Mix', 1, 'shot'),
       ('Frozen Cranberry Margarita',  'Cranberry Juice', 1.5, 'shots'),
       ('Frozen Cranberry Margarita',  'Lime Juice', .75, 'shots');



INSERT INTO review
VALUES ('tsdiuco',    'Dark and Stormy', 5),
       ('tsdiuco',    'Long Island Iced Tea', 4),
       ('tsdiuco',    'Tequila Shot', 2),
       ('ecgustin',   'Tequila shot', 5),
       ('ecgustin',   'Long Island Iced Tea', 5),
       ('ecgustin',   'Old Fashioned', 3),
       ('awcalmette', 'Dark and Stormy', 3),
       ('awcalmette', 'Kamikaze', 5),
       ('awcalmette', 'Strawberry Daiquiri', 5),
       ('dmkar',      'Gin Gimlet', 2),
       ('dmkar',      'Mai Tai', 5),
       ('dmkar',      'Old Fashioned', 1);