// Constante para completar la ruta de la API.
const CATEGORIA_API = '/ecoaprende_sitioprivado/api_sitioprivado/servicios/catlib.php';
// Constante para establecer el contenedor de categorías.
const CATEGORIAS = document.getElementById('categorias');

// Método del evento para cuando el documento ha cargado.
document.addEventListener('DOMContentLoaded', async () => {
    // Llamada a la función para mostrar el encabezado y pie del documento.
    loadTemplate();
    // Se establece el título del contenido principal.
    MAIN_TITLE.textContent = 'Productos por categoría';
    // Petición para obtener las categorías disponibles.
    const DATA = await fetchData(CATEGORIA_API, 'readAll');
    // Se comprueba si la respuesta es satisfactoria, de lo contrario se muestra un mensaje con la excepción.
    if (DATA.status) {
        // Se inicializa el contenedor de categorías.
        CATEGORIAS.innerHTML = '';
        // Se recorre el conjunto de registros fila por fila a través del objeto row.
        DATA.dataset.forEach(row => {
            // Se establece la página web de destino con los parámetros.
            let url = `products.html?id=${row.id_categoria}&nombre=${row.nombre_categoria}`;
            // Se crean y concatenan las tarjetas con los datos de cada categoría.
            CATEGORIAS.innerHTML += `
          <div class="col-4">
            <div class="card mt-4">
              <img src="${SERVER_URL}recursos/img/${row.imagen_categoria}" class="card-img-top" alt="${row.imagen_categoria}">
              <div class="card-body">
                <h5 class="card-title text-start">${row.nombre_categoria}</h5>
                <p class="card-text ">${row.descripcion_categoria}</p>
                <a href="${url}" class="btn btn-primary text-white">Ir</a>
              </div>
            </div>
          </div>
            `;
        });
    }  
});