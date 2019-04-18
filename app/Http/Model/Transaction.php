<?php

namespace App\Http\Model;

use App\Helper\Item\ItemHelper;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    protected $appends = ['walletname', 'item', 'currency_name', 'category_id'];
    protected $visible = ['id', 'category_id', 'wallet_id', 'cost', 'walletname', 'date', 'item', 'item_id', 'currency_name', 'event', 'note', 'with_people'];
    protected $table = 'transactions';
    protected $fillable = ['wallet_id', 'cost', 'date', 'item_id', 'event'];

    public function traWallet()
    {
        return $this->belongsTo(Wallet::class, 'wallet_id');
    }

    public function traItem()
    {
        return $this->belongsTo(Item::class, 'item_id');
    }

    public function getItemAttribute()
    {
        return ItemHelper::getItemName($this->item_id);
    }

    public function getWalletNameAttribute()
    {
        $wallet_name = Wallet::where('id', $this->wallet_id)->first();
        return $wallet_name->name;
    }

    public function getCurrencyNameAttribute()
    {
        $currency_id = Wallet::where('id', $this->wallet_id)->first()->curency_id;
        $currency_name = Currency::where('id', $currency_id)->first()->name;
        return $currency_name;
    }

    public function getCategoryIdAttribute()
    {
        return ItemHelper::getCategoryId($this->item_id);
    }

    public static function searchTrans($value1, $value2)
    {
        $query = Transaction::where(function ($query) use ($value1) {
            $query->where('wallet_id', '=', $value1);
        })->where(function ($query) use ($value2) {
            $query->where('event', 'like', '%' . $value2 . '%')
                ->orwhere('note', 'like', '%' . $value2 . '%')
                ->orwhere('with_people', 'like', '%' . $value2 . '%')
                ->orwhere('cost', 'like', '%' . $value2 . '%')
                ->orwhere('date', 'like', '%' . $value2 . '%')
                ->orwhere('item_id', ItemHelper::getItemId($value2));
        })->get();
        return $query;
    }
}
