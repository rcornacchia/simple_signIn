<?php
        // import connection file
        require_once "common.php";

				// get email and name
        $email = $_POST['email'];
				$name = $_POST['name'];

				// insert user
				$query = sprintf("INSERT INTO Users (uname, uemail) VALUES ('%s', '%s')", $name, $email);
        $result = mysqli_query($conn, $query);
?>
