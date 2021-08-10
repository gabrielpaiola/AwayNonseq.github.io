<?php 
require('../mailer/email_sender.php');
$email = addslashes($_POST[email]);
$mensagem = addslashes($_POST[message]);
$nome = addslashes($_POST[name]);

if (empty($nome)) {
    echo "<script>
        alert('Nome não informado!');
        window.location.href='https://primomarcos.com';
        </script>";  
        return;
}
if (empty($email)) {
    echo "<script>
        alert('Email não informado!');
        window.location.href='https://primomarcos.com';
        </script>";  
        return;
}
if (empty($mensagem)) {
    echo "<script>
        alert('Mensagem não informada!');
        window.location.href='https://primomarcos.com';
        </script>";  
        return;
}


sendEmail('primomarcosmacro@gmail.com', 'E-mail - Contato via Site' , 'E-mail: '.$email.'<br>Nome: '.$nome.'<br>Mensagem: '.$mensagem);


header('location: https://primomarcos.com');
?>



