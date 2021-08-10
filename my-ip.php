<?php
date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date("Y"); 
$Mes = date("m");
$hourMin = date('H:i:s');
$dt_atual = $Ano."-".$Mes."-".$Dia."--".$hourMin;


        $ip1 = $_SERVER['HTTP_CLIENT_IP'].' -1';
        $ip2 = $_SERVER['HTTP_X_FORWARDED_FOR'].' -2';
        $ip3 = $_SERVER['REMOTE_ADDR'].' -3';

        echo $ip1;
        echo "\n";
        echo $ip2;
        echo "\n";
        echo $ip3;
        echo "\n";


?>