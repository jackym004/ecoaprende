const HEADER = document.querySelector('header');
HEADER.innerHTML = `

<nav class="navbar navbar-expand-lg bg-body-tertiary">
<a class="navbar-brand px-4" type="submit" class="btn" href="">
<img src="/ecoaprende_sitiopublico/recursos/img/eco.png" alt="eco" width="100">
</a>
      <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav me-auto mb-2 mb-lg-0 mx-auto">
            <li class="nav-item">
              <a class="nav-link active text-white text-start px-5" aria-current="page" href="#"><i
                  class="bi bi-house-door-fill fs-4 px-2"></i>Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link text-white px-5" href="#"><i class="bi bi-shop fs-4 px-2"></i>Tienda</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-white px-5" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                <i class="bi bi-box-seam fs-4 px-2"></i>Categorias
              </a>
              <ul class="dropdown-menu ">
                <li><a class="dropdown-item" href="#">1</a></li>
                <li><a class="dropdown-item" href="#">2</a></li>
                <li><a class="dropdown-item" href="#">3</a></li>
              </ul>
            </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li class="nav-item">
              <a class="nav-link text-white px-5" aria-current="page" href="#"><i
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
