<html>
    <head>
        <title>Lost Password</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../Imagens/PrimoMarcos/ICONE.png" />
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="https://primomarcos.com"><img src="../Imagens/PrimoMarcos/ICONE.png" width="50" height="50" alt="Primo Marcos" /></a>
            </div>
        </nav>
        
        <div class="wrapper">
        <form class="login" method="post" action="recuperar.php">
            <p class="title">Redefinição de Senha</p>
            <?php include('errors.php');?>
            <br>
                <label for="email">Insira o seu e-mail e redefina a sua senha.</label>
            <br><br><br><br><br><br>
                <input type="email" id="email" name="email" placeholder="Seu email">
            <button type="submit" name="esqueciasenha" value="Redefinir">
                <i class="spinner"></i>
                <span class="state">Enviar E-mail</span>
            </button>
        <div class="dropdown-divider"></div>
        </div>
        </form>
        <footer><a target="blank" href="#"></a></footer>
        </p>    
    </div>
</body>
</html>