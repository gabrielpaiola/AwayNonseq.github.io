<?php
require_once('./dist/db.php');
$username = $_GET['user'];

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM msglauncher');
 $result = $stmt->execute([$username]);
 $row = $stmt->fetchObject();

 if($row == null) {
     return;
 }

 echo "Primo Launcher MSG\n";
 echo $row->linha1."\n";
 echo $row->linha2."\n";
 echo $row->linha3."\n";
 echo $row->linha4."\n";
 echo $row->linha5."\n";
 echo $row->linha6."\n";
 echo $row->linha7."\n";
 echo $row->linha8."\n";
 echo $row->linha9."\n";
 echo $row->linha10."\n";
 echo $row->linha11."\n";
 echo $row->linha12."\n";
 echo $row->linha13."\n";
 echo $row->linha14."\n";
 echo $row->linha15."";
 
 $db = null;
?>