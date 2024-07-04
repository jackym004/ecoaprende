<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../../auxiliar/database.php');
/*
 *  Clase para manejar el comportamiento de los datos de la tabla administrador.
 */
class ValoracionesHandler
{
    /*
     *  Declaración de atributos para el manejo de datos.
     */
    protected $id = null;
    protected $comentario = null;
    protected $calificacion = null;
    protected $idDetalle = null;

    /*
     *  Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
     */

    // Función para buscar
    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT V.id_valoracion AS ID,
        nombre_cliente AS NOMBRE,
        nombre_libro AS PRODUCTO,
        comentario_producto AS COMENTARIO, 
        fecha_valoracion AS FECHA,
            CASE 
                WHEN estado_comentario = 1 THEN "Activo"
                WHEN estado_comentario = 0 THEN "Bloqueado"
            END AS ESTADO
        FROM tb_valoraciones v
        INNER JOIN tb_detalles_pedidos dp ON dp.id_detalles_pedidos = v.id_detalles_pedidos
        INNER JOIN tb_libros h ON h.id_libro = dp.id_libro
        INNER JOIN tb_pedidos p ON p.id_pedido = dp.id_pedido
        INNER JOIN tb_clientes c ON c.id_cliente = p.id_cliente 
                WHERE nombre_cliente LIKE ?
                ORDER BY NOMBRE;';
        $params = array($value);
        return Database::getRows($sql, $params);
    }

    // Función para crear un comentario
    public function createRow()
    {
        $sql = 'INSERT INTO tb_valoraciones(id_detalles_pedidos,comentario_producto,calificacion_producto,
        fecha_valoracion,estado_comentario) VALUES(?,?,?,now(),false)';
        $params = array($this->idDetalle, $this->comentario, $this->calificacion);
        return Database::executeRow($sql, $params);
    }


    // Función para leer todo
    public function readAll()
    {
        $sql = 'SELECT V.id_valoracion AS ID,
        nombre_cliente AS NOMBRE,
        nombre_libro AS PRODUCTO,
        comentario_producto AS COMENTARIO, 
        fecha_valoracion AS FECHA,
            CASE 
                WHEN estado_comentario = 1 THEN "Activo"
                WHEN estado_comentario = 0 THEN "Bloqueado"
            END AS ESTADO
        FROM tb_valoraciones v
        INNER JOIN tb_detalles_pedidos dp ON dp.id_detalles_pedidos = v.id_detalles_pedidos
        INNER JOIN tb_libros h ON h.id_libro = dp.id_libro
        INNER JOIN tb_pedidos p ON p.id_pedido = dp.id_pedido
        INNER JOIN tb_clientes c ON c.id_cliente = p.id_cliente;      
                ORDER BY NOMBRE;';
        return Database::getRows($sql);
    }


    //Función para cambiar el estado de un cliente.
    public function changeState()
    {
        $sql = 'CALL cambiar_estado_valoracion(?);';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
