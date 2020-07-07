<?php
    include('config.php');

    $id = mysqli_real_escape_string($db, $_POST['id']);
    $email = mysqli_real_escape_string($db, $_POST['email']);
    $first_name = mysqli_real_escape_string($db, $_POST['first_name']);
    $last_name = mysqli_real_escape_string($db, $_POST['last_name']);
    $phone = mysqli_real_escape_string($db, $_POST['phone']);
    $active = mysqli_real_escape_string($db, $_POST['active']);



    $sql = "UPDATE EMPLOYEE SET email = '$email', first_name = '$first_name', last_name = '$last_name', phone = '$phone', active = '$active' WHERE id = '$id' "; 
    
    $result = mysqli_query($db, $sql);

    echo $result;
?>