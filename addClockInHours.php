<?php
    include('config.php');


    $empid = mysqli_real_escape_string($db, $_POST['id']);
    $start_datetime = mysqli_real_escape_string($db, $_POST['start_datetime']);

    $start = date_create($start_datetime);
    $date = date_format($start,"Y-m-d H:i:s");



    $sql1 = "INSERT INTO ACTIVITY_LOG (start_datetime) VALUES ('$date')";
    
    $result1 = mysqli_query($db, $sql1);

    $activityid = mysqli_insert_id($db);

    $sql2 = "INSERT INTO EMP_ACTIVITY (empid, activityid) VALUES ('$empid', '$activityid')";

    $result2 = mysqli_query($db, $sql2);

    echo $result2;
?>