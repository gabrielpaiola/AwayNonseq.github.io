<?php include('../dist/server.php')?>
<html>
    <head>
        <title>Registro</title>
        <link rel="stylesheet" href="../css/style.css">
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../Imagens/PrimoMarcos/ICONE.png" />

         <!-- Global site tag (gtag.js) - Google Analytics -->
          <script async src="https://www.googletagmanager.com/gtag/js?id=UA-201084992-1">
          </script>
          <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', 'UA-201084992-1');
          </script>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="https://primomarcos.com"><img src="../Imagens/PrimoMarcos/ICONE.png" width="50" height="50" alt="Primo Marcos" /></a>
            </div>
        </nav>

        <div class="wrapper">
        <form class="login" method="post" action="register.php">
            <p class="title">Register</p>
            <?php include('errors.php');?>
            <br>
            <input type="text" minlength="4" maxlength="30" name="username" placeholder="Username *" autofocus/>
            <input type="email" name ="email" placeholder="Email * (necessário confirmação no email)"/>
            <input type="text" name ="server" placeholder="Indicação / Cupom"/>
            <input type="text" name ="disc" placeholder="Discord Tag (Exemplo: 	Away#8001)"/>
            <input type="password" minlength="5" maxlength="15" name="password1" placeholder="Password *" />
            <input type="password" minlength="5" maxlength="15" name="password2" placeholder="Password Confirmation *" />

            <h3><br>Ao se registrar você estará concordando com nossos <a class="navbar-brand" href="../Sobre/Terms.php" target="_blank">Termos de Uso</a> </h3>
            
            <button type="submit" name="reg_user">
                <i class="spinner"></i>
                <span class="state">Register</span>
            </button>
        </form>
        <footer><a target="blank" href="#"></a></footer>
        </p>    
    </div>
</body>
</html>

