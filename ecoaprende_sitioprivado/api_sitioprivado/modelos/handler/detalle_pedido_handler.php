<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../auxiliar/database.php');
/*
 *  Clase para manejar el comportamiento de los datos de la tabla administrador.
 */
class DetallesPedidosHandler
{
    /*
     *  Declaración de atributos para el manejo de datos.
     */
    protected $id = null;

    /*
     *  Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
     */
   //Leer
    public function readOne()
    {
        $sql = 'SELECT * FROM tb_detalles_pedidos dp INNER JOIN tb_libros l ON dp.id_libro = l.id_libro 
        WHERE id_pedido = ?
        ORDER BY nombre_libro;';
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }
}
