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
                <h3>Usuario: $username ------- Email: $email</h3>
                <h3>Pacote: $package ------- Status: $status</h3>
                <h3>Usuario Criado: $created_at ------- Data de expiração: $date</h3>
                
                <h3><a href='../Sobre/WindowsDefender.html' target='_blank'>Recomendamos que sigam esses passos para garantir o funcionamento do primo!!</a></h3>
                <h3><a href='../Sobre/Terms.html' target='_blank'>Ressaltamos nossos termos de uso, ao se cadastrar e continuar usando nossos serviços, voce concorda com os mesmos!!<br></a></h3>

                <h3>Gostaria de contratar os serviços do Primo? basta escolher o plano abaixo:</h3>
                <a href='https://mpago.la/18Rs29y' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Mensal</button></a>
                <br>
                <a href='https://mpago.la/1CUKrqR' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Trimestral</button></a>

                <h3><br><br>Ja é um usuario com licença e gostaria de renovar? (<u>escolha a renovação de acordo com a sua licença optada anteriormente</u>):</h3>
                <a href='https://mpago.la/2XFxCSg' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Renovação Mensal</button></a>
                <br>
                <a href='https://mpago.la/1nvuxh8' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Renovação Trimestral</button></a>

                <h3><br></h3>
                <h3><b><u>Lembre-se de enviar o comprovante para validação (via facebook ou discord para pallox ou away)! (prazo para ativação de até 24 horas, normalmente ativamos em até 15 minutos).</b></u></h3>


                ";

$html .= "
      </div></div></div></div></div>";
buildLayout($html);
?>