<?php

namespace App\Http\Controllers;

use App\Helper\Item\ItemHelper;
use App\Http\Model\Transaction;
use App\Http\Requests\TransactionRequest;
use Carbon\Carbon;
use Illuminate\Http\Request;

class TransactionController extends Controller
{

    public function index()
    {
        return response(Transaction::all());
    }

    public function store(TransactionRequest $request)
    {
        $transaction = Transaction::create([
            'wallet_id' => $request->wallet_id,
            'date' => Carbon::now()->toDateString(),
            'cost' => $request->cost,
            'note' => $request->note,
            'item_id' => $request->item_id
        ]);
        return response()->json($transaction);
    }

    public function show($id)
    {
        $transaction = Transaction::findOrFail($id);
        return response()->json($transaction);
    }

    public function edit($id)
    {
        $transaction = Transaction::findOrFail($id);
        return response()->json($transaction);
    }

    public function update(TransactionRequest $request, $id)
    {
        $transaction = Transaction::findOrFail($id);
        $transaction->wallet_id = $request->wallet_id;
        $transaction->date = Carbon::now()->toDateString();
        $transaction->cost = $request->cost;
        $transaction->note = $request->note;
        $transaction->item_id = $request->item_id;
        $transaction->save();
        return response()->json($transaction);
    }

    public function destroy($id)
    {
        Transaction::find($id)->delete();
        return response()->json(['Delete' => 'delete success']);
    }

    public function search(Request $request)
    {
        $search = $request->search;
        $walletid = $request->walletId;
        if (empty($search)) {
            $transactions = Transaction::where('wallet_id', $walletid)->get();
            return response()->json($transactions);
        } else {
            $transactions = Transaction::searchTrans($walletid, $search);
            if (count($transactions) == 0) {
                return \response()->json(404);
            } else {
                return response()->json($transactions);
            }
        }
    }

    public function searchDate(Request $request)
    {
        $firstDate = $request->date1;
        $secondDate = $request->date2;
        $walletid = $request->walletId;
        $trans = Transaction::betweenDate($walletid, $firstDate, $secondDate);
        if (!isset($trans)) {
            return response()->json(404);
        }
        return response()->json($trans);
    }
}
