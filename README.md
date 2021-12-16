## Instructions for Technologies Used:

1. George Washington
   - John Adams
     - Thomas Jefferson

1. Check for access to Python3 Interpreter
     - Refer to url for detailed information about how to install/update Python Interpreter on you local machine
       - https://wiki.python.org/moin/BeginnersGuide/Download

2. Install MySQL Connector
     - This program requires installation of MySQL Connector which includes functionality to dynamically interact with MySQL/MariaDB databases
     - More information about how to install can be found below:
       - https://dev.mysql.com/doc/connector-python/en/connector-python-installation-binary.html
      
3. Clone GitHub repository
   - Navigate to a directory that is easily accessable and where you want to save the repository's contents
   - From the command line, execute the below argument:
     - `git clone https://github.com/Gonzaga-CPSC-321-Fall-2021/project-tsdiuco.git`

4. Access MariaDB database
   - Change directory to the top level of the cloned repository
   - Access MariaDB server with this command:
     - `mysql -p -h cps-database`
   - Enter password
   - Switch to desired database

5. Initalize database schema
   - Execute project_schema.sql using command:
     - `source project_schema.sql`
   - Confirm database was initialized without errors/warnings

6. Enter credentials
   - Change directory to the top level of the cloned repository, then PythonCode
   - Edit config.py file
     - 'user' = 'your_MariaDB_username'
     - 'password' = 'your_MariaBD_password'
     - 'host' field requires NO changes

7. Execute Python script
   - Switch back to repository or open a new terminal window
   - Switch to PythonCode directory
   - Execute this argument on the command line:
     - `python3 main.py`

8. Follow prompt given by program

