<?php
// Se incluye la clase para validar los datos de entrada.
require_once('../../auxiliar/validator.php');
// Se incluye la clase padre.
require_once('../../modelos/handler/valoraciones_handler.php');
/*
 *  Clase para manejar el encapsulamiento de los datos de la tabla USUARIO.
 */
class ValoracionesData extends ValoracionesHandler
{
    // Atributo genérico para manejo de errores.
    private $data_error = null;
    private $filename = null;
 
    public function setId($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->id = $value;
            return true;
        } else {
            $this->data_error = 'El identificador del comentario es incorrecto';
            return false;
        }
    }
 
    public function setEstado($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->estado = $value;
            return true;
        } else {
            return false;
        }
    }
 
    // Método para obtener el error de los datos.
    public function getDataError()
    {
        return $this->data_error;
    }
 
    public function getFilename()
    {
        return $this->filename;
    }
}