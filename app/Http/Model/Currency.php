<?php

namespace App\Http\Model;

use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    protected $table='curencies';
    protected $fillable=['name'];
    public function cu_wallets(){
        return $this->hasMany(Wallet::class);
    }
}
