<?php
require_once('../dist/db.php');
require_once('../dist/functions.php');

$Dia = date("d");
$Ano = date("Y"); 
$Mes = date("m");
$dt_atual = $Ano.$Mes.$Dia;

// NEW PASSWORD USER
if (isset($_POST['change_password'])) {
  // receive all input values from the form
  $token =  $_POST['token'];
  $password1 = $_POST['password1'];
  $password2 = $_POST['password2'];
  $password = $password2;
  
  list($a, $id, $b) =  explode("_", base64_url_decode($token));

  if(strtotime($a) < strtotime($dt_atual)) {
    echo "<script>
        alert('Link de troca de senha expirado!!.');
        window.location.href='../mailer/esqueci-a-senha.php';
        </script>";
  }

  if (empty($password1)) {
    echo "<script>
        alert('Nova senha não informada!');
        window.location.href='https://primomarcos.com/mailer/redefinir.php?token=$token';
        </script>";  
        return;
  }  

  if (empty($password2)) {
    echo "<script>
        alert('Confirmação da nova senha não informada!');
        window.location.href='https://primomarcos.com/mailer/redefinir.php?token=$token';
        </script>";  
        return;
  }
  if ($password1 != $password2) {
    echo "<script>
        alert('A senha e a confirmação de senha estão diferentes!');
        window.location.href='https://primomarcos.com/mailer/redefinir.php?token=$token';
        </script>";  
        return;
  }
    
        // first check the database to make sure 
        $db = open_db();
        $stmt = $db->prepare("SELECT * FROM users WHERE id = ? LIMIT 1");
        $result = $stmt->execute([$id]);
        $row = $stmt->fetchObject();

        if ($row != null) {
            $query = $db->prepare('UPDATE users SET 
            password = :password
            WHERE id = :id');

            $query->execute(array(
            ':password' => "$password",
            ':id' => "$id"
            ));
        }

    echo "<script>
        alert('Senha Alterada com sucesso.');
        window.location.href='../user/user_login.php';
        </script>";

} else {
    header('location: ../user/user_login.php');
}
?>