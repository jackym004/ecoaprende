// Constante para completar la ruta de la API.
const LIBROS_API = 'servicios/administrador/libros.php';
const CLIENTES_API = 'servicios/administrador/clientes.php';
const PEDIDOS_API = 'servicios/administrador/pedidos.php';
const DETALLE_PEDIDO_API = 'servicios/administrador/detalle_pedido.php';


// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', () => {
    // Constante para obtener el número de horas.
    const HOUR = new Date().getHours();
    // Se define una variable para guardar un saludo.
    let greeting = '';
    // Dependiendo del número de horas transcurridas en el día, se asigna un saludo para el usuario.
    if (HOUR < 12) {
        greeting = 'Buenos días';
    } else if (HOUR < 19) {
        greeting = 'Buenas tardes';
    } else if (HOUR <= 23) {
        greeting = 'Buenas noches';
    }
    // Llamada a la funciones que generan los gráficos en la página web.
    graficoBarrasCategorias();
    graficoPastelCategorias();
    graficoLineaUsuarioMayorPedidos();
    graficoProductosVendidos();
    graficoValoracion();
});
/*
*   Función asíncrona para mostrar un gráfico de barras con la cantidad de productos por categoría.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
const graficoBarrasCategorias = async () => {
    // Petición para obtener los datos del gráfico.
    const DATA = await fetchData(LIBROS_API, 'cantidadLibrosCategoria');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se remueve la etiqueta canvas.
    if (DATA.status) {
        // Se declaran los arreglos para guardar los datos a graficar.
        let categorias = [];
        let cantidades = [];
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se agregan los datos a los arreglos.
            categorias.push(row.nombre_categoria);
            cantidades.push(row.cantidad);
        });
        // Llamada a la función para generar y mostrar un gráfico de barras. Se encuentra en el archivo components.js
        barGraph('chart1', categorias, cantidades, 'Cantidad de libros', 'Cantidad de libros por categoría');
    } else {
        document.getElementById('chart1').remove();
        console.log(DATA.error);
    }
}


/*
*   Función asíncrona para mostrar un gráfico de pastel con el porcentaje de productos por categoría.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
const graficoPastelCategorias = async () => {
    // Petición para obtener los datos del gráfico.
    const DATA = await fetchData(LIBROS_API, 'porcentajeLibrosCategoria');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se remueve la etiqueta canvas.
    if (DATA.status) {
        // Se declaran los arreglos para guardar los datos a gráficar.
        let categorias = [];
        let porcentajes = [];
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se agregan los datos a los arreglos.
            categorias.push(row.nombre_categoria);
            porcentajes.push(row.porcentaje);
        });
        // Llamada a la función para generar y mostrar un gráfico de pastel. Se encuentra en el archivo components.js
        pieGraph('chart2', categorias, porcentajes, 'Porcentaje de libros por categoría');
    } else {
        document.getElementById('chart2').remove();
        console.log(DATA.error);
    }
}

/*
*   Función asíncrona para mostrar un gráfico de linea con la cantidad de usuarios que han hecho la mayor cantidad de pedidos.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
const graficoLineaUsuarioMayorPedidos = async () => {
    // Petición para obtener los datos del gráfico.
    const DATA = await fetchData(CLIENTES_API, 'topUsuarios');

    // Se comprueba si la respuesta es satisfactoria, de lo contrario se remueve la etiqueta canvas.
    if (DATA.status) {
        // Se declaran los arreglos para guardar los datos a graficar.
        let usuario = [];
        let producto = [];

        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se agregan los datos a los arreglos.
            usuario.push(row.nombre_cliente);
            producto.push(row.numero_de_pedidos);
        });

        // Llamada a la función para generar y mostrar un gráfico de líneas.
        lineGraph('chart3', usuario, producto, 'Cantidad de usuarios', 'Cantidad de productos comprados');
    } else {
        document.getElementById('chart3').remove();
        console.log(DATA.error);
    }
}


/*
*   Función para generar un gráfico doughnut o de pastel para los productos mas vendidos. Requiere la librería chart.js para funcionar.
*   Parámetros: canvas (identificador de la etiqueta canvas), xAxis (datos para el eje X), yAxis (datos para el eje Y), legend (etiqueta para los datos) y title (título del gráfico).
*   Retorno: ninguno.
*/

const graficoProductosVendidos = async () => {
    const DATA = await fetchData(LIBROS_API, 'productosMasComprados');
    if (DATA.status) {
        let libros = [];
        let cantidad = [];
        DATA.dataset.forEach(row => {
            libros.push(row.nombre_libro);
            cantidad.push(row.total_comprado);
        });
        doughnutGraph('chart4', libros, cantidad, 'Libros más Vendidos');
    } else {
        document.getElementById('chart4').remove();
        console.log(DATA.error);
    }
}

/*
*   Función para generar un gráfico de radar para los productos con mas valoraciones. Requiere la librería chart.js para funcionar.
*   Parámetros: canvas (identificador de la etiqueta canvas), xAxis (datos para el eje X), yAxis (datos para el eje Y), legend (etiqueta para los datos) y title (título del gráfico).
*   Retorno: ninguno.
*/

const graficoValoracion = async () => {
    const DATA = await fetchData(PEDIDOS_API, 'productosMasValorados');
    if (DATA.status) {
        let libros = [];
        let promedio = [];
        DATA.dataset.forEach(row => {
            libros.push(row.nombre_libro);
            promedio.push(row.promedio_valoracion);
        });
        console.log(libros);
        radarGraph('chart5', libros, promedio, 'Libros valoracion alta');
        //radarGraph('chart5', ['Leyenda1', 'Leyenda2', 'Leyenda3'], [5, 6, 7], 'Mi Título');
    } else {
        document.getElementById('chart5').remove();
        console.log(DATA.error);
    }
}


/*
*   Función para generar un gráfico de barras verticales. Requiere la librería chart.js para funcionar.
*   Parámetros: canvas (identificador de la etiqueta canvas), xAxis (datos para el eje X), yAxis (datos para el eje Y), legend (etiqueta para los datos) y title (título del gráfico).
*   Retorno: ninguno.
*/

const graficoPredictivoMes = async () => {
    const DATA = await fetchData(LIBROS_API, 'ventasPorMes');

    if (DATA && DATA.status) {
        let meses = [];
        let proyecciones = [];

        DATA.dataset.forEach(row => {
            meses.push(row.mes_proyeccion);
            proyecciones.push(row.proyeccion_ventas);
        });

        const chartTitle = 'Proyecciones de ventas para los siguientes meses';
        const xAxisLabel = 'Mes';
        const yAxisLabel = 'Monto de Ventas (Proyección)';

        renderChart2('chart6', 'bar', meses, proyecciones, chartTitle, xAxisLabel, yAxisLabel);
    } else {
        const chartElement = document.getElementById('chart6');
        if (chartElement) {
            chartElement.remove();
        }
        console.log(DATA ? DATA.error : 'Error en la llamada a la API');
    }
};

