// Constante para establecer el formulario de iniciar sesión.
const USER_API = 'servicios/clientes.php';

const SESSION_FORM = document.getElementById('sessionForm');

// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', async () => {
   // Petición para consultar los usuarios registrados.
   const DATA = await fetchData(USER_API, 'readUsers');
   // Se comprueba si existe una sesión, de lo contrario se sigue con el flujo normal.
   if (DATA.session) {
       // Se direcciona a la página web de bienvenida.
       location.href = 'menu.html';
   } else if (DATA.status) {
       // Se muestra el formulario para iniciar sesión.
       LOGIN_FORM.classList.remove('d-none');
       sweetAlert(4, DATA.message, true);
   }
});

// Método del evento para cuando se envía el formulario de iniciar sesión.
SESSION_FORM.addEventListener('submit', async (event) => {
    // Se evita recargar la página web después de enviar el formulario.
    event.preventDefault();
    // Constante tipo objeto con los datos del formulario.
    const FORM = new FormData(SESSION_FORM);
    // Petición para determinar si el cliente se encuentra registrado.
    const DATA = await fetchData(USER_API, 'logIn', FORM);
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        sweetAlert(1, DATA.message, true, 'menu.html');
    } else {
        sweetAlert(2, DATA.error, false);
    }
});