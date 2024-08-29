<?php
// require __DIR__ . '/../../api/helpers/database.php';
require __DIR__ . '/../../api/auxiliar/database.php';

header('Content-Type: application/json');

// Verificar el método de solicitud
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $response = ['status' => false, 'message' => ''];

    $code = $_POST['code'] ?? null;
    $newPassword = $_POST['newPassword'] ?? null;
    $confirmPassword = $_POST['confirmPassword'] ?? null;

    // Depurar datos recibidos
    error_log("Datos recibidos: " . json_encode($_POST));

    if ($code && $newPassword && $confirmPassword) {
        if ($newPassword !== $confirmPassword) {
            $response['message'] = 'Las contraseñas no coinciden.';
            echo json_encode($response);
            exit;
        }

        // Verificar el código de recuperación
        $query = "SELECT id_cliente FROM tb_clientes WHERE codigo_recuperacion = ? AND fecha_expiracion_codigo >= NOW()";
        $clienteId = Database::getRow($query, [$code]);
        if (!$clienteId) {
            $response['message'] = 'Código de recuperación inválido o expirado.';
            echo json_encode($response);
            exit;
        }

        try {
            // Actualizar la contraseña
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

    $response['message'] = 'Datos insuficientes.';
    echo json_encode($response);
}
