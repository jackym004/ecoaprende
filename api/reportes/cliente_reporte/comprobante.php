<?php
// Incluir archivos necesarios
require_once('../../auxiliar/comprobante.php');
require_once('../../modelos/handler/carrito_handler.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;
$pdf->startReport('Comprobante de compra');

// Se instancia el modelo Pedido para obtener los datos.
$pedido = new PedidoComprobante('localhost', 'db_ecoaprende', 'root', '');
$clienteEmail = null; // Variable para almacenar el correo electrónico del cliente

if ($dataPedidos = $pedido->readByClientAndStatus($_SESSION['idCliente'], 'Pendiente')) {
    foreach ($dataPedidos as $rowPedido) {
        if ($clienteEmail === null) {
            // Obtener el correo electrónico del cliente una sola vez
            $clienteEmail = $rowPedido['correo_cliente'];
        }
        
        // Información del cliente
        $pdf->setFont('Arial', 'B', 10);
        $pdf->cell(0, 20, $pdf->encodeString('ID de Pedido: ' . $rowPedido['id_pedido']), 0, 1);
        $pdf->ln(2);
        
        $pdf->setFont('Arial', '', 11);
        // Primera fila de datos
        $pdf->cell(30, 8, $pdf->encodeString('Nombre:'), 0, 0);
        $pdf->cell(60, 8, $pdf->encodeString($rowPedido['nombre_cliente']), 0, 0);
        $pdf->cell(30, 8, $pdf->encodeString('Teléfono:'), 0, 0);
        $pdf->cell(70, 8, $pdf->encodeString($rowPedido['telefono_cliente']), 0, 1);
        
        // Segunda fila de datos
        $pdf->cell(30, 8, $pdf->encodeString('DUI:'), 0, 0);
        $pdf->cell(70, 8, $pdf->encodeString($rowPedido['dui_cliente']), 0, 1);
        
        // Tercera fila de datos
        $pdf->cell(90, 8, $pdf->encodeString('Correo Electrónico:'), 0, 0);
        $pdf->cell(70, 8, $pdf->encodeString($clienteEmail), 0, 0);
        $pdf->ln(10);
        $pdf->cell(90, 8, $pdf->encodeString('Fecha de Registro:'), 0, 0);
        $pdf->cell(50, 8, $pdf->encodeString($rowPedido['fecha_pedido']), 0, 1);
        $pdf->ln(10);

        // Encabezados de productos
        $pdf->setFont('Arial', 'B', 11);
        $pdf->setFillColor(36, 92, 157);
        $pdf->setTextColor(0, 0, 0);
        $pdf->cell(126, 12, 'Producto', 0, 0, 'C', 1);
        $pdf->cell(30, 12, 'Cantidad', 0, 0, 'C', 1);
        $pdf->cell(30, 12, 'Precio (US$)', 0, 1, 'C', 1);
        
        $detallePedido = new DetallePedidoComprobante('localhost', 'db_ecoaprende', 'root', '');
        if ($detallePedido->setPedido($rowPedido['id_pedido'])) {
            if ($dataDetalles = $detallePedido->readByPedido()) {
                $pdf->setFont('Arial', '', 11);
                $pdf->setFillColor(240, 240, 240);
                $pdf->setTextColor(0, 0, 0);
                $fill = false;
                $total = 0;
                foreach ($dataDetalles as $rowDetalle) {
                    $pdf->cell(126, 12, $pdf->encodeString($rowDetalle['nombre_libro']), 0, 0, '', $fill);
                    $pdf->cell(30, 12, $rowDetalle['cantidad_comprada'], 0, 0, 'C', $fill);
                    $pdf->cell(30, 12, number_format($rowDetalle['precio_producto'], 2, '.', ''), 0, 1, 'R', $fill);
                    $total += $rowDetalle['cantidad_comprada'] * $rowDetalle['precio_producto'];
                    $fill = !$fill;
                }
                $pdf->setFont('Arial', 'B', 11);
                $pdf->cell(150, 15, 'Total', 0, 0, 'R');
                $pdf->cell(35, 15, number_format($total, 2, '.', ''), 0, 1, 'R');
            } else {
                $pdf->cell(0, 10, $pdf->encodeString('No hay productos para el pedido'), 1, 1);
            }
        } else {
            $pdf->cell(0, 10, $pdf->encodeString('Pedido incorrecto o inexistente'), 1, 1);
        }

        $pdf->ln(10);
    }
} else {
    $pdf->cell(0, 10, $pdf->encodeString('No hay pedidos en camino para mostrar'), 1, 1);
}

$filePath = '../../pdfs/Comprobante_' . time() . '.pdf';
$pdf->output('F', $filePath);

// Mostrar el archivo en el navegador
$pdf->output('I', 'Comprobante.pdf');

echo "Archivo guardado en: " . $filePath;

// Usar realpath para asegurarse de que la ruta del archivo es correcta
$fileUrl = urlencode(realpath($filePath));
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "http://localhost/ecoaprende/api/reportes/cliente_reporte/invoice.php?file=" . $fileUrl . "&email=" . urlencode($clienteEmail));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

echo $response;
?>