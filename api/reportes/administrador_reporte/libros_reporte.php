<?php
// Se incluye la clase con las plantillas para generar reportes.
require_once('../../auxiliar/report.php');
// Se incluyen las clases para la transferencia y acceso a datos.
require_once('../../modelos/data/libro_data.php');
require_once('../../modelos/data/categorialib_data.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;
// Se inicia el reporte con el encabezado del documento.
$pdf->startReport('Libros por categoría');
// Se instancia el módelo Categoría para obtener los datos.
$categoria = new CategoriaData;
// Se verifica si existen registros para mostrar, de lo contrario se imprime un mensaje.
if ($dataCategorias = $categoria->readAll()) {
    // Se establece un color de relleno para los encabezados.
    $pdf->setFillColor(255,192,203);
    // Se establece la fuente para los encabezados.
    $pdf->setFont('Arial', 'B', 11);
    // Se imprimen las celdas con los encabezados.
    $pdf->cell(126, 10, 'Nombre', 1, 0, 'C', 1);
    $pdf->cell(30, 10, 'Precio (US$)', 1, 0, 'C', 1);
    $pdf->cell(30, 10, 'Estado', 1, 1, 'C', 1);

    // Se establece un color de relleno para mostrar el nombre de la categoría.
    $pdf->setFillColor(240);
    // Se establece la fuente para los datos de los productos.
    $pdf->setFont('Arial', '', 11);

    // Se recorren los registros fila por fila.
    foreach ($dataCategorias as $rowCategoria) {
        // Se imprime una celda con el nombre de la categoría.
        $pdf->cell(0, 10, $pdf->encodeString('Categoría: ' . $rowCategoria['nombre_categoria']), 1, 1, 'C', 1);
        // Se instancia el módelo Producto para procesar los datos.
        $producto = new LibroData;
        // Se establece la categoría para obtener sus productos, de lo contrario se imprime un mensaje de error.
        if ($producto->setCategoria($rowCategoria['id_categoria'])) {
            // Se verifica si existen registros para mostrar, de lo contrario se imprime un mensaje.
            if ($dataProductos = $producto->librosCategoria()) {
                // Se recorren los registros fila por fila.
                foreach ($dataProductos as $rowProducto) {
                    ($rowProducto['estado_libro']) ? $estado = 'Activo' : $estado = 'Inactivo';
                    // Se imprimen las celdas con los datos de los productos.
                    $pdf->cell(126, 10, $pdf->encodeString($rowProducto['nombre_libro']), 1, 0);
                    $pdf->cell(30, 10, $rowProducto['precio_libro'], 1, 0);
                    $pdf->cell(30, 10, $estado, 1, 1);
                }
            } else {
                $pdf->cell(0, 10, $pdf->encodeString('No hay libros en la categoría'), 1, 1);
            }
        } else {
            $pdf->cell(0, 10, $pdf->encodeString('Categoría incorrecta o inexistente'), 1, 1);
        }
    }
} else {
    $pdf->cell(0, 10, $pdf->encodeString('No hay Libros para mostrar'), 1, 1);
}
// Se llama implícitamente al método footer() y se envía el documento al navegador web.
$pdf->output('I', 'productos.pdf');
