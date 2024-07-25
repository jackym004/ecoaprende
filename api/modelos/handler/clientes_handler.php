<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../../auxiliar/database.php');
/*
 *  Clase para manejar el comportamiento de los datos de la tabla administrador.
 */
class ClientesHandler
{
    /*
     *  Declaración de atributos para el manejo de datos.
     */
    protected $id = null;
    protected $nombre = null;
    protected $correo = null;
    protected $telefono = null;
    protected $dui = null;
    protected $clave = null;

    protected $estado = null;
    /*
     *  Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
     */

    // Función para buscar
    public function searchRows()
    {
        $value = '%' . Validator::getSearchValue() . '%';
        $sql = 'SELECT id_cliente AS ID, nombre_cliente AS NOMBRE, correo_cliente AS CORREO,
        telefono_cliente AS TELEFONO, dui_cliente AS DUI, 
        CASE 
        WHEN estado_cliente = 1 THEN "Activo"
        WHEN estado_cliente = 0 THEN "Bloqueado"
        END AS ESTADO FROM tb_clientes
                WHERE nombre_cliente LIKE ?
                ORDER BY NOMBRE;';
        $params = array($value);
        return Database::getRows($sql, $params);
    }

    // Función para leer todo
    public function createRow()
    {
        $sql = 'INSERT INTO tb_clientes(nombre_cliente, correo_cliente, telefono_cliente, dui_cliente, clave_cliente)
                VALUES(?, ?, ?, ?, ?)';
        $params = array($this->nombre, $this->correo, $this->telefono, $this->dui,  $this->clave);
        return Database::executeRow($sql, $params);
    }

    // Función para leer todo
    public function readAll()
    {
        $sql = 'SELECT id_cliente AS ID, nombre_cliente AS NOMBRE, correo_cliente AS CORREO,
         telefono_cliente AS TELEFONO, dui_cliente AS DUI, 
        CASE 
        WHEN estado_cliente = 1 THEN "Activo"
        WHEN estado_cliente = 0 THEN "Bloqueado"
        END AS ESTADO FROM tb_clientes
                ORDER BY NOMBRE;';
        return Database::getRows($sql);
    }

    // Función para leer uno
    public function readOne()
    {
        $sql = 'SELECT id_cliente AS ID, nombre_cliente AS NOMBRE, correo_cliente AS CORREO,
         telefono_cliente AS TELEFONO, dui_cliente AS DUI, 
        CASE 
        WHEN estado_cliente = 1 THEN "Activo"
        WHEN estado_cliente = 0 THEN "Bloqueado"
        END AS ESTADO FROM tb_clientes
        WHERE id_cliente = ?';
        $params = array($_SESSION['idCliente']);
        return Database::getRows($sql, $params);
    }

    // Función para leer uno
    public function readOneEditProfile()
    {
        $sql = 'SELECT id_cliente AS ID, nombre_cliente AS NOMBRE, correo_cliente AS CORREO,
         telefono_cliente AS TELEFONO, dui_cliente AS DUI, 
        CASE 
        WHEN estado_cliente = 1 THEN "Activo"
        WHEN estado_cliente = 0 THEN "Bloqueado"
        END AS ESTADO FROM tb_clientes
        WHERE id_cliente = ?';
        $params = array($_SESSION['idCliente']);
        return Database::getRow($sql, $params);
    }

    // Función para cambiar el estado de un cliente.
    public function changeState()
    {
        $sql = 'UPDATE tb_clientes SET estado_cliente = NOT estado_cliente WHERE id_cliente = ?;';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    // Función para cambiar la contraseña.
    public function changePassword()
    {
        $sql = 'UPDATE tb_clientes
                SET clave_cliente = ?
                WHERE id_cliente = ?';
        $params = array($this->clave);
        return Database::executeRow($sql, $params);
    }

    public function topUsuarios()
    {
        $this->id = $this->id === null ? 20 :$this->id;
        $sql = 'SELECT id_cliente,CONCAT(nombre_cliente," ", correo_cliente) AS cliente,
        SUM(cantidad_comprada) AS cantidad_comprada
        FROM tb_detalles_pedidos 
        JOIN tb_pedidos USING(id_cliente)
        JOIN tb_detalles_pedidos USING(id_pedido)
        WHERE estado_pedido = "Finalizado"
        GROUP BY id_cliente, nombre_cliente, correo_cliente
        ORDER BY cantidad_comprada DESC
        LIMIT  '.$this->id.';';
        $params = array();
        return Database::getRows($sql, $params);
    }



    public function checkUser($mail, $password)
    {
        $sql = 'SELECT id_cliente, correo_cliente, clave_cliente, estado_cliente
                FROM tb_clientes
                WHERE correo_cliente = ?';
        $params = array($mail);
        $data = Database::getRow($sql, $params);
        if (password_verify($password, $data['clave_cliente'])) {
            $this->id = $data['id_cliente'];
            $this->correo = $data['correo_cliente'];
            $this->estado = $data['estado_cliente'];
            return true;
        } else {
            return false;
        }
    }

    public function checkStatus()
    {
        if ($this->estado) {
            $_SESSION['idCliente'] = $this->id;
            $_SESSION['correoCliente'] = $this->correo;
            return true;
        } else {
            return false;
        }
    }

    public function checkDuplicate($value)
    {
        $sql = 'SELECT id_cliente
                FROM tb_clientes
                WHERE dui_cliente = ? OR correo_cliente = ?';
        $params = array($value, $value);
        return Database::getRow($sql, $params);
    }
    
    public function editProfile()
    {
        $sql = 'UPDATE tb_clientes
                SET nombre_cliente = ?, correo_cliente = ?, telefono_cliente = ?
                WHERE id_cliente = ?';
        $params = array($this->nombre, $this->correo, $this->telefono, $_SESSION['idCliente']);
        return Database::executeRow($sql, $params);
    }



}


