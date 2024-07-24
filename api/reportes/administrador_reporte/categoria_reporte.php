<?php
// Se incluye la clase con las plantillas para generar reportes.
require_once('../../auxiliar/report.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;

// Se incluyen las clases para la transferencia y acceso a datos.
require_once('../../modelos/data/libro_data.php');

// Se instancia la entidad correspondiente.
$producto = new LibroData;

// Se inicia el reporte con el encabezado del documento.
$pdf->startReport('Lista de Libros');

// Se verifica si existen registros para mostrar, de lo contrario se imprime un mensaje.
if ($dataProductos = $producto->readAll()) {
    // Se establece un color de relleno para los encabezados.
    $pdf->setFillColor(225);
    // Se establece la fuente para los encabezados.
    $pdf->setFont('Arial', 'B', 11);
    // Se imprimen las celdas con los encabezados.
    $pdf->cell(126, 10, 'Nombre', 1, 0, 'C', 1);
    $pdf->cell(30, 10, 'Precio (US$)', 1, 0, 'C', 1);
    $pdf->cell(30, 10, 'Estado', 1, 1, 'C', 1);
    // Se establece la fuente para los datos de los productos.
    $pdf->setFont('Arial', '', 11);
    // Se recorren los registros fila por fila.
    foreach ($dataProductos as $rowProducto) {
        $estado = $rowProducto['estado_libro'] ? 'Activo' : 'Inactivo';
        // Se imprimen las celdas con los datos de los productos.
        $pdf->cell(126, 10, $pdf->encodeString($rowProducto['nombre_libro']), 1, 0);
        $pdf->cell(30, 10, $rowProducto['precio_libro'], 1, 0);
        $pdf->cell(30, 10, $estado, 1, 1);
    }
} else {
    $pdf->cell(0, 10, $pdf->encodeString('No hay libros para mostrar'), 1, 1);
}

// Se llama implícitamente al método footer() y se envía el documento al navegador web.
$pdf->output('I', 'libros.pdf');
?>
