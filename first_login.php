<?php
require_once('./dist/db.php');
$username = $_GET['user'];
$machineid = $_GET['id'];

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM users WHERE username = ?');
 $result = $stmt->execute([$username]);
 $row = $stmt->fetchObject();

 if($row == null) {
     return;
 }

 if($row->machine_id1 == null || $row->machine_id1 == '') {
     
    $query = $db->prepare('UPDATE users SET 
    machine_id1 = :machineid1
    WHERE username = :username');

    $query->execute(array(
    ':machineid1' => "$machineid",
    ':username' => "$username"
    ));
 }

 $db = null;
?>