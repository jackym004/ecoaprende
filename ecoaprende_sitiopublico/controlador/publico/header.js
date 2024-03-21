const HEADER = document.querySelector('header');
HEADER.innerHTML = `

<nav class="navbar navbar-expand-lg bg-body-tertiary">
<style>
  .navbar {
    background-color: rgba(119, 127, 71, 1)
    !important;
  }

  li{
    font-family:'Ropa Sans';
  }
</style> 
<a class="navbar-brand px-4 " type="submit" class="btn" href="/ecoaprende_sitiopublico/vistas/publica/menu.html">
<img src="../../recursos/img/eco.png" alt="eco" width="100">
</a>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
      <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0 mx-auto">
            <li class="nav-item">
              <a class="nav-link active text-white text-start px-5" aria-current="page" href="menu.html"><i
                  class="bi bi-house-door-fill fs-4 px-2"></i>Inicio</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-white px-5" href="opciones_categoria.html" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                <i class="bi bi-box-seam fs-4 px-2"></i>Categorias
              </a>
              <ul class="dropdown-menu ">
                <li><a class="dropdown-item" href="opciones_categoria.html">Tecnologia</a></li>
                <li><a class="dropdown-item" href="opciones_categoria.html">Medicina General</a></li>
                <li><a class="dropdown-item" href="opciones_categoria.html">Ciencia en general</a></li>
                <li><a class="dropdown-item" href="opciones_categoria.html">Autores populares</a></li>
                <li><a class="dropdown-item" href="opciones_categoria.html">Editoriales</a></li>
                <li><a class="dropdown-item" href="opciones_categoria.html">Idiomas</a></li>
              </ul>
            </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li class="nav-item">
              <a class="nav-link text-white px-5" aria-current="page" href="carrito_compra.html"><i
                  class="bi bi-cart-fill px-2 fs-4"></i>Carrito</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white px-5" href="#"><i class="bi bi-person-fill px-2 fs-4"></i>Usuario</a>
            </li>
          </ul>

        </div>
      </div>
    </nav>
  </header>

    
`
