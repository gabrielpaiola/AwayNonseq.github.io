<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

if($_SESSION['logged'] != 1) {
    header('location: admin_login.php');
}

$db = open_db();
$users_query = $db->prepare("SELECT * FROM users");
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
                                    <th>Expiry Date</th>
                                    <th>Status</th>
                                    <th>Last Login</th>
                                    <th>Indicacao</th>
                                    <th>Package</th>
                                    <th>Description</th>
                                    <th>Machine ID</th>
                                </tr>
                            <tbody>";
while($row = $users_query->fetchObject())
{   
    $status = $row->status == 1 ? "Enable" : "Disable";
    $html .= "<tr>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->id."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->username."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->expiry_date."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$status."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->last_login."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->server."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->package."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->description."</a></td>";
    $html .= "<td><a style='color: black;' href='user_detail.php?id=$row->id'>".$row->machine_id1."</a></td>";
    $html .= "</tr>";
}
$html .= "</tbody>
      </table>
      </div></div></div></div></div></div>";
buildLayout($html);
?>