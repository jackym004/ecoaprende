<?php
// Se incluye la clase para validar los datos de entrada.
require_once('../../auxiliar/validator.php'); 
// Se incluye la clase padre.
require_once('../../modelos/handler/pedidos_handler.php');
/*
 *  Clase para manejar el encapsulamiento de los datos de la tabla USUARIO.
 */
class PedidosData extends PedidosHandler
{
    // Atributo genérico para manejo de errores.

    private $data_error = null;
    private $filename = null;
     /*
     *  Métodos para validar y asignar valores de los atributos.
     */
    public function setId($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            $this->data_error = 'El identificador del pedido es incorrecto';
            return false;
        }
    }

    public function setEstado($value, $min = 2, $max = 50)
    {
        if (!Validator::validateAlphabetic($value)) {
            $this->data_error = 'El nombre debe ser un valor alfabético';
            return false;
        } elseif (Validator::validateLength($value, $min, $max)) {
            $this->estado = $value;
            return true;
        } else {
            $this->data_error = 'El nombre debe tener una longitud entre ' . $min . ' y ' . $max;
            return false;
        }
    }
    
    // Método para obtener el error de los datos.
    public function getDataError()
    {
        return $this->data_error;
    }
    
}