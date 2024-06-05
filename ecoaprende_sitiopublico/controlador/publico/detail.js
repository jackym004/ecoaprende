// Constante para completar la ruta de la API.
const PRODUCTO_API = 'servicios/producto.php';
// Constante tipo objeto para obtener los parámetros disponibles en la URL.
const PARAMS = new URLSearchParams(location.search);
const DETALLES = document.getElementById('detalles');
const MAIN_TITLE = document.getElementById('mainTitle')
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
        DETALLES.innerHTML = '';
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se crean y concatenan las tarjetas con los datos de cada producto.
            DETALLES.innerHTML += `
            <div class="contenedor1 d-flex flex-row justify-content-evenly col-12">
            <div class="contenedorImg d-flex justify-content-center col-3">
                <img src="${SERVER_URL}recursos/img/${row.imagen_libro}" class="imgLibro">
            </div>

            <div class="d-flex flex-column ms-5 col-8 align-items-center contenedorInfo p-5 justify-content-center">
                <h2>${row.nombre_libro}</h2>

                <div class="d-flex flex-row align-items-center justify-content-center col-12 mt-4">
                    <h4 class="me-5">Autor: Ling Ping <br> Estado: ${row.estado_libro}</h4>
                    <h3 class="m-0 p-0">
                       ${row.precio_libro}
                    </h3>
                </div>

                <div class="d-flex flex-row align-items-center justify-content-center col-12 mt-4">
                    <h4 class="me-5">Cantidad</h4>
                    <input type="number" class="form-control text-center me-4 bg-success text-white cantidad"
                        value="1" min="1" step="1" id="quantityInput"
                        onkeypress="return event.charCode >= 48 && event.charCode <= 57">
                    <h4 class="m-0 p-0">
                        Disponibles:  ${row.existencias_libro}
                    </h4>
                </div>

                <div class="col-5 d-flex mt-5 p-0">
                    <a href="detail.html?id=${row.id_libro}" class="btn btn-primary m-0 p-3">Agregar al carrito</a>
                </div>
            </div>
        </div>
            `;
        });
    } 
});