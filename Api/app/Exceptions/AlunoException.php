<?php

namespace App\Exceptions;

use Exception;

class AlunoException extends Exception
{
    protected $message = 'Error';
    public function render()
    {
        return response()->json([
            'error' => class_basename($this),
            'message' => $this->message,
        ], 401);
    }
}
