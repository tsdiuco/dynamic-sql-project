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
         print("Thank You")
      else:
         print("Not a username")

      con.close()

   except mysql.connector.Error as err:
      print(err)

# # OLTP Functionality

# def addUser():

# def removeUser():

# def addReview():

# def listIngredientsOnHand():

# def editOnHandIngredientsList():

# def editOnHandSpiritsList():

# def requestRecipe():

# def increseRecipePortion():

# def findHighestRatedRecipe():

# # OLAP Functionality

# def findAccessableRecipies():

# def filterCocktailRecipies():

# def returnMostUsedIngredients():

# def returnMostUsedSpirits():

# def returnMostUsedIngredients(favSpirit):

# def returnMostUsedIngredients(favSpirit):

# Other Functions

def confirmUserName(username_input, con):
   rs = con.cursor(buffered=True)
   query = """ SELECT username
               FROM application_user;"""
   rs.execute(query)
   for (username) in rs:
      if username == username_input:
         rs.close()
         return True
   rs.close()
   return False

def printWelcomePrompt():
   print("***OLTP Transactions***")
   print("1. Add a User")
   print("2. Remove a User")
   print("3. Add a Review")
   print("4. List Ingredients You Have")
   print("5. Edit Spirits You Have")
   print("6. Edit Ingredients You Have")
   print("7. Search For a Recipe")
   print("8. Make Multiple Portions of a Recipe")
   print("9. Find Highest Rated Recipe\n")
   print("***OLAP Transactions***")
   print("10. Find Recipes Based on What You Have")
   print("11. Find Recipes by Filter")
   print("12. Find Most Common Add Ons")
   print("13. Find Most Common Spirits")
   print("14. Find Most Common Add OnsFrom Your Favorite Spirit")
   print("15. Find Most Common Spirits From Your Favorite Spirit")

if __name__ == '__main__':
   main()
