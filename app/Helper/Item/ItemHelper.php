<?php

namespace App\Helper\Item;

use App\Http\Model\Category;
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
        $currency = Currency::where('id', $id)->first();
        return (isset($currency->name) ? $currency->name : null);
    }
    public static function get_categoryid($id)
    {
        $item = Item::where('id', $id)->first();
        return (isset($item->category_id) ? $item->category_id : null);
    }
}
