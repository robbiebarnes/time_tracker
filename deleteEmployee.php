<?php
    include('config.php');

    $id = mysqli_real_escape_string($db, $_POST['id']);

    $sql1 = "DELETE FROM EMP_ACTIVITY WHERE empid = '$id'";

    $result1 = mysqli_query($db, $sql1);

    
    $sql2 = "DELETE FROM EMPLOYEE WHERE id = '$id'";

    $result2 = mysqli_query($db, $sql2);
    
    echo $result2;
    
    

?>