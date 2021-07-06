<?php include('../dist/server.php')?>
<html>
    <head>
        <title>Login Admin</title>
        <link rel="stylesheet" href="../css/style.css">
    </head>
    <body>
        <div class="wrapper">
        <form class="login" method="post" action="admin_login.php">
            <p class="title">Login Admin</p>
            <?php include('errors.php');?>
            <br>
            <input type="text" name="username" placeholder="Username" value="<?php $username; ?>" autofocus/>
            <input type="password" name="password" placeholder="Password" />
            <button type="submit" name="login_admin">
                <i class="spinner"></i>
                <span class="state">Login</span>
            </button>
        </form>
        <footer><a target="blank" href="#"></a></footer>
        </p>    
    </div>
</body>
</html>