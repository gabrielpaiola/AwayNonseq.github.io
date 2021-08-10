<?php
require_once('./dist/db.php');
$username = $_GET['user'];

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM users WHERE username = ?');
 $result = $stmt->execute([$username]);
 $row = $stmt->fetchObject();

 if($row == null) {
     return;
 }

 echo "PrimoMarcosCode\n";
 echo $row->username."\n";
 echo date('Ymd', strtotime($row->expiry_date))."\n";
 echo $row->status == 1 ? "Ativo\n" : "Inativo\n";
 if ($row->machine_id1 != null) echo $row->machine_id1."\n";
 if ($row->machine_id2 != null) echo $row->machine_id2."\n";
 if ($row->machine_id3 != null) echo $row->machine_id3."\n";

 $db = null;
?>