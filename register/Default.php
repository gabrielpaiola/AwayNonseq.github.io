<?php
require_once('../layout.php');
include('../dist/server.php');
include('errors.php');

        
$html = "<title>P.M Teste</title>";

$html .= " 


        <div class='wrapper'>
        <form class='login' method='post' action='register.php'>
            <p class='title'>Register</p>
            <br>
            <input type='text' name='username' placeholder='Username *' autofocus/>
            <input type='email' name ='email' placeholder='Email *'/>
            <input type='text' name ='team' placeholder='Team' />
            <input type='text' name ='server' placeholder='Indicação / Cupom' value='<?php $server; ?>'/>
            <input type='text' name ='disc' placeholder='Discord Tag' value='<?php $disc; ?>'/>
            <input type='password' name='password1' placeholder='Password *' />
            <input type='password' name='password2' placeholder='Password Confirmation *' />

            <h3><br>Ao se registrar você estará concordando com nossos <a class='navbar-brand' href='../Sobre/Terms.html' target='_blank'>Termos de Uso</a> </h3>
            
            <button type='submit' name='reg_user'>
                <i class='spinner'></i>
                <span class='state'>Register</span>
            </button>
        </form>















        ";









        $html .= "
        </div></div></div></div></div>";
buildLayout($html);












?>