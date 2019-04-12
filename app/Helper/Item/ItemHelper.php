<?php

namespace App\Helper\Item;

use App\Http\Model\Currency;
use App\Http\Model\Item;

class ItemHelper
{
    public static function get_itemname($item_name)
    {
        $item = Item::where('name', $item_name)->first();
        return (isset($item->id) ? $item->id : null);
    }
    public static function get_currencyname($id)
    {
        $item = Currency::where('id', $id)->first();
        return (isset($item->name) ? $item->name : null);
    }
}
