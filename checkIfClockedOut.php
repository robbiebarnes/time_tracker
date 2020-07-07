
<?php
    include('config.php');


    $id = mysqli_real_escape_string($db, $_POST['id']);


    #$sql = mysqli_query($db, "SELECT ACTIVITY_LOG.end_datetime FROM ACTIVITY_LOG, EMP_ACTIVITY WHERE ACTIVITY_LOG.id = EMP_ACTIVITY.activityid AND EMP_ACTIVITY.empid = '$id' ORDER BY ACTIVITY_LOG.id DESC LIMIT 1");
    #$result = mysqli_fetch_array($sql,MYSQLI_ASSOC);

    #echo $result['end_datetime'];

    $sql = "SELECT ACTIVITY_LOG.end_datetime FROM ACTIVITY_LOG, EMP_ACTIVITY WHERE ACTIVITY_LOG.id = EMP_ACTIVITY.activityid AND EMP_ACTIVITY.empid = '$id' ORDER BY ACTIVITY_LOG.id DESC LIMIT 1";

    if ($result = mysqli_query($db, $sql)) {
        if (mysqli_num_rows($result)) {
            $return = mysqli_fetch_array($result,MYSQLI_ASSOC);
            echo $return['end_datetime'];
        }
        else {
            echo "No Data";
        }
    }
?>