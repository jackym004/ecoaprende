/*
* Controlador de uso general en las páginas web del sitio privado.
* Sirve para manejar la plantilla del encabezado y pie del documento.
*/

// Constante para completar la ruta de la API.
const USER_API = 'services/administrador/administrador.php';
// Constante para establecer el elemento del contenido principal.
const MAIN = document.querySelector('main');
MAIN.classList.add('container');

/* Función asíncrona para cargar el encabezado y pie del documento.
* Parámetros: ninguno.
* Retorno: ninguno.
*/
const loadTemplate = async () => {


// Se agrega el encabezado de la página web antes del contenido principal.
MAIN.insertAdjacentHTML('beforebegin', `
            <aside id="sidebar">
                <div class="d-flex">
                    <button class="toggle-btn" type="button">
                    </button>
                    <div class="sidebar-logo ms-3 ">
                        <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/logoeco.png" alt=""
                            width="110px" height="80px">
                    </div>
                </div>
                <ul class="sidebar-nav">
                    <li class="sidebar-item mt-2 admin" onclick="Menu()">
                        <a href="Menu.html" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/admin.png"
                                alt="" width="19">
                            <span class="ms-3">nombre administrador</span>
                        </a>
                    </li>

                    <li class="sidebar-item menu" onclick="categoriaProductos()">
                        <a href="" class="menu sidebar-link">
                            <span class="mx-auto">Menu</span>
                        </a>
                    </li>


                    <li class="sidebar-item mt-2" onclick="productosP()">
                        <a href="productosP.html" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/inicio.png"
                                alt="" width="19">
                            <span class="ms-3">Panel
                                Principal</span>
                        </a>
                    </li>


                    <li class="sidebar-item mt-2" onclick="entre()">
                        <a href="entrenamientos.html" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/repo.png" alt=""
                                width="19">
                            <span class="ms-3">Gestionar
                                Reportes</span>
                        </a>
                    </li>


                    <li class="sidebar-item mt-2">
                        <a href="#" class="sidebar-link ">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/categoria_p.png"
                                alt="" width="19">
                            <span class="ms-3">Gestionar
                                categorias</span>
                        </a>
                    </li>

                    <li class="sidebar-item mt-2" onclick="alumnos_total()">
                        <a href="alumnos_total.html" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/perfill.png"
                                alt="" width="19">
                            <span class="ms-3">Gestionar
                                Perfiles</span>
                        </a>
                    </li>
                    <li class="sidebar-item mt-2" onclick="inscripciones()">
                        <a href="inscripciones.html" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/valo.png" alt=""
                                width="19">
                            <span class="ms-3">Gestionar
                                Valoraciones</span>
                        </a>
                    </li>

                    <li class="sidebar-item mt-2 libros">
                        <a href="#" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/libros.png"
                                alt="" width="19">
                            <span class="ms-3 ">Gestionar libros
                            </span>
                        </a>
                    </li>

                    <li class="sidebar-item mt-4 " onclick="categoriaProfesores()">
                        <a href="#" class="sidebar-link">
                            <img src="/ecoaprende_sitioprivado/recursos_administrador/img_administrador/cerrar.png"
                                alt="" width="19">
                            <span class="ms-3">cerrar sesión</span>
                        </a>
                    </li>
                </ul>
            </aside>
`);
}