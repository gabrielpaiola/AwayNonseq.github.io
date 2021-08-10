<?php
    // receive all input values from the form
    $username = $_GET['user'];
    $email = $_GET['email'];
  
    require('../mailer/email_sender.php');
  
      sendEmail($email, 'Bem vindo - '.$username.'- Email de Confirmação', 'Bem vindo ao Primo Marcos<br>
          Para acessar seus dados, conferir nossos pacotes e fazer download do Primo faça login em nosso site ou <a href="https://primomarcos.com/user/user_login.php">Clique Aqui</a><br>
          Ao criar sua conta voce concordou com nossos termos, caso deseje ler novamente basta clicar no link a seguir <a href="https://primomarcos.com/Sobre/Terms.php">Termos e Uteis</a>  , neste link tambem estao algumas configuracoes necessarias para um bom funcionamento do primo.<br><br><br>
  
          <a href="https://primomarcos.com/mailer/confirmar_user.php?user='.$username.'" target="_blank"><button style="background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;">Confirmar seu Email</button></a><br><br><br>
  
  
          A Equipe Primo Marcos Agradece pelo seu Cadastro.<br>
          Bom Jogo!!!<br>
          <img src="https://primomarcos.com/Imagens/PrimoMarcos/logoemail.png" alt="..." width="100" height="100" />');
  
  
          echo "<script>
          alert('Foi enviado um email para confirmação do cadastro (cheque no seu lixo eletrônico caso não esteja encontrando).');
          window.location.href='users_page.php';
          </script>";
?>


