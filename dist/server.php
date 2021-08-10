<?php
require_once('db.php');
session_start();
date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date('Y'); 
$Mes = date("m");
$dt_atual = $Ano."-".$Mes."-".$Dia;


//variables
$username = "";
$email    = "";
$team     = "";
$server   = "";
$disc     = "";
$errors = array(); 

// connect to the database
$db = open_db();

// REGISTER USER
if (isset($_POST['reg_user'])) {
  // receive all input values from the form
  $username = $_POST['username'];
  $email = $_POST['email'];
  $team = $_POST['team'];
  $server = strtoupper($_POST['server']);
  $disc = $_POST['disc'];
  $password1 = $_POST['password1'];
  $password2 = $_POST['password2'];

    // form validation: ensure that the form is correctly filled ...
  // by adding (array_push()) corresponding error unto $errors array
  if (empty($username)) { array_push($errors, "Username não informado"); }
  if (empty($email)) { array_push($errors, "Email não informado"); }
  if (empty($password1)) { array_push($errors, "Senha não informada"); }
  if ($password1 != $password2) {
	array_push($errors, "Senha diferente da confirmação");
  }

  // Conferindo Cupom
  $db = open_db();
  $stmt = $db->prepare('SELECT * FROM cupons WHERE cupom = ? LIMIT 1');
  $result = $stmt->execute([($server)]);
  $row = $stmt->fetchObject();
  $diascupom = $row->dias - 1;
   if($row == null) {
       $dt_expiry = date('Y-m-d', strtotime($dt_atual. " +1 day"));
   } else {
      if(strtotime($row->validade) > strtotime($dt_atual)) {
        $dt_expiry = date('Y-m-d', strtotime($dt_atual. " +{$diascupom} days"));
      } else {
        $dt_expiry = date('Y-m-d', strtotime($dt_atual. " +1 day"));
      }
   }


  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = $db->prepare("SELECT * FROM users WHERE username = ? OR email = ? LIMIT 1");
  $result = $user_check_query->execute([$username, $email]);
  $user = $user_check_query->fetchObject();
  
  if ($user) { // if user exists
    if ($user->username === $username) {
      array_push($errors, "Usuário já cadastrado");
    }

    if ($user->email === $email) {
      array_push($errors, "Email já cadastrado");
    }
  }

$desc = 'CONFIRMAR E-MAIL';

  // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {

    require('../mailer/email_sender.php');

    sendEmail($email, 'Bem vindo - '.$username, 'Bem vindo ao Primo Marcos sua senha é >> '.$password1.' << <br>
    Para acessar seus dados, conferir nossos pacotes e fazer download do Primo faça login em nosso site ou <a href="https://primomarcos.com/user/user_login.php">Clique Aqui</a><br>
    Ao criar sua conta voce concordou com nossos termos, caso deseje ler novamente basta clicar no link a seguir <a href="https://primomarcos.com/Sobre/Terms.php">Termos e Uteis</a>  , neste link tambem estao algumas configuracoes necessarias para um bom funcionamento do primo.<br><br><br>

    <a href="https://primomarcos.com/mailer/confirmar_user.php?user='.$username.'" target="_blank"><button style="background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;">Confirmar seu Email</button></a><br><br><br>


    A Equipe Primo Marcos Agradece pelo seu Cadastro.<br>
    Bom Jogo!!!<br>
    <img src="https://primomarcos.com/Imagens/PrimoMarcos/logoemail.png" alt="..." width="100" height="100" />');


  	$password = $password1;//encrypt the password before saving in the database
  	$query = $db->prepare("INSERT INTO users (username, email, server, discord_tag, password, expiry_date, status, created_at, description, package) 
  			  VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $result = $query->execute([$username, $email, $server, $disc, $password, $dt_expiry, 0, $dt_atual, $desc, 'NEW USER']);
    echo "<script>
    alert('Foi enviado um email para confirmação do cadastro (cheque no seu lixo eletrônico caso não esteja encontrando).');
    window.location.href='../register/register_finish.php';
    </script>";
  }
}

// UPDATE USER
if (isset($_POST['update_user'])) {
  // receive all input values from the form
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  $id = $_POST['id'];
  $username = $_POST['username'];
  $email = $_POST['email'];
  $team = $_POST['team'];
  $server = $_POST['server'];
  $disc = $_POST['disc'];
  $expiry_date = $_POST['expiry_date'];
  $package = $_POST['package'];
  $status = $_POST['status'];
  $desc  = $_POST['desc'];
  $machineid1 = $_POST['machineid1'];
  $machineid2 = $_POST['machineid2'];
  $machineid3 = $_POST['machineid3'];
  $password = $_POST['password'];

  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = $db->prepare("SELECT * FROM users WHERE (username = ? OR email = ?) AND id <> ? LIMIT 1");
  $result = $user_check_query->execute([$username, $email, $id]);
  $user = $user_check_query->fetchObject();
  
  if ($user) { // if user exists
    return;
  }

  // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    username = :username, 
    email = :email, 
    team = :team, 
    server = :server, 
    discord_tag = :disc, 
    expiry_date = :expiry_date,
    status = :status, 
    package = :package,
    description = :description, 
    machine_id1 = :machineid1, 
    machine_id2 = :machineid2, 
    machine_id3 = :machineid3, 
    password = :password,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':username' => $username,
    ':email' => $email,
    ':team' => $team,
    ':server' => $server,
    ':disc' => $disc,
    ':expiry_date' => $expiry_date,
    ':status' => $status,
    ':package' => $package,
    ':description' => $desc,
    ':machineid1' => $machineid1,
    ':machineid2' => $machineid2,
    ':machineid3' => $machineid3,
    ':password' => $password,
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/users_table.php');
  }
}

