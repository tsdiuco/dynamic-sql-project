# CPSC 321 Final Project (Fall 2021)

Instructions for Technologies Used:

1. Check for access to Python3 Interpreter
   a. Refer to url for detailed information about how to install/update Python Interpreter on you local machine
      i. https://wiki.python.org/moin/BeginnersGuide/Download

2. Install MySQL Connector
   a. This program requires installation of MySQL Connector which includes functionality to dynamically interact with MySQL/MariaDB databases
   b. More information about how to install can be found below:
      i. https://dev.mysql.com/doc/connector-python/en/connector-python-installation-binary.html

3. Clone GitHub repository
   a. Navigate to a directory that is easily accessable and where you want to save the repository's contents
   b. From the command line, execute the below argument:
      i. git clone https://github.com/Gonzaga-CPSC-321-Fall-2021/project-tsdiuco.git

4. Access MariaDB database
   a. Change directory to the top level of the cloned repository
   b. Access MariaDB server with this command:
      i. mysql -p -h cps-database
   c. Enter password
   d. Switch to desired database

5. Initalize database schema
   a. Execute project_schema.sql using command:
      i. source project_schema.sql
   b. Confirm database was initialized without errors/warnings

6. Enter credentials
   b. Change directory to the top level of the cloned repository, then PythonCode
   c. Edit config.py file
      i. 'user' = 'your_MariaDB_username'
      ii. 'password' = 'your_MariaBD_password'
      iii. 'host' field requires NO changes

7. Execute Python script
   a. Switch back to repository or open a new terminal window
   b. Switch to PythonCode directory
   c. Execute this argument on the command line:
      i. python3 main.py\

8. Follow prompt given by program

