// Constante para completar la ruta de la API.
const PEDIDO_API = 'servicios/cliente/pedido.php';
// Constante para establecer el cuerpo de la tabla.
const TABLE_BODY = document.getElementById('tableBody');
// Constante para establecer la caja de diálogo de cambiar producto.
const ITEM_MODAL = new bootstrap.Modal('#itemModal');
// Constante para establecer el formulario de cambiar producto.
const ITEM_FORM = document.getElementById('itemForm');

// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', () => {
    // Llamada a la función para mostrar los productos del carrito de compras.
    readDetail();
});

// Método del evento para cuando se envía el formulario de cambiar cantidad de producto.
ITEM_FORM.addEventListener('submit', async (event) => {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData(ITEM_FORM);
    // Petición para actualizar la cantidad de producto.
    const DATA = await fetchData(PEDIDO_API, 'updateDetail', FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se actualiza la tabla para visualizar los cambios.
        readDetail();
        // Se cierra la caja de diálogo del formulario.
        ITEM_MODAL.hide();
        // Se muestra un mensaje de éxito.
        sweetAlert(1, DATA.message, true);
    } else {
        sweetAlert(2, DATA.error, false);
    }
});

/*
*   Función para obtener el detalle del carrito de compras.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
async function readDetail() {
    // Petición para obtener los datos del pedido en proceso.
    const DATA = await fetchData(PEDIDO_API, 'readDetail');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se inicializa el cuerpo de la tabla.
        TABLE_BODY.innerHTML = '';
        // Se declara e inicializa una variable para calcular el importe por cada producto.
        let subtotal = 0;
        // Se declara e inicializa una variable para sumar cada subtotal y obtener el monto final a pagar.
        let total = 0;
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            subtotal = row.precio_producto * row.cantidad_comprada;
            total += subtotal;
            // Se crean y concatenan las filas de la tabla con los datos de cada registro.
            TABLE_BODY.innerHTML += `
                <tr>
                    <td>${row.nombre_libro}</td>
                    <td>${row.precio_producto}</td>
                    <td>${row.cantidad_comprada}</td>
                    <td>${subtotal.toFixed(2)}</td>
                    <td>
                        <button type="button" onclick="openUpdate(${row.id_detalles_pedidos}, ${row.cantidad_comprada})" class="btn btn-info">
                            <i class="bi bi-plus-slash-minus"></i>
                        </button>
                        <button type="button" onclick="openDelete(${row.id_detalles_pedidos})" class="btn btn-danger">
                            <i class="bi bi-cart-dash"></i>
                        </button>
                    </td>
                </tr>
            `;
        });
        // Se muestra el total a pagar con dos decimales.
        document.getElementById('pago').textContent = total.toFixed(2);
    } else {
        sweetAlert(4, DATA.error, false);
    }
}

/*
*   Función para abrir la caja de diálogo con el formulario de cambiar cantidad de producto.
*   Parámetros: id (identificador del producto) y quantity (cantidad actual del producto).
*   Retorno: ninguno.
*/
function openUpdate(id, quantity) {
    // Se abre la caja de diálogo que contiene el formulario.
    ITEM_MODAL.show();
    // Se inicializan los campos del formulario con los datos del registro seleccionado.
    document.getElementById('idDetalle').value = id;
    document.getElementById('cantidadProducto').value = quantity;
}

function handlePayment(event) {
    event.preventDefault();
    var modal = new bootstrap.Modal(document.getElementById('paymentModal'));
    modal.hide();
    
    finishOrder();
}

const openReport = async () => {
    // Se declara una constante tipo objeto con la ruta específica del reporte en el servidor.
    const PATH = new URL(`${SERVER_URL}reports/public/comprobante.php`);
    
    // Abre la URL en una nueva pestaña para descargar el archivo.
    window.open(PATH.href, '_blank');
}

function handleClick() {
    finishOrder();
}

 // Formatea el número de la tarjeta de crédito con espacios cada 4 dígitos y limita a 16 dígitos
 function formatCardNumber(input) {
    let value = input.value.replace(/\D/g, ''); // Elimina caracteres no numéricos
    if (value.length > 16) {
        value = value.slice(0, 16); // Limita a 16 dígitos
    }
    const formatted = value.match(/.{1,4}/g)?.join(' ') || '';
    input.value = formatted;
}

// Formatea la fecha de expiración en el formato MM/AA
function formatExpiryDate(input) {
    const value = input.value.replace(/\D/g, ''); // Elimina caracteres no numéricos
    if (value.length <= 2) {
        input.value = value;
    } else {
        input.value = value.slice(0, 2) + '/' + value.slice(2, 4);
    }
}

// Formatea el CVV a 3 dígitos
function formatCVV(input) {
    const value = input.value.replace(/\D/g, ''); // Elimina caracteres no numéricos
    input.value = value.slice(0, 3);
}


/*
*   Función asíncrona para mostrar un mensaje de confirmación al momento de finalizar el pedido.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/


async function finishOrder() {
    // Llamada a la función para mostrar un mensaje de confirmación, capturando la respuesta en una constante.
    const RESPONSE = await confirmAction('¿Está seguro de finalizar el pedido?');
    
    // Se verifica la respuesta del mensaje.
    if (RESPONSE) {
        // Primero, generamos el reporte.
        await openReport();
        
        // Esperamos 5 segundos para asegurar que el reporte se haya abierto.
        await new Promise(resolve => setTimeout(resolve, 5000)); // Esperar 5 segundos
        
        // Luego, petición para finalizar el pedido en proceso.
        const DATA = await fetchData(PEDIDO_API, 'finishOrder');
        
        // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
        if (DATA.status) {
            sweetAlert(1, DATA.message, true, 'index.html');
            // Recargar la página y redirigir al índice.
            setTimeout(() => {
                window.location.href = 'index.html'; // Redirige al índice después de recargar
            }, 50000); // Esperar 50 segundos para la recarga
        } else {
            sweetAlert(2, DATA.error, false);
        }
    }
}
/*
*   Función asíncrona para mostrar un mensaje de confirmación al momento de eliminar un producto del carrito.
*   Parámetros: id (identificador del producto).
*   Retorno: ninguno.
*/
async function openDelete(id) {
    // Llamada a la función para mostrar un mensaje de confirmación, capturando la respuesta en una constante.
    const RESPONSE = await confirmAction('¿Está seguro de remover el producto?');
    // Se verifica la respuesta del mensaje.
    if (RESPONSE) {
        // Se define un objeto con los datos del producto seleccionado.
        const FORM = new FormData();
        FORM.append('idDetalle', id);
        // Petición para eliminar un producto del carrito de compras.
        const DATA = await fetchData(PEDIDO_API, 'deleteDetail', FORM);
        // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
        if (DATA.status) {
            await sweetAlert(1, DATA.message, true);
            // Se carga nuevamente la tabla para visualizar los cambios.
            readDetail();
        } else {
            sweetAlert(2, DATA.error, false);
        }
    }
}
