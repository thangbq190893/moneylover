<?php

namespace App\Http\Model;

use Illuminate\Database\Eloquent\Model;

class HistoryWallet extends Model
{
    protected $table = 'history_wallet';
    public $timestamps = false;

    public function wallet(){
        return $this->belongsTo(Wallet::class,'wallet_id');
    }
}
