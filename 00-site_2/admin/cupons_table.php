<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

if($_SESSION['logged'] != 1) {
    header('location: admin_login.php');
}

$db = open_db();
$users_query = $db->prepare("SELECT * FROM cupons");
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
                                    <th>Cupom</th>
                                    <th>Dias</th>
                                    <th>Validade</th>
                                </tr>
                            <tbody>";
while($row = $users_query->fetchObject())
{   
    $html .= "<tr>";
    $html .= "<td><a style='color: black;' href='cupom_detail.php?id=$row->id'>".$row->id."</a></td>";
    $html .= "<td><a style='color: black;' href='cupom_detail.php?id=$row->id'>".$row->cupom."</a></td>";
    $html .= "<td><a style='color: black;' href='cupom_detail.php?id=$row->id'>".$row->dias."</a></td>";
    $html .= "<td><a style='color: black;' href='cupom_detail.php?id=$row->id'>".$row->validade."</a></td>";
    $html .= "</tr>";
}
$html .= "</tbody>
      </table>
      </div></div></div></div></div></div>";
buildLayout($html);
?>