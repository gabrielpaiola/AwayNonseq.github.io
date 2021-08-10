<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '../PHPMailer/src/Exception.php';
require '../PHPMailer/src/PHPMailer.php';
require '../PHPMailer/src/SMTP.php';



function sendEmail($email_address, $subject, $body) 
{   
    try {
        $mail = new PHPMailer(true);
        
        $mail->IsSMTP();
        $mail->CharSet="UTF-8";
        $mail->Host = "smtp.gmail.com";
        $mail->SMTPAuth   = true; 
        $mail->Username   = "primomarcosmacro@gmail.com";  
        $mail->Password   = "primo1327";  
        $mail->SMTPSecure = 'ssl';
        $mail->Port = 465;
        //$mail->SMTPDebug = 4;

        $mail->setFrom("primomarcosmacro@gmail.com", "Primo Marcos - Não Responder");
        $mail->addAddress($email_address);
        $mail->AddBCC("gcpaiola@hotmail.com");
        $mail->Subject = $subject;
        $mail->Body    = $body;

        $mail->IsHTML(true);

        $mail->send();

    } catch (Exception $e) {
        echo "Email não enviado: {$mail->ErrorInfo}"; 
    }
}

?>