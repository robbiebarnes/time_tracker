<?php
    include("config.php");

    $id = mysqli_real_escape_string($db, $_POST['id']);

    $sql = "SELECT ACTIVITY_LOG.id, EMPLOYEE.email, EMPLOYEE.first_name, EMPLOYEE.last_name, ACTIVITY_LOG.start_datetime, ACTIVITY_LOG.end_datetime FROM EMPLOYEE, ACTIVITY_LOG, EMP_ACTIVITY WHERE EMPLOYEE.id = EMP_ACTIVITY.empid AND ACTIVITY_LOG.id = EMP_ACTIVITY.activityid AND EMPLOYEE.id = '$id' ";
    
    
    if ($result = mysqli_query($db, $sql))
    {
    
    $resultArray = array();
    $tempArray = array();
    
    
    while($row = $result -> fetch_object())
    {
    
    $tempArray = $row;
        array_push($resultArray, $tempArray);
    }
    
    
    echo json_encode($resultArray);
    }
    else
    {
        echo "You suck";
    }
    
    
    
    mysqli_close($db);
?>
