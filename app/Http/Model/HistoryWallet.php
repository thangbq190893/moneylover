<?php

namespace App\Http\Model;

use Illuminate\Database\Eloquent\Model;

class HistoryWallet extends Model
{
    protected $table = 'history_wallet';
    protected $fillable = ['wallet_id','old_name','new_name','old_cash','new_cash','date'];
    public $timestamps = false;

    public function wallet(){
        return $this->belongsTo(Wallet::class,'wallet_id');
    }
}
