<?php 
function open_db()
{   
    $host = '34.132.227.206';
    $db = 'marcos';
    $user = 'root';
    $pass = 'marcos1379';
    
    try
    {
        $db = new PDO("mysql:host=$host;dbname=$db", $user, $pass);
        return ($db);
    } catch (PDOException $e){
        echo 'Erro ao conectar com MySQL:'.$e->getMessage();
        return '0';
    }
}
?>