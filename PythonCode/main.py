import config
import mysql.connector

def main():
   try:
      # connection info
      usr = config.mysql['user']
      pwd = config.mysql['password']
      hst = config.mysql['host']
      db = 'tdiuco_DB'

      # create a connection with database
      con = mysql.connector.connect(user = usr,
                                    password = pwd,
                                    host = hst,
                                    database = db)

      # Main Functionality
      print("*** Welcome to Cocktail Creator ***")
      username = input("Please Enter Your User Name: ")
      if confirmUserName(username, con):
         print("Hello, " + username)
         menuSelection = None
         while menuSelection != '10':
            printOptionsMenu()
            menuSelection = input("Enter option: ")
            if menuSelection == '1':
               addReview(username, con)
            elif menuSelection == '2':
               listIngredientsOnHand(username, con)
            elif menuSelection == '3':
               editOnHandSpiritsList(username, con)
            elif menuSelection == '4':
               requestRecipe(con)
            elif menuSelection == '5':
               findHighestRatedRecipe(con)
            elif menuSelection == '6':
               findAccessableRecipies(username, con)

         print("See you Later!")
      else:
         print("Username Not found...restart program to try again :)")

      con.close()

   except mysql.connector.Error as err:
      print(err)

# # OLTP Functionality

def addReview(username, con):
   rs = con.cursor()
   cocktail = input("Cocktail: ")
   if checkCocktailExists(cocktail, con):
      rating = input("Rating: ")
      query = """INSERT INTO review Values (%s, %s,%s);"""
      rs.execute(query, (username, cocktail, rating))
      # SET innodb_lock_wait_timeout = 120;
      # This is a command that I had to enter in the mysql database command
      # line. I don't exactly know what it does but with out it, I get error:
      # 1205 (HY000): Lock wait timeout exceeded; try restarting transaction
      con.commit()
   else:
      print("Cocktail Does Not Exist")
   rs.close()

def listIngredientsOnHand(usernameInput, con):
   rs = con.cursor()
   query = f'''SELECT spirit
               FROM spirit_user_has
               WHERE username = "{usernameInput}";'''
   rs.execute(query)
   print("Spirits: ")
   for (spirit) in rs:
      print('{}'. format(spirit))

   query = f'''SELECT add_on
               FROM add_on_user_has
               WHERE username = "{usernameInput}";'''
   rs.execute(query)
   print("Add Ons: ")
   for (add_on) in rs:
      print('{}'. format(add_on))
   rs.close()

def editOnHandSpiritsList(username, con):
   addOrRemove = input("Would you like to add or remove? (a/r): ")
   rs = con.cursor()
   if addOrRemove == 'a':
      spiritToAdd = input("What would you like to add?: ")
      query = f'''INSERT INTO spirit_user_has VALUE ("{username}", "{spiritToAdd}");'''
      rs.execute(query)
      con.commit()
   elif addOrRemove == 'r':
      spiritToRemove = input("What would you like to remove?: ")
      query = f'''DELETE FROM spirit_user_has
                  WHERE username = "{username}" AND spirit = "{spiritToRemove}";'''
      rs.execute(query)
      con.commit()
   rs.close()

def requestRecipe(con):
   requestedRecipe = input("What would you like the recipe for?: ")
   rs = con.cursor()
   query = f'''SELECT *
               FROM ingredient_list_spirit
               WHERE cocktail_name = "{requestedRecipe}";'''
   rs.execute(query)
   print(requestedRecipe + ":")
   for (cocktail_name, spirit, amount, amount_unit) in rs:
      print('{} - {} {}'. format(spirit, amount, amount_unit))

   query = f'''SELECT *
               FROM ingredient_list_add_on
               WHERE cocktail_name = "{requestedRecipe}";'''
   rs.execute(query)

   for (cocktail_name, add_on, amount, amount_unit) in rs:
      print('{} - {} {}'. format(add_on, amount, amount_unit))

   rs.close()

# # OLAP Functionality
def findHighestRatedRecipe(con):
   rs = con.cursor()
   query = f'''SELECT cocktail, AVG(userRating) AS Rating
               FROM review
               GROUP BY cocktail
               HAVING AVG(userRating) >= ALL (SELECT AVG(userRating)
                                             FROM review
                                             GROUP BY cocktail);'''
   rs.execute(query)
   for (cocktail, Rating) in rs:
      print('{} ({}/5)'. format(cocktail, Rating))

def findAccessableRecipies(username, con):
   rs = con.cursor()
   query = f'''SELECT spirit
               FROM spirit_user_has
               WHERE username = "{username}";'''
   rs.execute(query)
   for (cocktail, Rating) in rs:
      print('{} ({}/5)'. format(cocktail, Rating))

# def filterCocktailRecipies():

# def returnMostUsedIngredients():

def findMostComplicatedRecipes(con):
   rs = con.cursor(buffered=True)
   query = """ SELECT a.cocktail_name, SUM(a.num) AS number_of_ingredients
               FROM ((SELECT cocktail_name, count(*) AS num
                      FROM ingredient_list_spirit
                     GROUP BY cocktail_name)
                    UNION
                    (SELECT cocktail_name, count(*) AS num
                     FROM ingredient_list_add_on
                     GROUP BY cocktail_name)) AS a
               GROUP BY a.cocktail_name
               ORDER BY number_of_ingredients DESC, a.cocktail_name;"""
   rs.execute(query)
   for (cocktail_name, number_of_ingredients) in rs:
      print('{}: {}'. format(cocktail_name, number_of_ingredients))
   rs.close()

# def returnMostUsedSpirits():

# Other Functions

def checkCocktailExists(cocktailInput, con):
   rs = con.cursor(buffered=True)
   query = """ SELECT cocktail_name, abv
               FROM cocktail_recipe;"""
   rs.execute(query)
   for (cocktail_name, abv) in rs:
      if cocktail_name == cocktailInput:
         rs.close()
         return True
   rs.close()
   return False

def confirmUserName(username_input, con):
   rs = con.cursor(buffered=True)
   query = """ SELECT username, age
               FROM application_user;"""
   rs.execute(query)
   for (username, age) in rs:
      if username == username_input:
         rs.close()
         return True
   rs.close()
   return False

def printOptionsMenu():
   print("\n")
   print("***OLTP Transactions***")
   print("1. Add a Review")
   print("2. List Ingredients You Have")
   print("3. Edit Spirits You Have")
   print("4. Search For a Recipe\n")
   print("***OLAP Transactions***")
   print("5. Find Highest Rated Recipe")
   print("6. Find Recipies with the Most Ingredients")
   print("7. Find Recipes Based on What You Have")
   print("8. Find Recipes by Filter")
   print("9. Find Most Common Spirits")
   print("10. Exit")

if __name__ == '__main__':
   main()
