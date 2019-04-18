<?php

namespace App\Http\Controllers;

use App\Http\Model\HistoryWallet;
use App\Http\Model\Wallet;
use App\Http\Requests\WalletRequest;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class WalletController extends Controller
{

    public function index()
    {
        $user = Auth::user();
        $wallet = Wallet::where('user_id', $user->id)->get();
        return response()->json($wallet);
    }

    public function store(WalletRequest $request)
    {
        $user = Auth::user();
        $wallet = Wallet::create([
            'name' => $request->name,
            'cash' => $request->cash,
            'user_id' => $user->id,
            'curency_id' => $request->curency_id
        ]);
        return response()->json($wallet);
    }

    public function getTransaction($id)
    {
        $transactions = Wallet::find($id)
            ->walTransactions()->get();
        return response()->json($transactions);
    }

    public function edit($id)
    {
        $wallet = Wallet::findOrFail($id);
        return response()->json($wallet);
    }

    public function update(WalletRequest $request, $id)
    {
        $user_id = Auth::user()->id;
        $wallet = Wallet::findOrFail($id);
//            Create history change
        HistoryWallet::create([
            'wallet_id' => $id,
            'old_name' => $wallet->name,
            'new_name' => $request->name,
            'old_cash' => $wallet->cash,
            'new_cash' => $request->cash,
            'date' => Carbon::now()->toDateString()
        ]);
//            Update wallet
        $wallet->name = $request->name;
        $wallet->cash = $request->cash;
        $wallet->user_id = $user_id;
        $wallet->save();
        return response()->json($wallet);
    }

    public function destroy($id)
    {
        Wallet::findOrFail($id)->delete();
        return response()->json(["deleted" => "delete success"]);
    }
}
