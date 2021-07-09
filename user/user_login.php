<?php include('../dist/server.php')?>
<html>
    <head>
        <title>Login User</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand" href="https://primomarcos.com"><img src="../Imagens/Skull.png" width="50" height="50" alt="Primo Marcos" /></a>
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
        </form>
        <footer><a target="blank" href="#"></a></footer>
        </p>    
    </div>
</body>
</html>