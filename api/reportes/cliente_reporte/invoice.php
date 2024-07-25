<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

$exceptionPath = '../../../api/librerias/PHPMailer/src/Exception.php';
$phpMailerPath = '../../../api/librerias/PHPMailer/src/PHPMailer.php';
$smtpPath = '../../../api/librerias/PHPMailer/src/SMTP.php';

// Verifica que los archivos existen
if (!file_exists($exceptionPath) || !file_exists($phpMailerPath) || !file_exists($smtpPath)) {
    die('No se puede encontrar uno o más archivos de PHPMailer.');
}

// Incluye los archivos
require $exceptionPath;
require $phpMailerPath;
require $smtpPath;

// Verifica si se han pasado los parámetros necesarios
if (!isset($_GET['file']) || !isset($_GET['email'])) {
    die('No se ha proporcionado el archivo PDF o el correo electrónico.');
}

$pdfFilePath = urldecode($_GET['file']);
$clientEmail = urldecode($_GET['email']);

// Verifica si el archivo PDF existe
if (!file_exists($pdfFilePath)) {
    die('El archivo PDF no existe.');
}

// Configuración de PHPMailer
$mail = new PHPMailer(true);

try {
    // Configuración del servidor SMTP para Gmail
    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = '20220235@ricaldone.edu.sv'; // Tu correo electrónico de Gmail
    $mail->Password   = 'mpmh fpag gsbg zgut'; // Tu contraseña o contraseña de aplicación
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
    $mail->Port       = 587;
    //12345678_@

    // Remitente y destinatario
    $mail->setFrom('20220235@ricaldone.edu.sv', 'EcoAprende');
    $mail->addAddress($clientEmail); // Utilizar el correo electrónico del cliente

    // Asunto y cuerpo del correo
    $mail->isHTML(true);
    $mail->Subject = 'Comprobante de Compra';
    $mail->Body    = 'Adjunto encontrarás tu comprobante de compra.';
    $mail->AltBody = 'Gracias por comprar en nuestra tienda.';

    // Adjuntar el archivo PDF
    $mail->addAttachment($pdfFilePath, 'Comprobante.pdf');

    // Enviar el correo
    $mail->send();
    echo 'El correo ha sido enviado con éxito.';
} catch (Exception $e) {
    echo "No se pudo enviar el correo. Error: {$mail->ErrorInfo}";
}
?>
