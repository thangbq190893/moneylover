<?php

namespace App\Helper\Item;

use App\Http\Model\Category;
use App\Http\Model\Currency;
use App\Http\Model\Item;

class ItemHelper
{
    public static function getItemId($name)
    {
        $item = Item::where('name', $name)->first();
        return (isset($item->id) ? $item->id : null);
    }

    public static function getItemName($id)
    {
        $item = Item::where('id', $id)->first();
        return (isset($item->name) ? $item->name : null);
    }

    public static function getCurrencyName($id)
    {
        $currency = Currency::where('id', $id)->first();
        return (isset($currency->name) ? $currency->name : null);
    }

    public static function getCategoryId($id)
    {
        $item = Item::where('id', $id)->first();
        return (isset($item->category_id) ? $item->category_id : null);
    }
}
