<?php
date_default_timezone_set('America/Sao_Paulo');
$Dia = date("d");
$Ano = date("Y"); 
$Mes = date("m");
$dt_atual = $Ano.$Mes.$Dia;
$hourMin = date('H:i');
echo "PrimoMarcosDate\n";
echo $dt_atual;
echo "\n";
echo $hourMin;
?>