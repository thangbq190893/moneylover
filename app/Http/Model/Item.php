<?php

namespace App\Http\Model;

use Illuminate\Database\Eloquent\Model;

class Item extends Model
{
    protected $table = 'items';
    protected $fillable = ['name', 'category_id'];

    public function iteCategory()
    {
        return $this->belongsTo(Category::class);
    }
}