// Change to Trial
if (isset($_POST['set_trial'])) {
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  // receive all input values from the form

  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    package = :package,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':package' => "Trial",
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
    
  }
}

// Change to Mensal
if (isset($_POST['set_mensal'])) {
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  // receive all input values from the form

  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    package = :package,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':package' => "Mensal",
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
    
  }
}

// Change to Trimestral
if (isset($_POST['set_trimestral'])) {
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  // receive all input values from the form

  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    package = :package,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':package' => "Trimestral",
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
    
  }
}

// ADD 2 DAYS
if (isset($_POST['add_2_days'])) {
  // receive all input values from the form
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  $expiry_date = $_POST['expiry_date'];
  if(strtotime($expiry_date) < strtotime($dt_atual)) {
    $expiry_date = $dt_atual;
  }
  $expiry_date = date('Y-m-d', strtotime($expiry_date. " +2 days"));

   // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    expiry_date = :expiry_date,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':expiry_date' => $expiry_date,
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
    
  }
}

// ADD 10 DAYS
if (isset($_POST['add_10_days'])) {
  // receive all input values from the form
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  $expiry_date = $_POST['expiry_date'];
  if(strtotime($expiry_date) < strtotime($dt_atual)) {
    $expiry_date = $dt_atual;
  }
  $expiry_date = date('Y-m-d', strtotime($expiry_date. " +10 days"));

   // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    expiry_date = :expiry_date,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':expiry_date' => $expiry_date,
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
    
  }
}

// ADD 30 DAYS
if (isset($_POST['add_30_days'])) {
  // receive all input values from the form
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  $expiry_date = $_POST['expiry_date'];
  if(strtotime($expiry_date) < strtotime($dt_atual)) {
    $expiry_date = $dt_atual;
  }
  $expiry_date = date('Y-m-d', strtotime($expiry_date. " +30 days"));

   // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    expiry_date = :expiry_date,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':expiry_date' => $expiry_date,
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
    
  }
}

// ADD 90 DAYS
if (isset($_POST['add_90_days'])) {
  // receive all input values from the form
  $id = $_POST['id'];
  $id_adm = $_SESSION['adm_id'];
  if ($id_adm == 1) {
    $idadm = $dt_atual."  - MAD";
  }
  if ($id_adm == 2) {
    $idadm = $dt_atual."  - AWAY";
  }
  if ($id_adm == 3) {
    $idadm = $dt_atual."  - PALLOX";
  }
  $expiry_date = $_POST['expiry_date'];
  if(strtotime($expiry_date) < strtotime($dt_atual)) {
    $expiry_date = $dt_atual;
  }
  $expiry_date = date('Y-m-d', strtotime($expiry_date. " +90 days"));

   // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE users SET 
    expiry_date = :expiry_date,
    modificated_by = :modificated_by
    WHERE id = :id');

    $query->execute(array(
    ':expiry_date' => $expiry_date,
    ':modificated_by' => $idadm,
    ':id' => $id
    ));

  	header('location: ../admin/user_detail.php?id='.$id);
  }
}

// UPDATE INFOS
if (isset($_POST['update_infos'])) {
  // receive all input values from the form

  $id = $_POST['id'];
  $versao_oficial = $_POST['versao_oficial'];
  $versao_beta = $_POST['versao_beta'];
  $versao_launcher = $_POST['versao_launcher'];
  $link_download = $_POST['link_download'];
  $security = $_POST['security'];

 
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE infos SET 
    versao_oficial = :versao_oficial, 
    versao_beta = :versao_beta, 
    versao_launcher = :versao_launcher, 
    link_download = :link_download, 
    security = :security
    WHERE id = :id');

    $query->execute(array(
    ':versao_oficial' => $versao_oficial,
    ':versao_beta' => $versao_beta,
    ':versao_launcher' => $versao_launcher,
    ':link_download' => $link_download,
    ':security' => $security,
    ':id' => $id
    ));

  	header('location: ../admin/infos_table.php');
  }
}

