<?php
    include('config.php');


    $email = mysqli_real_escape_string($db, $_POST['email']);
    $first_name = mysqli_real_escape_string($db, $_POST['first_name']);
    $last_name = mysqli_real_escape_string($db, $_POST['last_name']);
    $phone = mysqli_real_escape_string($db, $_POST['phone']);
    $active = mysqli_real_escape_string($db, $_POST['active']);



    $sql = "INSERT INTO EMPLOYEE (email, first_name, last_name, phone, active) VALUES ('$email', '$first_name', '$last_name', '$phone', '$active')";
    
    $result = mysqli_query($db, $sql);

    echo $result;
?>