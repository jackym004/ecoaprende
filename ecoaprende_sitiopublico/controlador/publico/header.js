const HEADER = document.querySelector('header');
HEADER.innerHTML = `

<nav class="navbar bg-body-tertiary fixed-top">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">
          <img src="../../recursos/img/Sitio_Público-removebg-preview.png" alt="Logo" width="50" height="45">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
          aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
          <div class="offcanvas-header">
            <img src="../../recursos/img/Sitio_Público__1_-removebg-preview.png" alt="Logo" width="200" >
          </div>
          <div class="offcanvas-body">
            <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
             
              <li class="nav-item m">
                <a class="dropdown-item"
                  href="../../vistas/publica/menu.html">Inicio</a>
              </li>
              <li class="nav-item mt-2">
                <a class="dropdown-item" href="../../vistas/publica/opciones_categoria.html">Libros</a>
              </li>
              <li class="nav-item mt-2">
                <a class="dropdown-item" href="../../vistas/publica/carrito.html">Carrito</a>
              </li>
              <li class="nav-item mt-2">
                <a class="dropdown-item" href="../../vistas/publica/usuario.html">Perfil</a>
              </li>

              <li class="nav-item mt-4 custom-color">
              <a class="dropdown-item" onclick="logOut()">Cerrar sesion</a>
             </li>
             
            </ul>
            
          </div>
        </div>
      </div>
    </nav>
    <!-- contralador de el header -->
    <style>
      .navbar {
        background-color: rgba(119, 127, 71, 1) !important;
      }
      li {
        font-family: 'Ropa Sans';
      }
      .custom-color{
          color: rgba(119, 127, 71, 1) !important;
      }
    </style>

    
`
