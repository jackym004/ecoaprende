const HEADERLG = document.querySelector('header');
HEADERLG.innerHTML = `

<nav class="navbar">
  <div class="container">
    
  </div>
</nav>
<nav class="navbar sticky-top navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
  <img src="../../recursos/img/lg.png" alt="lg" width="100" height="55"  >
  </a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item  ">
        </li>
        <li class="nav-item  ">
        </li>
      </ul>
      <span class="navbar-text me-5">
      <a class="nav-link justify-content-end ms-auto active no" aria-current="page">¿No tienes cuenta aun?</a>
      </span>
      <span class="navbar-text me-4">
      <a type="button justify-content-end" href="../../vistas/publica/Registro.html" class="btn regist text-white">Inicia aqui</a>
      </span>
    </div>
  </div>
</nav>
<!-- contralador de el header -->
<style>
  .navbar {
    background-color: rgba(119, 127, 71, 1) !important;
      width: 100%;
  }
  li {
    font-family: 'Ropa Sans';
  }
  .custom-color{
      color: rgba(119, 127, 71, 1) !important;
  }
  .regist{
    background-color: rgba(39, 59, 9, 1);
    color: white;
    width:150px
  }
  .navbar-nav{
    text-align: rigth;
  }
  .no{
    font-weigth:bold;
  }
</style>

    
`
