<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../auxiliar/database.php'); 
/*
*	Clase para manejar el comportamiento de los datos de la tabla PRODUCTO.
*/
class LibroHandler
{
    /*
    *   Declaración de atributos para el manejo de datos.
    */
    protected $id = null;
    protected $nombre = null;
    protected $descripcion = null;
    protected $precio = null;
    protected $existencias = null;
    protected $imagen = null;
    protected $categoria = null;
    protected $estado = null;

    // Constante para establecer la ruta de las imágenes.
    const RUTA_IMAGEN = '../imagenes/categoria/';

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
    */
    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT id_libro, imagen_libro, nombre_libro, descripcion_libro, precio_libro, nombre_categoria, estado_libro
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                WHERE nombre_libro LIKE ? OR descripcion_libro LIKE ?
                ORDER BY nombre_libro';
        $params = array($value, $value);
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_libros(nombre_libro, descripcion_libro, precio_libro, existencias_libro, imagen_libro, estado_libro, id_categoria, id_administrador)
                VALUES(?, ?, ?, ?, ?, ?, ?, ?)';
        $params = array($this->nombre, $this->descripcion, $this->precio, $this->existencias, $this->imagen, $this->estado, $this->categoria, $_SESSION['idAdministrador']);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT id_libro, imagen_libro, nombre_libro, descripcion_libro, precio_libro, nombre_categoria, estado_libro
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                ORDER BY nombre_libro';
        return Database::getRows($sql);
    }

    public function readOne()
    {
        $sql = 'SELECT id_libro,  nombre_libro, descripcion_libro, precio_libro, existencias_libro, imagen_libro, id_categoria, estado_libro
                FROM tb_libros
                WHERE id_libro = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function readFilename()
    {
        $sql = 'SELECT imagen_libro
                FROM tb_libros
                WHERE id_libro = ?';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_libros
                SET imagen_libro = ?, nombre_libro = ?, descripcion_libro = ?, precio_libro = ?, estado_libro = ?, id_categoria = ?
                WHERE id_libro = ?';
        $params = array($this->imagen, $this->nombre, $this->descripcion, $this->precio, $this->estado, $this->categoria, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_libros
                WHERE id_libro = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    public function readLibrosCategoria()
    {
        $sql = 'SELECT id_libro, imagen_libro, nombre_libro, descripcion_libro, precio_libro, existencias_libro
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                WHERE id_categoria = ? AND estado_libro = true
                ORDER BY nombre_libro';
        $params = array($this->categoria);
        return Database::getRows($sql, $params);
    }

    /*
    *   Métodos para generar gráficos.
    


    public function cantidadLibrosCategoria()
    {
        $sql = 'SELECT nombre_categoria, COUNT(id_producto) cantidad
                FROM producto
                INNER JOIN categoria USING(id_categoria)
                GROUP BY nombre_categoria ORDER BY cantidad DESC LIMIT 5';
        return Database::getRows($sql);
    }

    public function porcentajeProductosCategoria()
    {
        $sql = 'SELECT nombre_categoria, ROUND((COUNT(id_producto) * 100.0 / (SELECT COUNT(id_producto) FROM producto)), 2) porcentaje
                FROM producto
                INNER JOIN categoria USING(id_categoria)
                GROUP BY nombre_categoria ORDER BY porcentaje DESC';
        return Database::getRows($sql);
    }
*/
    /*
    *   Métodos para generar reportes.
    
    public function productosCategoria()
    {
        $sql = 'SELECT nombre_producto, precio_producto, estado_producto
                FROM producto
                INNER JOIN categoria USING(id_categoria)
                WHERE id_categoria = ?
                ORDER BY nombre_producto';
        $params = array($this->categoria);
        return Database::getRows($sql, $params);
    }
    */
}
