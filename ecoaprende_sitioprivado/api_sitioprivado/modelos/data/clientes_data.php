<?php
// Se incluye la clase para validar los datos de entrada.
require_once('../auxiliar/validator.php');
// Se incluye la clase padre.
require_once('../modelos/handler/clientes_handler.php');
/*
 *  Clase para manejar el encapsulamiento de los datos de la tabla USUARIO.
 */
class ClientesData extends ClientesHandler
{
    // Atributo genérico para manejo de errores.

    private $data_error = null;
     /*
     *  Métodos para validar y asignar valores de los atributos.
     */
    public function setId($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            $this->data_error = 'El identificador del cliente es incorrecto';
            return false;
        }
    }

    // Método para obtener el error de los datos.
    public function getDataError()
    {
        return $this->data_error;
    }

}