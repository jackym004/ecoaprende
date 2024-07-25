<?php
// Se incluye la clase con las plantillas para generar reportes.
require_once('../../auxiliar/report.php');

// Se incluye la clase para trabajar con los datos de los clientes.
require_once('../../modelos/data/clientes_data.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;

// Se instancia la entidad correspondiente.
$cliente = new ClientesData;

// Se inicia el reporte con el encabezado del documento.
$pdf->startReport('Lista de Clientes');

try {
    // Se verifica si existen registros para mostrar, de lo contrario se imprime un mensaje.
    if ($dataClientes = $cliente->readAll()) {
        // Se establece un color de relleno para los encabezados.
        $pdf->setFillColor(255,192,203);
        // Se establece la fuente para los encabezados.
        $pdf->setFont('Arial', 'B', 11);
        // Se imprimen las celdas con los encabezados.
        $pdf->cell(126, 10, 'Nombre', 1, 0, 'C', 1);
        $pdf->cell(60, 10, 'Estado', 1, 1, 'C', 1);
        // Se establece la fuente para los datos de los clientes.
        $pdf->setFont('Arial', '', 11);
        // Se recorren los registros fila por fila.
        foreach ($dataClientes as $rowCliente) {
            // Se imprimen las celdas con los datos de los clientes.
            $pdf->cell(126, 10, $pdf->encodeString($rowCliente['NOMBRE']), 1, 0, 'C');
            $pdf->cell(60, 10, $pdf->encodeString($rowCliente['ESTADO']), 1, 1, 'C');
        }
    } else {
        $pdf->cell(0, 10, $pdf->encodeString('No hay clientes para mostrar'), 1, 1);
    }

    // Se llama implícitamente al método footer() y se envía el documento al navegador web.
    $pdf->output('I', 'clientes.pdf');
} catch (Exception $e) {
    error_log('Error generating report: ' . $e->getMessage());
    echo 'Error generating report. Please check the logs for more details.';
}
?>
