<?php

namespace App\Http\Model;

use App\Helper\Item\ItemHelper;
use Illuminate\Database\Eloquent\Model;

class Wallet extends Model
{
    protected $appends=['user_name','currency_name','pay','currency_name'];
    protected $table='wallets';
    protected $fillable=['name','cash','user_id','curency_id'];
    protected $visible=['id','name','cash','user_id','UserName','curency_id','currency_name','pay','currency_name'];
    public function users(){
        return $this->belongsTo(User::class,'user_id','id');
    }
    public function wa_transactions(){
        return $this->hasMany(Transaction::class);
    }
    public function currency(){
        return $this->belongsTo(Currency::class,'curency_id');
    }
    public function getUserNameAttribute(){
        $user_id=$this->user_id;
        $user_name=User::find($user_id)->first()->name;
        return $user_name;
    }
    public function getCurrencyNameAttribute(){
        $currency_id=$this->curency_id;
        $currency_name= ItemHelper::get_currencyname($currency_id);
        return $currency_name;
    }
    public function getPayAttribute(){
        $wallet_id=$this->id;
        $wallet_cash=$this->cash;
        $cost_add=0;
        $cost_sub=0;
        $transaction=Transaction::where('wallet_id',$wallet_id)->get();
        foreach ($transaction as $transac){
            $item_id=$transac->item_id;
            $category_id=Item::where('id',$item_id)->first()->category_id;
            if ($category_id==1){
                $cost_add=$cost_add+$transac->cost;
            }else if ($category_id==3){
                $cost_add=$cost_add+$transac->cost;
            }else if ($category_id==2){
                $cost_sub=$cost_sub+$transac->cost;
            }
        }
        $wallet_pay=$wallet_cash-$cost_sub+$cost_add;
        return $wallet_pay;
    }


}
