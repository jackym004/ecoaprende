<?php
// Se incluye la clase del modelo.
require_once('../modelos/data/libro_data.php');

// Se comprueba si existe una acción a realizar, de lo contrario se finaliza el script con un mensaje de error.
if (isset($_GET['action'])) {
    // Se crea una sesión o se reanuda la actual para poder utilizar variables de sesión en el script.
    session_start();
    // Se instancia la clase correspondiente.
    $libro = new LibroData;
    // Se declara e inicializa un arreglo para guardar el resultado que retorna la API.
    $result = array('status' => 0, 'message' => null, 'dataset' => null, 'error' => null, 'exception' => null, 'fileStatus' => null);
    // Se verifica si existe una sesión iniciada como administrador, de lo contrario se finaliza el script con un mensaje de error.
    if (isset($_SESSION['idAdministrador'])) {
        // Se compara la acción a realizar cuando un administrador ha iniciado sesión.
        switch ($_GET['action']) {
            case 'searchRows':
                if (!Validator::validateSearch($_POST['search'])) {
                    $result['error'] = Validator::getSearchError();
                } elseif ($result['dataset'] = $libro->searchRows()) {
                    $result['status'] = 1;
                    $result['message'] = 'Existen ' . count($result['dataset']) . ' coincidencias';
                } else {
                    $result['error'] = 'No hay coincidencias';
                }
                break;
            case 'createRow':
                $_POST = Validator::validateForm($_POST);
                if (
                    !$libro->setNombre($_POST['nombreLibro']) or
                    !$libro->setDescripcion($_POST['descripcionLibro']) or
                    !$libro->setPrecio($_POST['precioLibro']) or
                    !$libro->setExistencias($_POST['existenciasLibro']) or
                    !$libro->setCategoria($_POST['categoriaLibro']) or
                    !$libro->setEstado(isset($_POST['estadoLibro']) ? 1 : 0) or
                    !$libro->setImagen($_FILES['imagenLibro'])
                ) {
                    $result['error'] = $libro->getDataError();
                } elseif ($libro->createRow()) {
                    $result['status'] = 1;
                    $result['message'] = 'Producto creado correctamente';
                    // Se asigna el estado del archivo después de insertar.
                    $result['fileStatus'] = Validator::saveFile($_FILES['imagenLibro'], $libro::RUTA_IMAGEN);
                } else {
                    $result['error'] = 'Ocurrió un problema al crear el producto';
                }
                break;
            case 'readAll':
                if ($result['dataset'] = $libro->readAll()) {
                    $result['status'] = 1;
                    $result['message'] = 'Existen ' . count($result['dataset']) . ' registros';
                } else {
                    $result['error'] = 'No existen libros registrados';
                }
                break;
            case 'readOne':
                if (!$libro->setId($_POST['idLibro'])) {
                    $result['error'] = $libro->getDataError();
                } elseif ($result['dataset'] = $libro->readOne()) {
                    $result['status'] = 1;
                } else {
                    $result['error'] = 'libro inexistente';
                }
                break;
            case 'updateRow':
                $_POST = Validator::validateForm($_POST);
                if (
                    !$libro->setId($_POST['idLibro']) or
                    !$libro->setFilename() or
                    !$libro->setNombre($_POST['nombreLibro']) or
                    !$libro->setDescripcion($_POST['descripcionLibro']) or
                    !$libro->setPrecio($_POST['precioLibro']) or
                    !$libro->setCategoria($_POST['categoriaLibro']) or
                    !$libro->setEstado(isset($_POST['estadoLibro']) ? 1 : 0) or
                    !$libro->setImagen($_FILES['imagenLibro'], $libro->getFilename())
                ) {
                    $result['error'] = $libro->getDataError();
                } elseif ($libro->updateRow()) {
                    $result['status'] = 1;
                    $result['message'] = 'libro modificado correctamente';
                    // Se asigna el estado del archivo después de actualizar.
                    $result['fileStatus'] = Validator::changeFile($_FILES['imagenLibro'], $libro::RUTA_IMAGEN, $libro->getFilename());
                } else {
                    $result['error'] = 'Ocurrió un problema al modificar el libro';
                }
                break;
            case 'deleteRow':
                if (
                    !$libro->setId($_POST['idLibro']) or
                    !$libro->setFilename()
                ) {
                    $result['error'] = $libro->getDataError();
                } elseif ($libro->deleteRow()) {
                    $result['status'] = 1;
                    $result['message'] = 'libro eliminado correctamente';
                    // Se asigna el estado del archivo después de eliminar.
                    $result['fileStatus'] = Validator::deleteFile($libro::RUTA_IMAGEN, $libro->getFilename());
                } else {
                    $result['error'] = 'Ocurrió un problema al eliminar el libro';
                }
                break;
            case 'cantidadLibrosCategoria':
                if ($result['dataset'] = $libro->cantidadLibrosCategoria()) {
                    $result['status'] = 1;
                } else {
                    $result['error'] = 'No hay datos disponibles';
                }
                break;
            case 'porcentajeLibrosCategoria':
                if ($result['dataset'] = $libro->porcentajeLibrosCategoria()) {
                    $result['status'] = 1;
                } else {
                    $result['error'] = 'No hay datos disponibles';
                }
                break;
            default:
                $result['error'] = 'Acción no disponible dentro de la sesión';
        }
        // Se obtiene la excepción del servidor de base de datos por si ocurrió un problema.
        $result['exception'] = Database::getException();
        // Se indica el tipo de contenido a mostrar y su respectivo conjunto de caracteres.
        header('Content-type: application/json; charset=utf-8');
        // Se imprime el resultado en formato JSON y se retorna al controlador.
        print(json_encode($result));
    } else {
        print(json_encode('Acceso denegado'));
    }
} else {
    print(json_encode('Recurso no disponible'));
}

