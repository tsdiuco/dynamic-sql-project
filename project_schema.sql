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
   PRIMARY KEY (cocktail_name),
   FOREIGN KEY (main_spirit) REFERENCES spirit(spirit_name)
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
VALUES ('Rum', 40),
       ('Vodka', 40),
       ('Whiskey',45),
       ('Gin', 40),
       ('Tequila', 40),
       ('Triple Sec', 25),
       ('Amaretto', 25),
       ('Kahlua', 20),
       ('Vermouth', 15),

       ('Fragelico', 15),
       ('Southern Comfort', 15),
       ('Butterscotch Liqueur', 15),
       ('Cointreau', 15),
       ('Blue Curaçao', 15),
       ('Peach Schnapps', 15),
       ('Apple Schnapps', 15),
       ('Jägermeister', 15),
       ('Chambord', 15),
       ('Creme de Cassis', 15),
       ('Creme de Cassis', 15),



       ('Coffee Liqueur', 20),
       ('Irish Cream Liqueur', 17),
       ('Orange Liqueur', 35),
       ('Liqueur', 25),
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
VALUES ('Strawberry Daiquiri', 31, 'Rum'),
       ('Mai Tai', 29, 'Rum'),
       ('Hurricane', 19, 'Rum'),
       ('Dark and Stormy', 15, 'Rum'),
       ('Flaming Dr. Pepper', 14, 'Rum'),
       ('Mojito', 14, 'Rum'),
       ('Planters Punch', 12, 'Rum'),
       ('Blue Hawaiian', 12, 'Rum'),
       ('Piña Colada', 10, 'Rum'),
       ('Cuba Libra', 8, 'Rum'),
       ('Long Island Iced Tea', 28, 'Vodka'),
       ('Kamikaze', 23, 'Vodka'),
       ('Cosmopolitan', 22, 'Vodka'),
       ('Apple Martini', 18, 'Vodka'),
       ('White Russian', 15, 'Vodka'),
       ('Bloody Mary', 12, 'Vodka'),
       ('Sex on the Beach', 11, 'Vodka'),
       ('Hairy Navel', 9, 'Vodka'),
       ('Screwdriver', 8, 'Vodka'),
       ('Sea Breeze', 8, 'Vodka'),
       ('Old Fashioned', 35, 'Whiskey'),
       ('Mint Julep', 33, 'Whiskey'),
       ('Rob Roy', 31, 'Whiskey'),
       ('Manhattan', 27, 'Whiskey'),
       ('Whisey Sour', 27, 'Whiskey'),
       ('Pickleback', 20, 'Whiskey'),
       ('Washington Apple', 18, 'Whiskey'),
       ('Hot Toddy', 12, 'Whiskey'),
       ('Irish Coffee', 8, 'Whiskey'),
       ('Jack and Coke', 7, 'Whiskey'),
       ('Gin Gimlet', 32, 'Gin'),
       ('Negroni', 26, 'Gin'),
       ('Dirty Martini', 25, 'Gin'),
       ('Singapore Sling', 16, 'Gin'),
       ('Tom Collins', 16, 'Gin'),
       ('Salty Dog', 13, 'Gin'),
       ('Purple Rain', 11, 'Gin'),
       ('Red Death', 10, 'Gin'),
       ('Gin and Tonic', 7, 'Gin'),
       ('Gin Dizz', 4, 'Gin'),
       ('Chocolate Cake', 32, 'Frangelico'),
       ('Alabama Slammer', 25, 'Southern Comfort'),
       ('B-52', 23, 'Kahlua'),
       ('Surfer on Acid', 19, 'Jägermeister'),
       ('Buttery Nipple', 15, 'Butterscotch Liqueur'),
       ('Sloe Comfortable Screw', 15, 'Sloe Gin'),
       ('Redheaded Slut', 13, 'Jägermeister'),
       ('Chocolate Martini', 13, 'Chocolate Liqueur'),
       ('Jäger Bomb', 9, 'Jägermeister'),
       ('Nuts and Berries', 6, 'Frangelico'),
       ('Tequila Shot', 40, 'Tequila'),
       ('Margarita', 16, 'Tequila'),
       ('Mexican Martini', 16, 'Tequila'),
       ('Tequila Sunrise', 16, 'Tequila'),
       ('Frozen Cranberry Margarita', 14, 'Tequila'),
       ('La Paloma', 12, 'Tequila'),
       ('Mojito Diablo', 11, 'Tequila'),
       ('Matador', 10, 'Tequila'),
       ('Bahia Breeze', 8, 'Tequila'),
       ('Jose and Ginger', 7, 'Tequila');

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