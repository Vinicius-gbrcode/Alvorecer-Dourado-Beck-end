<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require_once __DIR__ . '/phpmailer/src/Exception.php';
require_once __DIR__ . '/phpmailer/src/PHPMailer.php';
require_once __DIR__ . '/phpmailer/src/SMTP.php';

$config = require __DIR__ . '/email_config.php';

function enviarNotificacao($assunto, $mensagem)
{
    global $config;

    $mail = new PHPMailer(true);

    $mail->SMTPDebug = 2;
    $mail->Debugoutput = function ($str, $level) {
        error_log("SMTP DEBUG: $str");
    };

    try {
        $mail->isSMTP();
        $mail->Host = 'smtp.gmail.com';
        $mail->SMTPAuth = true;
        $mail->Username = $config['email'];
        $mail->Password = $config['senha'];
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port = 587;

        $mail->CharSet = 'UTF-8';
        $mail->setFrom($config['email'], 'Alvorecer Dourado Pinturas');
        $mail->addAddress($config['destinatario']);

        $mail->isHTML(true);
        $mail->Subject = $assunto;
        $mail->Body = $mensagem;

        $mail->AltBody = strip_tags(str_replace(
            ['<br>', '<br/>', '<br />'],
            "\n",
            $mensagem
        ));

        $mail->send();

        error_log('SMTP DEBUG: E-mail enviado com sucesso.');

        return true;

    } catch (Exception $e) {
        error_log('SMTP DEBUG: FALHA NO ENVIO: ' . $mail->ErrorInfo);
        return false;
    }
}