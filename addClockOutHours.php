<?php
    include('config.php');


    $id = mysqli_real_escape_string($db, $_POST['id']);
    $end_datetime = mysqli_real_escape_string($db, $_POST['end_datetime']);

    $end = date_create($end_datetime);
    $date = date_format($end,"Y-m-d H:i:s");

    $sql = mysqli_query($db, "SELECT activityid FROM EMP_ACTIVITY WHERE empid = '$id' ORDER BY activityid DESC LIMIT 1");
    $result = mysqli_fetch_array($sql,MYSQLI_ASSOC);
    $empid = $result['activityid'];

    $sql1 = "UPDATE ACTIVITY_LOG SET end_datetime = '$date' WHERE id = '$empid'";
    
    $result1 = mysqli_query($db, $sql1);

    echo $result1;

?>