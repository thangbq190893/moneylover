<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
Route::post('login', 'API\UserController@login');
Route::post('register', 'API\UserController@register');


Route::group(['middleware' => 'auth:api'], function () {
    Route::get('profile', 'API\UserController@details');
    Route::get('wallet', 'WalletController@index');
    Route::post('wallet', 'WalletController@store');
    Route::get('wallet/{id}', 'WalletController@edit');
    Route::patch('wallet/{id}', 'WalletController@update');
    Route::delete('wallet/{id}', 'WalletController@destroy');
    Route::get('wallet/{id}/transactions', 'WalletController@getTransaction');
    Route::post('transaction', 'TransactionController@store');
    Route::get('transaction/{id}', 'TransactionController@edit');
    Route::patch('transaction/{id}', 'TransactionController@update');
    Route::delete('transaction/{id}', 'TransactionController@destroy');
    Route::post('searchTransaction', 'TransactionController@search');
    Route::post('uploadImg', 'API\UserController@uploadImg');
    //Please do not remove this if you want adminlte:route and adminlte:link commands to works correctly.
    #adminlte_api_routes
});
Route::resource('item', 'ItemController');
Route::get('category', 'CategoryController@index');
Route::get('category/{id}', 'CategoryController@show');
Route::get('currency', 'CurrencyController@index');

Route::group([
    'namespace' => 'Auth',
    'middleware' => 'api',
    'prefix' => 'password'
], function () {
    Route::post('create', 'PasswordResetController@create');
    Route::get('find/{token}', 'PasswordResetController@find');
    Route::post('reset', 'PasswordResetController@reset');
});



