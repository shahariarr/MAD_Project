<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Medicine extends Model
{
    protected $fillable = [
        'name',
        'pieces',
        'description',
        'start_date',
        'end_date',
        'user_id'
    ];

    public function timers()
    {
        return $this->hasMany(MedicineTimer::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
