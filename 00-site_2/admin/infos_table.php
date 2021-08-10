<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

if($_SESSION['logged'] != 1) {
    header('location: admin_login.php');
}

if($_SESSION['adm_logged'] != 1) {
    header('location: users_table.php');
}

$db = open_db();
$users_query = $db->prepare("SELECT * FROM infos");
$result = $users_query->execute();

$html = '';

$html .= "<div class='content'>
            <div class='container-fluid'>
            <div class='row'>
                <div class='col-md-12'>
                <div class='card' style='padding: 20px'>
                    <div class='table-responsive'>
                        <table id='users' class='table'>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Versao Oficial</th>
                                    <th>Versao Beta</th>
                                    <th>Versao Launcher</th>
                                    <th>Download</th>
                                    <th>Seguranca</th>
                                </tr>
                            <tbody>";
while($row = $users_query->fetchObject())
{   
    $html .= "<tr>";
    $html .= "<td><a style='color: black;' href='info_detail.php?id=$row->id'>".$row->id."</a></td>";
    $html .= "<td><a style='color: black;' href='info_detail.php?id=$row->id'>".$row->versao_oficial."</a></td>";
    $html .= "<td><a style='color: black;' href='info_detail.php?id=$row->id'>".$row->versao_beta."</a></td>";
    $html .= "<td><a style='color: black;' href='info_detail.php?id=$row->id'>".$row->versao_launcher."</a></td>";
    $html .= "<td><a style='color: black;' href='info_detail.php?id=$row->id'>".$row->link_download."</a></td>";
    $html .= "<td><a style='color: black;' href='info_detail.php?id=$row->id'>".$row->security."</a></td>";
    $html .= "</tr>";
}
$html .= "</tbody>
      </table>
      </div></div></div></div></div></div>";
buildLayout($html);
?>