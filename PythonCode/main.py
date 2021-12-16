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
         while menuSelection != '14':
            printOptionsMenu()
            menuSelection = input("Enter option")
            if menuSelection == 1:
               addReview(username, con)
         print("See you Later!")
      else:
         print("Username Not found...restart program to try again :)")

      con.close()

   except mysql.connector.Error as err:
      print(err)

# # OLTP Functionality

def addReview():
   rs = con.cursor(buffered=True)
   query = """ SELECT username, age
               FROM application_user;"""
   rs.execute(query)

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
   print("4. Edit Ingredients You Have")
   print("5. Search For a Recipe")
   print("6. Make Multiple Portions of a Recipe")
   print("7. Find Highest Rated Recipe\n")
   print("***OLAP Transactions***")
   print("8. Find Recipes Based on What You Have")
   print("9. Find Recipes by Filter")
   print("10. Find Most Common Add Ons")
   print("11. Find Most Common Spirits")
   print("12. Find Most Common Add OnsFrom Your Favorite Spirit")
   print("13. Find Most Common Spirits From Your Favorite Spirit")
   print("14. Exit")

if __name__ == '__main__':
   main()
