<?php
    include('config.php');

    $id = mysqli_real_escape_string($db, $_POST['id']);
    $start_datetime = mysqli_real_escape_string($db, $_POST['start_datetime']);
    $end_datetime = mysqli_real_escape_string($db, $_POST['end_datetime']);

    $start = date_create($start_datetime);
    $end = date_create($end_datetime);
    $date1 = date_format($start,"Y-m-d H:i:s");
    $date2 = date_format($end,"Y-m-d H:i:s");

    $sql = "UPDATE ACTIVITY_LOG SET start_datetime = '$date1', end_datetime = '$date2' WHERE id = '$id' "; 
    
    $result = mysqli_query($db, $sql);

    echo $result;
?>