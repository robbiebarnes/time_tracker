<?php
    include("config.php");

    $sql = "SELECT * FROM EMPLOYEE";
    
    
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
