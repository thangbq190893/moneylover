<?php

namespace App\Http\Controllers;

use App\Http\Model\HistoryWallet;
use App\Http\Model\Wallet;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Validator;

class WalletController extends Controller
{

    public function index()
    {
       $user = Auth::user();
       $wallet = Wallet::where('user_id',$user->id)->get();
       return response()->json($wallet);
    }


    public function create()
    {
        //
    }


    public function store(Request $request)
    {
        $user = Auth::user();
        $wallet= new Wallet();
        $validation=Validator::make($request->all(),[
            'name'=>'required',
            'cash'=>'required',
            'curency_id'=>'required'
        ]);
        if($validation->fails()){
            $errors = $validation->errors();

            return $errors->toJson();
        }else{
            $wallet->name= $request->name;
            $wallet->cash=$request->cash;
            $wallet->user_id= $user->id;
            $wallet->curency_id= $request->curency_id;
            $wallet->save();
            $wl= Wallet::where('name',$request->name)->first();
            return response()->json($wl);
        }
    }
    public function show($id)
    {
        $transactions=Wallet::find($id)
            ->wa_transactions()->get();
        return response()->json($transactions);
    }
    public function edit($id)
    {
        $wallet= Wallet::findOrFail($id);
        return response()->json($wallet);

    }
    public function update(Request $request, $id)
    {
        $user_id=Auth::user()->id;
        $wallet =Wallet::findOrFail($id);
        $validation=Validator::make($request->all(),[
            "name"=>'required',
            "cash"=>'required'
        ]);
        if($validation->fails()){
            $errors = $validation->errors();

            return $errors->toJson();
        }else{
//            Create history change
            $history=new HistoryWallet();
            $history->wallet_id= $id;
            $history->old_name=$wallet->name;
            $history->new_name=$request->name;
            $history->old_cash= $wallet->cash;
            $history->new_cash =$request->cash;
            $history->date = Carbon::now();
            $history->save();
//            Add wallet
            $wallet->name=$request->name;
            $wallet->cash=$request->cash;
            $wallet->user_id=$user_id;
            $wallet->save();
            return response()->json($wallet);
        }

    }
    public function destroy($id)
    {
        Wallet::findOrFail($id)->delete();
        return response()->json(["deleted"=>"delete success"]);
    }
}
