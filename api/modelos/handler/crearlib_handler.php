<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../../auxiliar/database.php'); 
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
    const RUTA_IMAGEN = '../../imagenes/categoria/';

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

    public function readOnePublic()
    {
        $sql = 'SELECT id_libro,  nombre_libro, descripcion_libro, precio_libro, existencias_libro, imagen_libro, id_categoria, estado_libro
                FROM tb_libros
                WHERE id_libro = ?';
        $params = array($this->id);
        return Database::getRows($sql, $params);
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
        $sql = 'SELECT id_libro, imagen_libro, nombre_libro, descripcion_libro, precio_libro, existencias_libro, 
        CASE 
                WHEN estado_libro = 1 THEN "Disponible"
                WHEN estado_libro = 0 THEN "No disponible"
                END AS "estado_libro"
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                WHERE id_categoria = ? AND estado_libro = true
                ORDER BY nombre_libro';
        $params = array($this->categoria);
        return Database::getRows($sql, $params);
    }

    /*
    *   Métodos para generar gráficos.
    
*/

    public function cantidadLibrosCategoria()
    {
        $sql = 'SELECT nombre_categoria, COUNT(id_libro) cantidad
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                GROUP BY nombre_categoria ORDER BY cantidad DESC LIMIT 5';
        return Database::getRows($sql);
    }

    public function ventaLibrosCategoria()
    {
        $sql = 'SELECT nombre_categoria, COUNT(id_libro) cantidad
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                GROUP BY nombre_categoria ORDER BY cantidad DESC LIMIT 5';
        return Database::getRows($sql);
    }

    
    /*
    *   Métodos para generar gráficos.
    

    public function PrediccionProximosMeses()
    {
        $sql = 'WITH VentasUltimosMeses AS (
                SELECT
                    DATE_FORMAT(p.fecha_registro, "%Y-%m") AS mes,
                    SUM(dp.cantidad_producto * dp.precio_producto) AS monto_ventas
                FROM
                    detalle_pedido dp
                INNER JOIN
                    pedido p ON dp.id_pedido = p.id_pedido
                WHERE
                    p.fecha_registro BETWEEN DATE_SUB(CURDATE(), INTERVAL 5 MONTH) AND CURDATE()
                GROUP BY
                    DATE_FORMAT(p.fecha_registro, "%Y-%m")
                ORDER BY
                    DATE_FORMAT(p.fecha_registro, "%Y-%m")
            ),
            IncrementoPromedio AS (
                SELECT
                    AVG(incremento) AS promedio_incremento
                FROM (
                    SELECT
                        monto_ventas - LAG(monto_ventas) OVER (ORDER BY mes) AS incremento
                    FROM
                        VentasUltimosMeses
                ) AS subconsulta
            )
            SELECT
                DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL seq MONTH), "%Y-%m") AS mes_proyeccion,
                CONCAT(
                    DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL seq MONTH), "%M"), " ",
                    DATE_FORMAT(DATE_ADD(CURDATE(), INTERVAL seq MONTH), "%Y")
                ) AS nombre_mes_proyeccion,
                ROUND(
                    (SELECT monto_ventas
                     FROM VentasUltimosMeses
                     ORDER BY mes DESC
                     LIMIT 1
                    ) * POW(1 + (IFNULL(promedio_incremento, 0) / 100), seq)
                    , 2
                ) AS proyeccion_ventas
            FROM
                (SELECT 1 AS seq UNION ALL
                 SELECT 2 UNION ALL
                 SELECT 3 UNION ALL
                 SELECT 4 UNION ALL
                 SELECT 5 UNION ALL
                 SELECT 6 -- Se añade el sexto mes para proyectar 6 meses
                ) AS secuencia
            CROSS JOIN
                IncrementoPromedio
            ORDER BY
                mes_proyeccion;
            ';

        return Database::getRows($sql);
    }

*/

    public function porcentajeLibrosCategoria()
    {
        $sql = 'SELECT nombre_categoria, ROUND((COUNT(id_libro) * 100.0 / (SELECT COUNT(id_libro) FROM tb_libros)), 2) porcentaje
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                GROUP BY nombre_categoria ORDER BY porcentaje DESC';
        return Database::getRows($sql);
    }


 /*Métodos para generar reportes.*/
    
    public function librosCategoria()
    {
        $sql = 'SELECT nombre_libro, precio_libro, estado_libro
                FROM tb_libros
                INNER JOIN tb_categorias USING(id_categoria)
                WHERE id_categoria = ?
                ORDER BY nombre_libro';
        $params = array($this->categoria);
        return Database::getRows($sql, $params);
    }
}
