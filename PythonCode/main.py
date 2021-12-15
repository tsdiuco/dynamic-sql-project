import config
from finalProject import *
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
      welcomeSelection = None
      printWecomePrompt()
      while welcomeSelection != 0 or welcomeSelection != 1:
         welcomeSelection = input("Enter your selection (1 or 2): ")
         if (welcomeSelection == 1)
            printOLTPTransactions()
         elif (welcomeSelection == 2):
            printOLAPTransations()
         else:
            print("Invalid Input...")
            printWelcomePrompt()

      

      con.close()

   except mysql.connector.Error as err:
      print(err)

if __name__ == '__main__':
   main()
