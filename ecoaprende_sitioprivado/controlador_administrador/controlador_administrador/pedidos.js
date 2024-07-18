// Constante para completar la ruta de la API.
const PEDIDOS_API = 'servicios/administrador/pedidos.php';
const DETALLE_PEDIDO_API = 'servicios/administrador/detalle_pedido.php';
const VALORACIONES_API = 'servicios/administrador/valoraciones';
// Constante para establecer el formulario de buscar.
const SEARCH_FORM = document.getElementById('searchForm');
// Constantes para establecer los elementos de la tabla.
const TABLE_BODY = document.getElementById('tabla_envios'),
    ROWS_FOUND = document.getElementById('rowsFound');
const TABLE_BODY2 = document.getElementById('tabla_pedidos'),
    ROWS_FOUND2 = document.getElementById('rowsFound2');
// Constantes para establecer los elementos del componente Modal.
const SAVE_MODAL = new bootstrap.Modal('#saveModal'),
    MODAL_TITLE = document.getElementById('modalTitle');
// Constantes para establecer los elementos del formulario de guardar.
const SAVE_FORM = document.getElementById('saveForm'),
    ID_PEDIDO = document.getElementById('idPedido'),
    ESTADO = document.getElementById('estado');
const DETAIL_MODAL = new bootstrap.Modal('#detailModal'),
    MODAL_TITLE_DETAIL = document.getElementById('exampleModalLabel');

// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', () => {
    // Llamada a la función para mostrar los productos del carrito de compras.
    fillTable();
    fillTable2();
});


const lista_datos = [
    {
        estado: "Entregado",
        id: "Entregado",
    },
    {
        estado: 'En camino',
        id: 'En camino',
    },
    {
        estado: 'Cancelado',
        id: 'Cancelado',
    }
];

// Función para poblar un combobox (select) con opciones quemadas
const fillSelected = (data, action, selectId, selectedValue = null) => {
    const selectElement = document.getElementById(selectId);

    // Limpiar opciones previas del combobox
    selectElement.innerHTML = '';

    // Crear opción por defecto
    const defaultOption = document.createElement('option');
    defaultOption.value = '';
    defaultOption.textContent = 'Selecciona a el estado';
    selectElement.appendChild(defaultOption);

    // Llenar el combobox con los datos proporcionados
    data.forEach(item => {
        const option = document.createElement('option');
        option.value = item.estado; // Suponiendo que hay una propiedad 'id' en los datos
        option.textContent = item.estado; // Cambia 'horario' al nombre de la propiedad que deseas mostrar en el combobox
        selectElement.appendChild(option);
    });

    // Seleccionar el valor especificado si se proporciona
    if (selectedValue !== null) {
        selectElement.value = selectedValue;
    }
};


const openDetail = async (id) => {
    // Se define un objeto con los datos del registro seleccionado.
    const FORM = new FormData();
    FORM.append('idPedido', id);
    // Se muestra la caja de diálogo con su título.
    DETAIL_MODAL.show();
    MODAL_TITLE_DETAIL.textContent = 'Detalle del pedido ' + id;
    fillDetail(FORM);
}

/*
*   Función asíncrona para cambiar el estado de un registro.
*   Parámetros: id (identificador del registro seleccionado).
*   Retorno: ninguno.
*/
const openState = async (id) => {
    try {
        // Se define un objeto con los datos del registro seleccionado.
        const FORM = new FormData();
        FORM.append('idPedido', id);
        // Petición para obtener los datos del registro solicitado.
        const DATA = await fetchData(PEDIDOS_API, 'readOne', FORM);
        // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
        if (DATA.status) {
            // Se muestra la caja de diálogo con su título.
            SAVE_MODAL.show();
            MODAL_TITLE.textContent = 'Actualizar estado';
            // Se prepara el formulario.
            SAVE_FORM.reset();
            // Se inicializan los campos con los datos.
            const ROW = DATA.dataset;
            ID_PEDIDO.value = ROW.ID;
            fillSelected(lista_datos, 'readAll', 'estado', ROW.estado_pedido);
        } else {
            sweetAlert(2, DATA.error, false);
        }
    } catch (Error) {
        console.log(Error);
    }

}


/*
*   Función asíncrona para llenar la tabla con los registros disponibles.
*   Parámetros: form (objeto opcional con los datos de búsqueda).
*   Retorno: ninguno.
*/
const fillTable = async (form = null) => {
    // Se inicializa el contenido de la tabla.
    ROWS_FOUND.textContent = '';
    TABLE_BODY.innerHTML = '';
    // Se verifica la acción a realizar.
    (form) ? action = 'searchRows' : action = 'readAll';
    // Petición para obtener los registros disponibles.
    const DATA = await fetchData(PEDIDOS_API, action, form);
    console.log(DATA);

    if (DATA.status) {
        // Mostrar elementos obtenidos de la API
        DATA.dataset.forEach(row => {
            TABLE_BODY.innerHTML += `
                <tr class="${getRowBackgroundColor(row.estado_pedido)}">
                    <td>${row.nombre_cliente}</td>
                    <td>${row.direccion_pedido}</td>
                    <td>${row.fecha_pedido}</td>
                    <td class="${getRowColor(row.estado_pedido)}">${row.estado_pedido}</td>
                <td>
                        <button type="button" class="btn btn-outline-info" onclick="openDetail(${row.ID})">
                            <i class="bi bi-card-list"></i>
                        </button>
                        <button type="button" class="btn btn-outline-primary" onclick="openState(${row.ID})">
                        <i class="bi bi-exclamation-octagon"></i>
                        </button>
                </td>
            </tr>
                `;
        });
        // Se muestra un mensaje de acuerdo con el resultado.
        ROWS_FOUND.textContent = DATA.message;
    } else {
        sweetAlert(4, DATA.error, true);
    }
}

