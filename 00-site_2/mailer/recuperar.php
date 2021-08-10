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
        $url = 'primomarcos.com/mailer/redefinir.php';




        $db = open_db();
        $stmt = $db->prepare('SELECT * FROM users WHERE email = ? LIMIT 1');
        $result = $stmt->execute([$email]);
        $row = $stmt->fetchObject();

        $token = base64_url_encode($dt_atual."_".$row->id."_".$email);

        if($row == null) {
            echo "<script>
            alert('E-mail não encontrado.');
            window.location.href='../mailer/esqueci-a-senha.php';
            </script>";
            return;
        }

        sendEmail($email, 'Redefinir sua Senha', 'Olá '.$row->username.', <br>
        Foi solicitada uma redefinição da sua senha no Primo Marcos. Acesse o link abaixo para redefinir sua senha.<br>
        <h3><a href="'.$url.'?token='.$token.'">Redefinir a sua senha</a></h3> 
        <br>            
        Caso você não tenha solicitado essa redefinição, ignore esta mensagem.<br><br>
        Qualquer problema ou dúvida entre em contato pelo Discord ou pelo Facebook.<br>
        Att. Equipe Primo Marcos<br>
        <h3><a href="primomarcos.com">primomarcos.com</a></h3>
        <img src="https://primomarcos.com/Imagens/PrimoMarcos/logoemail.png" alt="..." width="100" height="100" />)');


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