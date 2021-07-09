<?php
require_once('db.php');
session_start();
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
  $server = $_POST['server'];
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
  if ($server == "TBOT") {
    $DiaTRIAL = date('d', strtotime('+2 day'));
  } else if ($server == "MUDABRA") {
    $DiaTRIAL = date('d', strtotime('+2 day'));
  } else {
    $DiaTRIAL = date('d', strtotime('+1 day'));
  }

  $dt_expiry = $Ano."-".$Mes."-".$DiaTRIAL;
  

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

$desc = 'NEW USER - '.$dt_atual;

  // Finally, register user if there are no errors in the form
  if (count($errors) == 0) {
  	$password = $password1;//encrypt the password before saving in the database
  	$query = $db->prepare("INSERT INTO users (username, email, team, server, discord_tag, password, expiry_date, status, created_at, description, package) 
  			  VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $result = $query->execute([$username, $email, $team, $server, $disc, $password, $dt_expiry, 1, $dt_atual, $desc, 'TRIAL']);
  	header('location: register_finish.php');
  }
}

// UPDATE USER
if (isset($_POST['update_user'])) {
  // receive all input values from the form
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
    password = :password 
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
    ':id' => $id
    ));

  	header('location: ../admin/users_table.php');
  }
}

// LOGIN ADMIN
if (isset($_POST['login_admin'])) {
  // receive all input values from the form
  $username = $_POST['username'];
  $password = $_POST['password'];

  // first check the database to make sure 
  // a user does not already exist with the same username and/or email
  $user_check_query = $db->prepare("SELECT * FROM admins WHERE username = ? AND password = ? LIMIT 1");
  $result = $user_check_query->execute([$username, $password]);
  $user = $user_check_query->fetchObject();

  if ($user) { // if user exists
    $_SESSION['logged'] = 1;
  }
    header('location: users_table.php');
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