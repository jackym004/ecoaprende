// Constante para completar la ruta de la API.
const USUARIO_API = 'servicios/cliente/clientes.php';
// Constante tipo objeto para obtener los parámetros disponibles en la URL.
const DETALLES = document.getElementById('informacion');
// Método manejador de eventos para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', async () => {
    // Petición para solicitar los productos de la categoría seleccionada.
    const DATA = await fetchData(USUARIO_API, 'readAll');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se inicializa el contenedor de productos.
        INFORMACION.innerHTML = '';
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se crean y concatenan las tarjetas con los datos de cada producto.
            INFORMACION.innerHTML += `
            <div class="card-body">
                <h3 class="ms-5 mt-2">${row.nombre_cliente}</h3>
            </div>
            <div class="row" style="margin-top: 10px;">
                <div class="col">

                    <P id="pp"><i class="bi bi-person-fill fs-2 px-5"></i>${row.nombre_cliente}</P>
                </div>
                <div class="col">

                    <P id="ppp"><i class="bi bi-person-vcard-fill fs-2 "></i>${row.dui_cliente}</P>
                </div>
            </div>
            <div class="row" style="margin-top: 30px;">
                <div class="col">

                    <P id="pp"><i class="material-icons  fs-2 px-5">email</i>${row.correo_cliente}</P>
                </div>
                <div class="col">
                    <i class="material-icons fs-2 ">school</i>
                    <P id="ppp">${row.telefono_cliente}</P>
                </div>

                <a href="/ecoaprende_sitiopublico/vistas/publica/index.html" class="mt-4 text-black">
                    <P><i class="bi bi-escape fs-2"></i>Cerrar sesion</P>
                </a>
            </div>
            `;
        });
    }
});
