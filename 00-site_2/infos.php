<?php
require_once('./dist/db.php');
$username = $_GET['user'];

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM infos');
 $result = $stmt->execute([$username]);
 $row = $stmt->fetchObject();

 if($row == null) {
     return;
 }

 echo "Primo Marcos Infos\n";
 echo $row->versao_oficial."\n";
 echo "Beta".$row->versao_beta."\n";
 echo "Launcher".$row->versao_launcher."\n";
 echo $row->link_download."\n";
 echo $row->security."\n";
 $db = null;
?>