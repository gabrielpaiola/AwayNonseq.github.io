<?php
session_start();
require_once('../dist/db.php');
require_once('layout.php');

if($_SESSION['user_status'] == 1) {
    header('location: ../Downloads/Primo_Launcher.exe');
}

if($_SESSION['user_status'] != 1) {
    echo "<script>
    alert('Usuario inativo, entre em contato com nossa Equipe para ativa-lo!!');
    window.location.href='users_page.php';
    </script>";
}

?>