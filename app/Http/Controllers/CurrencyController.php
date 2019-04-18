<?php

namespace App\Http\Controllers;

use App\Http\Model\Currency;
use Illuminate\Http\Request;

class CurrencyController extends Controller
{


    public function index()
    {
        $currency = Currency::all();
        return response()->json($currency);
    }

    public function store(Request $request)
    {
        $currency = new Currency();
        $currency->name = $request->name;
        $currency->save();
        return response()->json($currency);
    }

}