// UPDATE CUPOM
if (isset($_POST['update_cuponm'])) {
  // receive all input values from the form

  $id = $_POST['id'];
  $cupom = $_POST['cupom'];
  $dias = $_POST['dias'];
  $validade = $_POST['validade'];
 
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE cupons SET 
    cupom = :cupom, 
    dias = :dias, 
    validade = :validade
    WHERE id = :id');

    $query->execute(array(
    ':cupom' => $cupom,
    ':dias' => $dias,
    ':validade' => $validade,
    ':id' => $id
    ));

  	header('location: ../admin/cupons_table.php');
  }
}



// UPDATE MSG Launcher
if (isset($_POST['update_msg_launcher'])) {
  // receive all input values from the form

  $id = $_POST['id'];
  $linha1 = $_POST['linha1'];
  $linha2 = $_POST['linha2'];
  $linha3 = $_POST['linha3'];
  $linha4 = $_POST['linha4'];
  $linha5 = $_POST['linha5'];
  $linha6 = $_POST['linha6'];
  $linha7 = $_POST['linha7'];
  $linha8 = $_POST['linha8'];
  $linha9 = $_POST['linha9'];
  $linha10 = $_POST['linha10'];
  $linha11 = $_POST['linha11'];
  $linha12 = $_POST['linha12'];
  $linha13 = $_POST['linha13'];
  $linha14 = $_POST['linha14'];
  $linha15 = $_POST['linha15'];

 
  if (count($errors) == 0) {

    $query = $db->prepare('UPDATE msglauncher SET 
    linha1 = :linha1, 
    linha2 = :linha2, 
    linha3 = :linha3, 
    linha4 = :linha4, 
    linha5 = :linha5, 
    linha6 = :linha6, 
    linha7 = :linha7, 
    linha8 = :linha8, 
    linha9 = :linha9, 
    linha10 = :linha10, 
    linha11 = :linha11, 
    linha12 = :linha12, 
    linha13 = :linha13, 
    linha14 = :linha14, 
    linha15 = :linha15
    WHERE id = :id');

    $query->execute(array(
    ':linha1' => $linha1,
    ':linha2' => $linha2,
    ':linha3' => $linha3,
    ':linha4' => $linha4,
    ':linha5' => $linha5,
    ':linha6' => $linha6,
    ':linha7' => $linha7,
    ':linha8' => $linha8,
    ':linha9' => $linha9,
    ':linha10' => $linha10,
    ':linha11' => $linha11,
    ':linha12' => $linha12,
    ':linha13' => $linha13,
    ':linha14' => $linha14,
    ':linha15' => $linha15,
    ':id' => $id
    ));

  	header('location: ../admin/msg_launcher_table.php');
  }
}

// LOGIN ADMIN
if (isset($_POST['login_admin'])) {
  // receive all input values from the form
  $username = $_POST['username'];
  $password = $_POST['password'];

  if (empty($username)) { array_push($errors, "Username não informado"); }  
  if (empty($password)) { array_push($errors, "Senha não informada"); }

  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = $db->prepare("SELECT * FROM admins WHERE username = ? AND password = ? LIMIT 1");
  $result = $user_check_query->execute([$username, $password]);
  $user = $user_check_query->fetchObject();

  if ($user) { // if user exists
      $_SESSION['logged'] = 1;
      $_SESSION['adm_id'] = $user->id;
      if ($username == 'away' || $username == 'mad'){
        $_SESSION['adm_logged'] = 1;
      }
      header('location: users_table.php');
    } else {
    if (!empty($username) && !empty($password)) array_push($errors, "Username e/ou senha incorreto(s)");
   }
  }

// LOGIN USER
if (isset($_POST['login_user'])) {
  // receive all input values from the form
  $username = $_POST['username'];
  $password = $_POST['password'];

  if (empty($username)) { array_push($errors, "Username não informado"); }  
  if (empty($password)) { array_push($errors, "Senha não informada"); }
  
  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = $db->prepare("SELECT * FROM users WHERE username = ? AND password = ? LIMIT 1");
  $result = $user_check_query->execute([$username, $password]);
  $user = $user_check_query->fetchObject();

  if ($user) { // if user exists
    $_SESSION['logged_user'] = 1;
    $_SESSION['user_id'] = $user->id;
    $_SESSION['user_status'] = $user->status;
    header('location: users_page.php');
   } else {
    if (!empty($username) && !empty($password)) array_push($errors, "Username e/ou senha incorreto(s)");
   }
}
?>