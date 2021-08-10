<?php
require_once('../dist/db.php');
$username = $_GET['user'];


date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date("Y"); 
$Mes = date("m");
$dt_atual = $Ano.'-'.$Mes.'-'.$Dia;



$desc = 'USUARIO CONFIRMADO - '.$dt_atual;



$db = open_db();
$stmt = $db->prepare('SELECT * FROM users WHERE username = ?');
$result = $stmt->execute([$username]);
$row = $stmt->fetchObject();

    if (strtotime($dt_atual) > strtotime($row->expiry_date)){
        $status = 0;
    } else {
        $status = 1;
    }


        //GRAVACAO NO BANCO
        if ($row != null) {
            if ($row->description != 'CONFIRMAR E-MAIL') {
               // echo "<script>
               // alert('Email ja confirmado!!!!!');
               // window.location.href='../user/user_login.php';
               // </script>";
               header('location: ../user/user_login.php');
            } else {
                $query = $db->prepare('UPDATE users SET 
                description = :description,
                status = :status
                WHERE username = :username');
            
                $query->execute(array(
                ':description' => "$desc",
                ':status' => "$status",
                ':username' => "$username"
                ));

                //echo "<script>
                //alert('Email confirmado com sucesso!!!!!');
                //window.location.href='../user/user_login.php';
                //</script>";
                header('location: ../user/user_login.php');
            }
        } else {
            echo "<script>
            alert('Usuário não encontrado!!!!!');
            window.location.href='../register/register.php';
            </script>";
        }   
        


?>