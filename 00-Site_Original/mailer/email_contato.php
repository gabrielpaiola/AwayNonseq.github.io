<?php 
require('../mailer/email_sender.php');
$email = addslashes($_POST[email]);
$mensagem = addslashes($_POST[message]);
$nome = addslashes($_POST[name]);

sendEmail('primomarcosmacro@gmail.com', 'E-mail - Contato via Site' , 'E-mail:'.$email.'---------Nome:'.$nome.'---------Mensagem:'.$mensagem);


header('location: https://primomarcos.com');
?>



