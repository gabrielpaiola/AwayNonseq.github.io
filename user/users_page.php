<?php
session_start();
require_once('../dist/db.php');
require_once('../dist/server.php');
require_once('layout.php');
require('../mailer/email_sender.php');



    



date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date('Y'); 
$Mes = date("m");
$dt_atual = $Ano."-".$Mes."-".$Dia;

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
 $diferenca = strtotime($row->expiry_date) - strtotime($dt_atual);
 $DiasDeUso = floor($diferenca / (60 * 60 * 24)); 

    if ($DiasDeUso < 0){
        $DiasDeUso = 0;
    }

 $db = null;

$html = '';

$html .= "<div class='content'>
            <div class='container-fluid'>
            <div class='row'>
                <div class='col-md-12'>
                <div class='card' style='padding: 20px'>
                <h3>Usuario: $username ------- Email: $email</h3>
                <h3>Pacote: $package ------- Status: $status ------- Dias Restantes: $DiasDeUso</h3>
                <h3>Usuario Criado: $created_at</h3>
                
                <h3><a href='../Sobre/WindowsDefender.php' target='_blank'>Recomendamos que sigam esses passos para garantir o funcionamento do primo!!</a></h3>
                <h3><a href='../Sobre/Terms.php' target='_blank'>Ressaltamos nossos termos de uso, ao se cadastrar e continuar usando nossos serviços, voce concorda com os mesmos!!<br></a></h3>
                ";

if ($username == 'ggaa09'){
    $html .= " 
    <h3><br></h3>
    <a href='https://primomarcos.com/admin/admin_login.php' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Login</button></a>
    <h3><br></h3>

    
    <form enctype='multipart/form-data' action='__URL__' method='POST'>
<!-- MAX_FILE_SIZE deve preceder o campo input -->
        <input type='hidden' name='MAX_FILE_SIZE' value='30000' />
<!-- O Nome do elemento input determina o nome da array $_FILES -->
            Enviar esse arquivo: <input name='userfile' type='file' />
        <input type='submit' value='Enviar arquivo' />
    </form>

    ";
}

if ($row->description == 'CONFIRMAR E-MAIL') {
    
    
    
    $html .= "    
    <input type='hidden' name='username' value='<?php echo $username; ?>'/>
    <input type='hidden' name='email' value='<?php echo $email; ?>'/>

    <h3>Conta ainda não ativada, necessário confirmar a criação em seu e-mail.<br>Caso não tenha recebi o e-mail, clique no botão abaixo para reenviar.</h3>
    <br><br>

    <a href='reenviar_email.php?user=$username&email=$email'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Reenviar Email de Confirmação</button></a>
    
    

    ";

}
                
if (($package == 'TRIAL') || ($package == 'Trial')){
    $html .= "    
    <h3>Gostaria de contratar os serviços do Primo? basta escolher o plano abaixo:</h3>
    <a href='https://mpago.la/18Rs29y' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Plano Mensal</button></a>
    <br>
    <a href='https://mpago.la/1CUKrqR' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Plano Trimestral</button></a>
    <br>
    <h3><b><u>Lembre-se de enviar o comprovante para validação (via facebook ou discord para pallox ou away)! (prazo para ativação de até 24 horas, normalmente ativamos em até 15 minutos).</b></u></h3>
    ";
}

if ($package == 'Trimestral'){
    $html .= "    
    <h3><br><br>Ja é um usuario com licença e gostaria de renovar?:</h3>
    <br>
    <a href='https://mpago.la/1nvuxh8' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Renovação Trimestral</button></a>
    <h3><br></h3>
    <h3><b><u>Lembre-se de enviar o comprovante para validação (via facebook ou discord para pallox ou away)! (prazo para ativação de até 24 horas, normalmente ativamos em até 15 minutos).</b></u></h3>
    ";
}

if ($package == 'Mensal'){
    $html .= "    
    <h3><br><br>Ja é um usuario com licença e gostaria de renovar?:</h3>
    <br>
    <a href='https://mpago.la/2XFxCSg' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Renovação Mensal</button></a>
    <br>
    <a href='https://mpago.la/2moVAd5' target='_blank'><button style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;'>Upgrade para Trimestral</button></a>
    <h3><br></h3>
    <h3><br></h3>
    <h3><b><u>Lembre-se de enviar o comprovante para validação (via facebook ou discord para pallox ou away)! (prazo para ativação de até 24 horas, normalmente ativamos em até 15 minutos).</b></u></h3>
    ";
}




$html .= "
      </div></div></div></div></div>";
buildLayout($html);
?>