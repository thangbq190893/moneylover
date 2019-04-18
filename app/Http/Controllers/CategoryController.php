<?php

namespace App\Http\Controllers;

use App\Http\Model\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{

    public function index()
    {
        $category = Category::all();
        return response()->json($category);
    }

    public function show($id)
    {
        $item = Category::find($id)->catItems;
        return response()->json($item);
    }

}
