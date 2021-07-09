<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

if($_SESSION['logged_user'] != 1) {
    header('location: user_login.php');
}
$id = $_SESSION['user_id'];

$db = open_db();
 $stmt = $db->prepare('SELECT * FROM users WHERE id = ?');
 $result = $stmt->execute([$id]);
 $row = $stmt->fetchObject();
 
 $_SESSION['user_status'] = $row->status;
 $date = date('d/m/Y', strtotime($row->expiry_date));
 $status = $row->status == 1 ? "Ativo" : "Inativo";
 $package = $row->package;
 $username = $row->username;
 $email = $row->email;
 $created_at = date('d/m/Y', strtotime($row->created_at));

 $db = null;

$html = '';

$html .= "<div class='content'>
            <div class='container-fluid'>
            <div class='row'>
                <div class='col-md-12'>
                <div class='card' style='padding: 20px'>
                <p>Status: $status</p>
                <p>Data de expiração: $date</p>
                <p>Pacote: $package</p>
                <p>Usuario: $username</p>
                <p>Email: $email</p>
                <p>Usuario Criado: $created_at</p>
                ";

$html .= "
      </div></div></div></div></div>";
buildLayout($html);
?>