<?php
// Se incluye la clase con las plantillas para generar reportes.
require_once('../../auxiliar/report.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;

// Se incluyen las clases para la transferencia y acceso a datos.
require_once('../../modelos/data/pedidos_data.php');

// Se instancia la entidad correspondiente.
$pedidos = new PedidosData;

// Se inicia el reporte con el encabezado del documento.
$pdf->startReport('Estado de pedidos');

// Se verifica si existen registros para mostrar, de lo contrario se imprime un mensaje.
if ($datapedidoss = $pedidos->readAll()) {
    // Se establece un color de relleno para los encabezados.
    $pdf->setFillColor(255,192,203);
    // Se establece la fuente para los encabezados.
    $pdf->setFont('Arial', 'B', 11);
    // Se imprimen las celdas con los encabezados.
    // Explicación de funcionamiento de los valores de las celdas: 
    // (Ancho, Alto, Texto, Borde, Salto de linea, Alineación (Centrado = C, Izquierda = L, Derecha = R), Fondo, Link)
    $pdf->cell(76, 10, 'Cliente', 1, 0, 'C', 1);
    $pdf->cell(50, 10, 'Fecha del pedido', 1, 0, 'C', 1);
    $pdf->cell(60, 10, $pdf->encodeString('Dirección'), 1, 1, 'C', 1);
    // Se establece la fuente para los datos de los pedidoss.
    $pdf->setFont('Arial', '', 11);
    // Se recorren los registros fila por fila.
    foreach ($datapedidoss as $rowpedidos) {
        // Se imprime una celda con el nombre de la categoría.
        $pdf->cell(0, 10, $pdf->encodeString('Estado del pedido: ' . $rowpedidos['estado_pedido']), 1, 1, 'C', 1);
        // Se imprimen las celdas con los datos de los pedidoss.
        $pdf->cell(76, 10, $pdf->encodeString($rowpedidos['nombre_cliente']), 1, 0, 'C');
        $pdf->cell(50, 10, $rowpedidos['fecha_pedido'], 1, 0, 'C');
        $pdf->cell(60, 10, $pdf->encodeString($rowpedidos['direccion_pedido']), 1, 1, 'C');
    }
} else {
    $pdf->cell(0, 10, $pdf->encodeString('No hay libros para mostrar'), 1, 1);
}

// Se llama implícitamente al método footer() y se envía el documento al navegador web.
$pdf->output('I', 'libros.pdf');
?>
