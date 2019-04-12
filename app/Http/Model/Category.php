<?php

namespace App\Http\Model;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $table = 'categories';
    protected $fillable = ['name'];

    public function ca_transactions(){
        return $this->hasMany(Transaction::class);
    }
    public function items(){
        return $this->hasMany(Item::class,'category_id');
    }
}
