<?php
require_once('./dist/db.php');
$username = $_GET['user'];
$machineid = $_GET['id'];

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM users WHERE username = ?');
 $result = $stmt->execute([$username]);
 $row = $stmt->fetchObject();

 $stmt_machine_id = $db->prepare('SELECT * FROM users WHERE machine_id1 = ? LIMIT 1');
 $result_machine_id = $stmt_machine_id->execute([$machineid]);
 $row_machine_id = $stmt_machine_id->fetchObject();

 if($row == null) {
     return;
 }
 if($row_machine_id != null) {
    $machineid = "ID DUPLICADO - $machineid";
    
    $status = "0";
} else {
    $status = $row->status; 
}
 
        //GRAVACAO NO BANCO
 if($row->machine_id1 == null || $row->machine_id1 == '') {

    $query = $db->prepare('UPDATE users SET 
    machine_id1 = :machineid1,
    status = :status
    WHERE username = :username');

    $query->execute(array(
    ':machineid1' => "$machineid",
    ':status' => "$status",
    ':username' => "$username"
    ));
 }

 $db = null;
?>