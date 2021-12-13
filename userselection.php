<html>
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link href="style.css" rel="stylesheet">
      <title>Cocktail Creator</title>
   </head>
   <body>
      <h1>Welcome Back...</h1>
      <p>Please Select the User:</p>
      <?php
         $config = parse_ini_file("config.ini");
         $server = $config["servername"];
         $username = $config["username"];
         $password = $config["password"];
         $database = "tdiuco_DB";

         // connect
         $conn = mysqli_connect($server, $username, $password, $database);

         if (!$conn) {
            die("Connection failed: ".mysqli_connect_error());
         }

         $query = '  SELECT username
                     FROM application_user ORDER BY username;';

         $result = mysqli_query($conn, $query);

         if (mysqli_num_rows($result)>0) {
            echo '<form action = "helloWorld.html" method="POST">';
            echo '<select name="username">';
            while($row = mysqli_fetch_assoc($result)) {
               echo '<option value="' . $row["username"] . '">' . $row["username"] . '</option>';
            }
         }
         else {
            echo "<b>Users</b>";
         }
         mysqli_close($conn);
      ?>
         </select>
         <input type="submit" value="Submit">
      </form>
   </body>
</html>