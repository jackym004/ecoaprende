<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require __DIR__ . '/../../api/librerias/PHPMailer/src/Exception.php';
require __DIR__ . '/../../api/librerias/PHPMailer/src/PHPMailer.php';
require __DIR__ . '/../../api/librerias/PHPMailer/src/SMTP.php';
require __DIR__ . '/../../api/auxiliar/database.php';

header('Content-Type: application/json');

// Función para generar un código aleatorio
function generateRecoveryCode($length = 6) {
    $characters = '0123456789';
    $charactersLength = strlen($characters);
    $code = '';
    for ($i = 0; $i < $length; $i++) {
        $code .= $characters[rand(0, $charactersLength - 1)];
    }
    return $code;
}

// Verificar el método de solicitud
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $response = ['status' => false, 'message' => ''];

    // Obtener el correo electrónico del cliente y otros datos
    $clienteEmail = $_POST['clienteEmail'] ?? null;
    $code = $_POST['code'] ?? null;
    $newPassword = $_POST['newPassword'] ?? null;
    $confirmPassword = $_POST['confirmPassword'] ?? null;

    // Enviar el código de recuperación al correo electrónico
    if ($clienteEmail && !$code) {
        // Generar un código de recuperación
        $recoveryCode = generateRecoveryCode();
        $expirationDate = date('Y-m-d H:i:s', strtotime('+1 hour')); // El código vence en 1 hora

        // Actualizar el código de recuperación y la fecha de expiración en la base de datos
        $query = "UPDATE tb_clientes SET codigo_recuperacion = ?, fecha_expiracion_codigo = ? WHERE correo_cliente = ?";
        $values = [$recoveryCode, $expirationDate, $clienteEmail];
        if (!Database::executeRow($query, $values)) {
            $response['message'] = 'Error al actualizar el código de recuperación.';
            echo json_encode($response);
            exit;
        }

        // Enviar el código de recuperación por correo electrónico
        $mail = new PHPMailer(true);

        try {
            // Configuración del servidor SMTP
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com';
            $mail->SMTPAuth = true;
            $mail->Username = 'panaderiahernandez503sv@gmail.com'; // Tu correo electrónico de Gmail
            $mail->Password = 'dzlk xixm itan vokb'; // Tu contraseña o contraseña de aplicación
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
            $mail->Port = 587;

            // Remitente y destinatario
            $mail->setFrom('panaderiahernandez503sv@gmail.com', 'Panadería Hernández');
            $mail->addAddress($clienteEmail); // Correo electrónico del cliente

            // Asunto y cuerpo del correo
            $mail->isHTML(true);
            $mail->CharSet = 'UTF-8'; // Establecer la codificación a UTF-8
            $mail->Subject = 'Código de recuperación de contraseña';
            $mail->Body = "Tu código de recuperación es: <strong>$recoveryCode</strong>. Este código es temporal cambia la contraseña, lo antes posible.";
            $mail->AltBody = "Tu código de recuperación es: $recoveryCode. ste código es temporal cambia la contraseña, lo antes posible.";

            // Enviar el correo
            $mail->send();
            $response['status'] = true;
            $response['message'] = 'Código de recuperación enviado con éxito.';
        } catch (Exception $e) {
            $response['message'] = 'No se pudo enviar el correo. Error: ' . $mail->ErrorInfo;
        }

        echo json_encode($response);
        exit;
    }

    // Verificar si se envió el código y las contraseñas
    if ($code && $newPassword && $confirmPassword) {
        // Verificar si las contraseñas coinciden
        if ($newPassword !== $confirmPassword) {
            $response['message'] = 'Las contraseñas no coinciden.';
            echo json_encode($response);
            exit;
        }

        // Verificar si el código de recuperación es válido y no ha expirado
        $query = "SELECT id_cliente FROM tb_clientes WHERE codigo_recuperacion = ? AND fecha_expiracion_codigo >= NOW()";
        $clienteId = Database::getRow($query, [$code]);
        if (!$clienteId) {
            $response['message'] = 'Código de recuperación inválido o expirado.';
            echo json_encode($response);
            exit;
        }

        // Actualizar la contraseña en la base de datos
        try {
            $queryUpdatePassword = "UPDATE tb_clientes SET clave_cliente = ?, codigo_recuperacion = NULL, fecha_expiracion_codigo = NULL WHERE id_cliente = ?";
            $values = [password_hash($newPassword, PASSWORD_BCRYPT), $clienteId['id_cliente']];
            if (!Database::executeRow($queryUpdatePassword, $values)) {
                $response['message'] = 'Error al actualizar la contraseña.';
                echo json_encode($response);
                exit;
            }

            $response['status'] = true;
            $response['message'] = 'Contraseña actualizada con éxito.';
        } catch (Exception $e) {
            $response['message'] = 'Error de base de datos: ' . $e->getMessage();
        }

        echo json_encode($response);
        exit;
    }

    // Si no se proporciona ningún dato válido
    $response['message'] = 'Datos insuficientes.';
    echo json_encode($response);
}
