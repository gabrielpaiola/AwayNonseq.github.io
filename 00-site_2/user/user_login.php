<?php
require_once('../layout.php');
include('../dist/server.php');


        
$html = "<title>P.M User Login</title>";

$html .= " 

<div id='layoutSidenav_content'>
    <div class='container'>
        <div class='row justify-content-center'>
            <div class='col-lg-5'>
                <div class='card shadow-lg border-0 rounded-lg mt-5'>
                    <div class='card-header'><h3 class='text-center font-weight-light my-4'>User Login</h3></div>
                    <?php include('errors.php');?>
                    <div class='card-body'>
                        <form class='login' method='post' action='user_login.php'>
                            <div class='form-floating mb-3'>
                                <input class='form-control' type='text' name='username' placeholder='Username' autofocus/>
                                <label for='inputEmail'>Usuário</label>
                            </div>
                            <div class='form-floating mb-3'>
                                <input class='form-control' type='password' name='password' placeholder='Password' autofocus/>
                                <label for='inputPassword'>Password</label>
                            </div>
                            <div class='d-flex align-items-center justify-content-between mt-4 mb-0'>
                                <a class='small' href='../mailer/esqueci-a-senha.php'>Forgot Password?</a>

                                <button class='texte-center'; style='background: #203470; border-radius: 6px; padding: 15px; cursor: pointer; color: #fff; border: none; font-size: 16px;' type='submit' name='login_user'>
                                    <i class='spinner'></i>
                                    <span class='state'>Login</span>
                                </button>

                            </div>
                        </form>
                    </div>
                    <div class='card-footer text-center py-3'>
                        <div class='small'><a href='../register/register.php'>Need an account? Sign up!</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>










        ";









        $html .= "
        </div></div></div></div></div>";
buildLayout($html);












?>