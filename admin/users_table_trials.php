<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date('Y'); 
$Mes = date("m");
$dt_atual = $Ano."-".$Mes."-".$Dia;

if($_SESSION['logged'] != 1) {
    header('location: admin_login.php');
}

$db = open_db();
$users_query = $db->prepare("SELECT * FROM users WHERE package = 'TRIAL' ");
$result = $users_query->execute();



$html = '';

$html .= "<div class='content'>
            <div class='container-fluid'>
            <div class='row'>
                <div class='col-md-12'>
                <div class='card' style='padding: 20px'>
                    <div class='table-responsive'>
                        <table id='users' class='table' data-page-length='20'>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Package</th>
                                    <th>Status</th>
                                    <th>Dias de Uso</th>
                                    <th>Last Login</th>
                                    <th>Indicacao</th>
                                    <th>Discord Tag</th>                                    
                                    <th>Description</th>
                                    <th>Email</th>
                                    <th>Machine ID</th>
                                </tr>
                            <tbody>";
while($row = $users_query->fetchObject())
{   
    $diferenca = strtotime($row->expiry_date) - strtotime($dt_atual);
    $DiasDeUso = floor($diferenca / (60 * 60 * 24)); 
    $status = $row->status == 1 ? "Enable" : "Disable";
    $html .= "<tr>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->id."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->username."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->package."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$status."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$DiasDeUso."</a></td>";    
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->last_login."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->server."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->discord_tag."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->description."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->email."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->machine_id1."</a></td>";
    $html .= "</tr>";
}
$html .= "</tbody>
      </table>
      </div></div></div></div></div></div>";
buildLayout($html);
?>