const fillTable2 = async (form = null) => {
    // Se inicializa el contenido de la tabla.
    ROWS_FOUND2.textContent = '';
    TABLE_BODY2.innerHTML = '';
    // Se verifica la acción a realizar.
    (form) ? action = 'searchRows' : action = 'readAllTable';
    // Petición para obtener los registros disponibles.
    const DATA = await fetchData(PEDIDOS_API, action, form);
    console.log(DATA);

    if (DATA.status) {
        // Mostrar elementos obtenidos de la API
        DATA.dataset.forEach(row => {
            TABLE_BODY.innerHTML += `
                <tr class="${getRowBackgroundColor(row.nombre_libro)}">
                    <td>${row.precio_producto}</td>
                    <td>${row.cantidad_comprada}</td>
                    <td>${row.direccion_pedido}</td>
                    <td>${row.fecha_pedido}</td>
                <td>
                        <button type="button" class="btn btn-outline-info" onclick="createComment(${row.ID})">
                            <i class="bi bi-card-list"></i>
                        </button>
                </td>
            </tr>
                `;
        });
        // Se muestra un mensaje de acuerdo con el resultado.
        ROWS_FOUND.textContent = DATA.message;
    } else {
        sweetAlert(4, DATA.error, true);
    }
}

const createComment = async (id) => {
    // Se muestra la caja de diálogo con su título.
    SAVE_MODAL2.show();
    // Se prepara el formulario.
    SAVE_FORM2.reset();
    MODAL_TITLE2.textContent = 'Enviar Comentario';
    ID_DETALLE.value = id;
    COMENTARIO.disabled = false;
    CALIFICACION_PRODUCTO.disabled = false;
}

/*
*   Función asíncrona para llenar la tabla con los registros disponibles.
*   Parámetros: form (objeto opcional con los datos de búsqueda).
*   Retorno: ninguno.
*/
const fillDetail = async (form = null) => {
    const cargarTabla = document.getElementById('tabla_detalle');
    cargarTabla.innerHTML = '';
    // Petición para obtener los registros disponibles.
    const DATA = await fetchData(DETALLE_PEDIDO_API, 'readOne', form);
    if (DATA.status) {
        // Mostrar elementos obtenidos de la API
        DATA.dataset.forEach(row => {
            const tablaHtml = `
            <tr>
                    <td>${row.nombre_libro}</td>
                    <td>${row.cantidad_comprada}</td>
                    <td>${row.precio_producto}</td>
            </tr>
                `;
            cargarTabla.innerHTML += tablaHtml;
        });
    } else {
        sweetAlert(4, DATA.error, true);
    }
}

function getRowColor(estado) {
    switch (estado) {
        case 'En camino':
            return 'text-warning';
        case 'Cancelado':
            return 'text-danger';
        case 'Entregado':
            return 'text-success';
        default:
            return '';
    }
}

function getRowBackgroundColor(estado) {
    switch (estado) {
        case 'En camino':
            return 'border-warning';
        case 'Cancelado':
            return 'border-danger';
        case 'Entregado':
            return 'border-success';
        default:
            return '';
    }
}

// Método del evento para cuando se envía el formulario de buscar.
SEARCH_FORM.addEventListener('submit', (event) => {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData(SEARCH_FORM);
    // Llamada a la función para llenar la tabla con los resultados de la búsqueda.
    fillTable(FORM);
});

// Método del evento para cuando se envía el formulario de guardar.
SAVE_FORM.addEventListener('submit', async (event) => {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se verifica la acción a realizar.
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData(SAVE_FORM);
    // Petición para guardar los datos del formulario.
    const DATA = await fetchData(PEDIDOS_API, 'changeState', FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se cierra la caja de diálogo.
        SAVE_MODAL.hide();
        // Se muestra un mensaje de éxito.
        sweetAlert(1, DATA.message, true);
        // Se carga nuevamente la tabla para visualizar los cambios.
        fillTable();
    } else {
        sweetAlert(2, DATA.error, false);
        console.error(DATA.exception);
    }
});

SAVE_FORM2.addEventListener('create', async (event) => {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Se verifica la acción a realizar.
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData(SAVE_FORM2);
    // Petición para guardar los datos del formulario.
    const DATA = await fetchData(VALORACIONES_API, 'changeState', FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se cierra la caja de diálogo.
        SAVE_MODAL2.hide();
        // Se muestra un mensaje de éxito.
        sweetAlert(1, DATA.message, true);
        // Se carga nuevamente la tabla para visualizar los cambios.
        fillTable();
    } else {
        sweetAlert(2, DATA.error, false);
        console.error(DATA.exception);
    }
});

/*
*   Función para abrir un reporte automático de productos por categoría.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
const openReport = () => {
    // Se declara una constante tipo objeto con la ruta específica del reporte en el servidor.
    const PATH = new URL(`${SERVER_URL}reports/admin/productos.php`);
    // Se abre el reporte en una nueva pestaña.
    window.open(PATH.href);
}