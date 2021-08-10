<?php 
session_start();
require_once('../dist/db.php');
date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date('Y'); 
$Mes = date("m");
$dt_atual = $Ano."-".$Mes."-".$Dia;

if($_SESSION['logged'] != 1) {
    header('location: admin_login.php');
}

$db = open_db();
$users_query = $db->prepare("SELECT * FROM users");
$result = $users_query->execute();

while($row = $users_query->fetchObject())
{   
    if (strtotime($dt_atual) > strtotime($row->expiry_date)){
        
        $status = 0;

        $query = $db->prepare('UPDATE users SET 
        status = :status 
        WHERE id = :id');
        
        $query->execute(array(
        ':status' => $status,
        ':id' => $row->id
        ));
    }
}
header('location: ../admin/users_table.php');
?>