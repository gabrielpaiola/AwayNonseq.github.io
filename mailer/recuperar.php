<?php
    require_once('../dist/db.php');
    require('email_sender.php');
    require_once('../dist/functions.php');

    $Dia = date("d");
    $Ano = date("Y"); 
    $Mes = date("m");
    $dt_atual = $Ano.$Mes.$Dia;

   
    if(isset($_POST['esqueciasenha'])){
        $email = $_POST['email'];
        $url = 'https://primomarcos.com/mailer/redefinir.php';


        $db = open_db();
        $stmt = $db->prepare('SELECT * FROM users WHERE email = ? LIMIT 1');
        $result = $stmt->execute([$email]);
        $row = $stmt->fetchObject();
        $token = uniqid();

        if($row == null) {
            echo "<script>
            alert('E-mail não encontrado.');
            window.location.href='../mailer/esqueci-a-senha.php';
            </script>";
            return;
        }

        $query = $db->prepare('UPDATE users SET 
        forgetpassword = :forgetpassword
        WHERE id = :id');

        $query->execute(array(
        ':forgetpassword' => "$token",
        ':id' => "$row->id"
        ));

        sendEmail($email, 'Redefinir sua Senha', 'Olá '.$row->username.', <br>
        Foi solicitada uma redefinição da sua senha no Primo Marcos. Acesse o link abaixo para redefinir sua senha.<br>
        <h3><a href="'.$url.'?id='.$row->id.'&token='.$token.'">Redefinir a sua senha</a></h3> 
        <br>            
        Caso você não tenha solicitado essa redefinição, ignore esta mensagem.<br><br>
        Qualquer problema ou dúvida entre em contato pelo Discord ou pelo Facebook.<br>
        Att. Equipe Primo Marcos<br>
        <h3><a href="https://primomarcos.com">primomarcos.com</a></h3>
        
        
        <img src="https://primomarcos.com/Imagens/PrimoMarcos/logoemail.png" alt="..." width="100" height="100" />');


        echo "<script>
        alert('E-mail enviado com sucesso, cheque seu inbox/lixo eletrônico e siga os passos indicados.');
        window.location.href='../mailer/esqueci-a-senha.php';
        </script>";

  } else {
    echo "<script>
        alert('Acesse pelo caminho certo.');
        window.location.href='../mailer/esqueci-a-senha.php';
        </script>";
  }

?>