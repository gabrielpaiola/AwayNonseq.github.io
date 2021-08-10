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
        
        <?php
           $token = $_GET['token'];
            if(!(isset($token))){  

                header('location: ../user/user_login.php'); 
            
            }  else { 
        ?>

                <div class="wrapper">
                <form class="login" method="post" action="salvar_nova_senha.php">
                    <p class="title">Redefinir Senha</p>
                    <?php include('errors.php');?>
                    <br>
                    <input type="hidden" name="token" value="<?php echo $token; ?>"/>
                    <input type="password" name="password1" placeholder="new password" value="<?php $username; ?>" autofocus/>
                    <input type="password" name="password2" placeholder="confirm new password" />
                    <button type="submit" name="change_password">
                        <i class="spinner"></i>
                        <span class="state">Redefinir Senha</span>
                    </button>
                </form>
                <footer><a target="blank" href="#"></a></footer>
                </p>   
                </div>
                
           <?php 
           } ?>

        

    
</body>
</html>