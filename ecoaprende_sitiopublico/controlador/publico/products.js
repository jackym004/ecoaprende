// Constante para completar la ruta de la API.
const PRODUCTO_API = 'servicios/cliente/producto.php';
const PEDIDO_API = 'servicios/cliente/pedido.php'
// Constante tipo objeto para obtener los parámetros disponibles en la URL.
const PARAMS = new URLSearchParams(location.search);
const PRODUCTOS = document.getElementById('productos');
const MAIN_TITLE = document.getElementById('mainTitle');
// Método manejador de eventos para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', async () => {
    // Se define un objeto con los datos de la categoría seleccionada.
    const FORM = new FormData();
    FORM.append('idCategoria', PARAMS.get('id'));
    // Petición para solicitar los productos de la categoría seleccionada.
    const DATA = await fetchData(PRODUCTO_API, 'readProductosCategoria', FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se asigna como título principal la categoría de los productos.
        MAIN_TITLE.textContent = `Categoría: ${PARAMS.get('nombre')}`;
        // Se inicializa el contenedor de productos.
        PRODUCTOS.innerHTML = '';
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se crean y concatenan las tarjetas con los datos de cada producto.
            PRODUCTOS.innerHTML += `
                <div class="col-sm-12 col-md-6 col-lg-3">
                    <div class="card mb-3">
                        <img src="${SERVER_URL}imagenes/categoria/${row.imagen_libro}" class="card-img-top" alt="${row.nombre_libro}">
                        <div class="card-body">
                            <h5 class="card-title">${row.nombre_libro}</h5>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Precio unitario: (US$) ${row.precio_libro}</li>
                            <li class="list-group-item">Existencias: ${row.existencias_libro}</li>
                        </ul>
                        <div class="card-body text-center">
                            <a href="#" onclick="saveCart(${row.id_libro})" class="btn btn-primary">Agregar al carrito</a>
                        </div>
                    </div>
                </div>
            `;
        });
    } else {
        // Se presenta un mensaje de error cuando no existen datos para mostrar.
        MAIN_TITLE.textContent = DATA.error;
    }
});


async function saveCart(id){
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData();
    FORM.append('idProducto', id);
    // Petición para guardar los datos del formulario.
    const DATA = await fetchData(PEDIDO_API, 'createDetail', FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se constata si el cliente ha iniciado sesión.
    if (DATA.status) {
        sweetAlert(1, DATA.message, false, 'carrito_compra.html');
    } else if (DATA.session) {
        sweetAlert(2, DATA.error, false);
    } else {
        sweetAlert(3, DATA.error, true, 'index.html');
    }
}