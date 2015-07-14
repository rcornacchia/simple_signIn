<?php
        // import connection file
        require_once "common.php";
        $email = $_POST['email'];

        //query db to see if email exists
        $query = sprintf("SELECT Users.uname FROM Users WHERE Users.uemail = '%s'", $email);
        $result = mysqli_query($conn, $query);
        $numRows = $result -> num_rows;
        if($numRows == 0) {
                //user doesn't exist, return error
                $arr = array("value1" => "Email " . $email . " not found! Please register.");
        } else {
                //user does exist, return name
                $row = mysqli_fetch_assoc($result);
                $name = $row['uname'];
                $arr = array("value1" => $name);
        }       
        echo json_encode($arr);

?>

