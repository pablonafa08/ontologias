const commonOptions = (src) => {
  return `
    <a class="navbar-brand navbar-margin" href="${src}ontologias/propias.jsp">
        <i class="fas fa-database"></i>
        Mis ontologías
    </a>
    <a class="navbar-brand navbar-margin" href="${src}noti.jsp">
        <i class="fas fa-bell"></i>
    </a>`;
};

const userOptions = (src, foto) => {
  return `
    <ul class="navbar-nav mr-auto">
    <li class="nav-item dropdown">
      <a style="color: white;" class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <img src="${
          foto ? `data: image/png;base64,${foto}` : `${src}img/face2.png`
        }" style="width: 2rem; height: 2rem; object-fit: cover;">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
        <a class="dropdown-item" href="${src}perfil.jsp">Ver perfil</a>
        <a class="dropdown-item" href="${src}cambiar.jsp">Cambiar contraseña</a>
        <a class="dropdown-item" href="${src}salir.jsp">Cerrar sesión</a>
      </div>
    </li>
    </ul>
    `;
};

const navBarContent = (src, navBarFormContent) => {
  return `
    <img src="${src}img/uasLogo.png" class="logo" alt="Logo" style="height: 50px; width: 50px;">
    <a class="navbar-brand" href="${src}index.jsp">Ontologías</a>
    <div class="navbar-collapse" style="display: flex !important; flex-basis: auto">
      <ul class="navbar-nav mr-auto">
      </ul>
      <form class="form-inline my-2 my-lg-0">${navBarFormContent}</form>
    </div>`;
};

function loadNavBar(data) {
  $.ajax({
    url: `${data.src}js/archivosBusquedas/navbar.jsp`,
    type: "POST",
    dataType: "html",
  })
    .done(function (respuesta) {
      try {
        const res = JSON.parse(respuesta);

        const adminOptions = `
        <a class="navbar-brand navbar-margin" href="${data.src}categorias/categorias.jsp">
            <i class="fas fa-window-maximize"></i>
            Categorías
        </a>
        <a class="navbar-brand navbar-margin" href="${data.src}categorias/ramas.jsp">
            <i class="fas fa-window-restore"></i>
            Subcategorías
        </a>
        <a class="navbar-brand navbar-margin" href="${data.src}ontologias/todas.jsp">
            <i class="fas fa-database"></i>
            Ontologías
        </a>
        <a class="navbar-brand navbar-margin" href="${data.src}usuarios/usuarios.jsp">
            <i class="fas fa-users"></i>
            Usuarios
        </a>`;

        const navBarFormContent = `${res.isAdmin ? adminOptions : ""}
            ${commonOptions(data.src)}
            ${userOptions(data.src, res.foto)}`;

        $("#navBarContent").html(navBarContent(data.src, navBarFormContent));
      } catch (error) {
        console.error(error);

        const navBarFormContent = `${commonOptions(data.src)}
        ${userOptions(data.src, "")}`;

        $("#navBarContent").html(navBarContent(data.src, navBarFormContent));
      }
    })
    .fail(function (e) {
      console.error(e);

      const navBarFormContent = `${commonOptions(data.src)}
      ${userOptions(data.src, "")}`;

      $("#navBarContent").html(navBarContent(data.src, navBarFormContent));
    });
}
