<?php

namespace App\Http\Controllers;

use App\Http\Model\Item;
use Illuminate\Http\Request;

class ItemController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $item=Item::all();
        return response()->json($item);
    }

}
