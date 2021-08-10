<?php 
function open_db()
{   
    $host = 'localhost';
    $db = 'marcos';
    $user = 'root';
    $pass = 'Primomarcos@132710';
    
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