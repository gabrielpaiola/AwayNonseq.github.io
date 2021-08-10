<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

if($_SESSION['logged'] != 1) {
    header('location: admin_login.php');
}

$db = open_db();
$users_query = $db->prepare("SELECT * FROM msglauncher");
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
                                    <th>Linha 1</th>
                                    <th>Linha 2</th>
                                    <th>Linha 3</th>
                                    <th>Linha 4</th>
                                    <th>Linha 5</th>
                                    <th>Linha 6</th>
                                    <th>Linha 7</th>
                                    <th>Linha 8</th>
                                    <th>Linha 9</th>
                                    <th>Linha 10</th>
                                    <th>Linha 11</th>
                                    <th>Linha 12</th>
                                    <th>Linha 13</th>
                                    <th>Linha 14</th>
                                    <th>Linha 15</th>
                                </tr>
                            <tbody>";
while($row = $users_query->fetchObject())
{   
    $html .= "<tr>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->id."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha1."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha2."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha3."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha4."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha5."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha6."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha7."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha8."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha9."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha10."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha11."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha12."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha13."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha14."</a></td>";
    $html .= "<td><a style='color: black;' href='msg_launcher_detail.php?id=$row->id'>".$row->linha15."</a></td>";
    $html .= "</tr>";
}
$html .= "</tbody>
      </table>
      </div></div></div></div></div></div>";
buildLayout($html);
?>