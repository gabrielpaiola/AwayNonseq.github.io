<?php include('../dist/server.php')?>
<html>
    <head>
        <title>Login User</title>
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
        <form class="login" method="post" action="user_login.php">
            <p class="title">Login User</p>
            <?php include('errors.php');?>
            <br>
            <input type="text" name="username" placeholder="Username" value="<?php $username; ?>" autofocus/>
            <input type="password" name="password" placeholder="Password" />
            <button type="submit" name="login_user">
                <i class="spinner"></i>
                <span class="state">Login</span>
            </button>
       
        <div class="dropdown-divider"></div>
          
            <h3><a class="dropdown-item" href="https://primomarcos.com/mailer/esqueci-a-senha.php">Esqueceu a senha?<br></a></h3>
            <h3><a class="dropdown-item" href="https://primomarcos.com/register/register.php">Novo, por aqui? Registre-se.</a></h3>
        </div>
        </form>
        <footer><a target="blank" href="#"></a></footer>
        </p>    
    </div>
</body>
</html>