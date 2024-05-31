const HEADERLG = document.querySelector('header');
HEADERLG.innerHTML = `

<nav class="navbar">
  <div class="container">
    
  </div>
</nav>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
  <img src="/ecoaprende_sitiopublico/recursos/img/lg.png" alt="lg" width="100" height="55"  >
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
      <button type="button justify-content-end " class="btn regist">Inicia aqui</button>
      </span>
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
  .regist{
    background-color: rgba(39, 59, 9, 1);
    color: white;
    width:150px
  }
  .navbar-nav{
    text-align: rigth;
    justify-contend:end;
  }
  .no{
    font-weigth:bold;
  }
</style>

    
`
