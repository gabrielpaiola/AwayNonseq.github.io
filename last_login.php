<?php
date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date("Y"); 
$Mes = date("m");
$hourMin = date('H:i:s');
$dt_atual = $Ano."-".$Mes."-".$Dia."--".$hourMin;

function getUserIP()
{
    if ( !empty($_SERVER['HTTP_CLIENT_IP']) ) {
            // Check IP from internet.
        $ip = $_SERVER['HTTP_CLIENT_IP'].' -1';
       } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']) ) {
            // Check IP is passed from proxy.
        $ip = $_SERVER['HTTP_X_FORWARDED_FOR'].' -2';
       } else {
            // Get IP address from remote address.
        $ip = $_SERVER['REMOTE_ADDR'].' -3';
       }
       return $ip;
      }


$user_ip = getUserIP();




require_once('./dist/db.php');
$username = $_GET['user'];

 $db = open_db();
 $stmt = $db->prepare('SELECT * FROM users WHERE username = ?');
 $result = $stmt->execute([$username]);
 $row = $stmt->fetchObject();

 $stmt_lastlogin = $db->prepare('SELECT * FROM users WHERE last_login = ? LIMIT 1');
 $result_lastlogin = $stmt_lastlogin->execute([$last_login]);
 $row_lastlogin = $stmt_lastlogin->fetchObject();

 if($row == null) {
     return;
 }
     
    $query = $db->prepare('UPDATE users SET 
    last_login = :lastlogin,
    IP = :IP
    WHERE username = :username');

    $query->execute(array(
    ':lastlogin' => "$dt_atual",
    ':IP' => "$user_ip",
    ':username' => "$username"
    ));

 $db = null;
?>