// Constante para establecer el formulario de iniciar sesión.
const USUARIO_API = 'servicios/cliente/clientes.php';

const SESSION_FORM = document.getElementById('sessionForm');

// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', async () => {
   // Petición para consultar los datos del perfil registrados.
   openProfile();
});

async function openProfile() {
    // Petición para solicitar los datos del perfil seleccionado.
    const DATA = await fetchData(USUARIO_API, 'readProfile');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se colocan los datos en la página web de acuerdo con el perfil seleccionado previamente.
        document.getElementById('nombre').textContent = DATA.dataset.NOMBRE;
        document.getElementById('email').textContent = DATA.dataset.EMAIL;
    } else {

    }
}