<?php

namespace App\Http\Model;

use App\Helper\Item\ItemHelper;
use Illuminate\Database\Eloquent\Model;
class Transaction extends Model
{
    protected $appends=['walletname','item','currency_name','category_id'];
    protected $visible=['id','category_id','wallet_id','cost', 'walletname','date','item','currency_name','event','note','with_people'];
    protected $table='transactions';
    protected $fillable=['wallet_id','cost','date'];

    public function wallet(){
        return $this->belongsTo(Wallet::class,'wallet_id');
    }
    public function tr_item(){
        return $this->belongsTo(Item::class,'item_id');
    }
    public function getitemAttribute(){
        $item_id=$this->item_id;
        $item=Item::where('id',$item_id)->first();
        return $item->name;
    }
    public function getwalletnameAttribute(){
        $wallet_id=$this->wallet_id;
        $wallet_name=Wallet::where('id',$wallet_id)->first();
        return $wallet_name->name;
    }
    public function getCurrencyNameAttribute(){
        $wallet_id=$this->wallet_id;
        $currency_id=Wallet::find($wallet_id)->first()->getCurrencyNameAttribute();
        return $currency_id;
    }
    public function getCategoryIdAttribute()
    {
        return ItemHelper::get_categoryid($this->item_id);
    }

}
