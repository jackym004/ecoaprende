// Constantes para completar las rutas de la API.
const LIBROS_API = 'servicios/administrador/libros.php';
const CATEGORIA_API = 'servicios/administrador/catlib.php';

// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', () => {
    // Se establece el título del contenido principal.
    // Llamada a la función para llenar la tabla con los registros existentes.
});

/*
*   Función para abrir un reporte automático de productos por categoría.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
const openReport = () => {
    // Se declara una constante tipo objeto con la ruta específica del reporte en el servidor.
    const PATH = new URL(`${SERVER_URL}reportes/administrador_reporte/libros_reporte.php`);
    // Se abre el reporte en una nueva pestaña.or
    window.open(PATH.href);
}


const openReportt = (id) => {
    // Se declara una constante tipo objeto con la ruta específica del reporte en el servidor.
    const PATH = new URL(`${SERVER_URL}reportes/administrador_reporte/categoria_reporte.php`);
    // Se agrega un parámetro a la ruta con el valor del registro seleccionado.
    PATH.searchParams.append('idCategoria', id);
    // Se abre el reporte en una nueva pestaña.
    window.open(PATH.href);
}

const openReporttt = (id) => {
    // Se declara una constante tipo objeto con la ruta específica del reporte en el servidor.
    const PATH = new URL(`${SERVER_URL}reportes/administrador_reporte/cliente_reporte.php`);
    // Se agrega un parámetro a la ruta con el valor del registro seleccionado.
    PATH.searchParams.append('idCliente', id);
    // Se abre el reporte en una nueva pestaña.
    window.open(PATH.href);
}