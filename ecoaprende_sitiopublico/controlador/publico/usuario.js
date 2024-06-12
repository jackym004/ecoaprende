// Constante para completar la ruta de la API.
const USUARIO_API = 'servicios/cliente/clientes.php';
// Constante tipo objeto para obtener los parámetros disponibles en la URL.
const INFORMACION = document.getElementById('informacion')
// Método manejador de eventos para cuando el documento ha cargado.
const SAVE_MODAL = new bootstrap.Modal('#saveModal'),
    MODAL_TITLE = document.getElementById('modalTitle');
// Constantes para establecer los elementos del formulario de guardar.
const SAVE_FORM = document.getElementById('saveForm'),
    ID_CLIENTE = document.getElementById('idCliente'),
    NOMBRE_CLIENTE = document.getElementById('nombreCliente'),
    CORREO_CLIENTE = document.getElementById('correoCliente'),
    TELEFONO_CLIENTE = document.getElementById('telefonoCliente');
document.addEventListener('DOMContentLoaded', async () => {
    // Petición para solicitar los productos de la categoría seleccionada.
    const DATA = await fetchData(USUARIO_API, 'readOne');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se inicializa el contenedor de productos.
        INFORMACION.innerHTML = '';
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se crean y concatenan las tarjetas con los datos de cada producto.
            INFORMACION.innerHTML += `
            <div class="card-body">
                <h3 class="ms-5 mt-2">${row.NOMBRE}</h3>
            </div>
            <div class="row" style="margin-top: 10px;">
                <div class="col">

                    <P id="pp"><i class="bi bi-person-fill fs-2 px-5"></i>${row.NOMBRE}</P>
                </div>
                <div class="col">

                    <P id="ppp"><i class="bi bi-person-vcard-fill fs-2 "></i>${row.DUI}</P>
                </div>
            </div>
            <div class="row" style="margin-top: 30px;">
                <div class="col">

                    <P id="pp"><i class="material-icons  fs-2 px-5">email</i>${row.CORREO}</P>
                </div>
                <div class="col">
                    <i class="material-icons fs-2 ">school</i>
                    <P id="ppp">${row.TELEFONO}</P>
                </div>

                <button type="button" class="btn" onclick="openUpdate(${row.ID})" style="width:5rem, heigth:2rem, background-color: rgba(119, 127, 71, 1)">
                    <i class='bx bxs-phone'></i>                        
                </button>

                <a href="#" onclick="logOut()" class="mt-4 text-black">
                    <P><i class="bi bi-escape fs-2"></i>Cerrar sesion</P>
                </a>

             
            </div>
            `;
        });
    }
});


SAVE_FORM.addEventListener('submit', async (event) => {
    // Se verifica la acción a realizar.
    (ID_CLIENTE.value) ? action = 'updateRow' : action = 'createRow';
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData(SAVE_FORM);
    // Petición para guardar los datos del formulario.
    const DATA = await fetchData(USUARIO_API, action, FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se cierra la caja de diálogo.
        SAVE_MODAL.hide();
        // Se muestra un mensaje de éxito.
        sweetAlert(1, DATA.message, true);
    } else {
        sweetAlert(2, DATA.error, false);
    }
});

const openUpdate = async (id) => {
    // Petición para obtener los datos del registro solicitado.
    const DATA = await fetchData(USUARIO_API, 'readEditProfile');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se muestra la caja de diálogo con su título.
        SAVE_MODAL.show();
        MODAL_TITLE.textContent = 'Actualizar Usuario';
        // Se prepara el formulario.
        SAVE_FORM.reset();
        // Se inicializan los campos con los datos.
        const ROW = DATA.dataset;
        ID_CLIENTE.value = ROW.ID;
        NOMBRE_CLIENTE.value = ROW.NOMBRE;
        CORREO_CLIENTE.value = ROW.CORREO;
        TELEFONO_CLIENTE.value = ROW.TELEFONO;
    } else {
        sweetAlert(2, DATA.error, false);
    }
}