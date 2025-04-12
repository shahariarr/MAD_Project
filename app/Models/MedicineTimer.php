<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MedicineTimer extends Model
{
    protected $fillable = [
        'medicine_id',
        'label',
        'time'
    ];

    public function medicine()
    {
        return $this->belongsTo(Medicine::class);
    }
}
