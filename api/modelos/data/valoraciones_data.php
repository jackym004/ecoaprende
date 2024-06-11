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
 
    public function setIdDetalle($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->idDetalle = $value;
            return true;
        } else {
            $this->data_error = 'El identificador de detalles pedidos es incorrecto';
            return false;
        }
    }

    public function setCalificacion($value)
    {
        if (Validator::validateNaturalNumber($value)) {
            $this->puntuacion = $value;
            return true;
        } else {
            $this->data_error = 'El número de la calificacion tiene que ser un numero natural';
            return false;
        }
    }

    public function setComentario($value, $min = 4, $max = 250)
    {
        if (!Validator::validateString($value)) {
            $this->data_error = 'El mensaje contiene caracteres prohibidos.';
            return false;
        } elseif (Validator::validateLength($value, $min, $max)) {
            $this->mensaje = $value;
            return true;
        } else {
            $this->data_error = 'El mensaje debe tener una longitud entre ' . $min . ' y ' . $max;
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