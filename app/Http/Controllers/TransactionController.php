<?php

namespace App\Http\Controllers;

use App\Helper\Item\ItemHelper;
use App\Http\Model\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Validator;

class TransactionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response(Transaction::all());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $transaction = new Transaction();
        $validation = Validator::make($request->all(), [
            'cost' => 'required',
            'item_id' => 'required'
        ]);
        if ($validation->fails()) {
            $errors = $validation->errors();

            return $errors->toJson();
        } else {
            $transaction->wallet_id = $request->wallet_id;
            $transaction->event = $request->event;
            $transaction->date = Carbon::now()->toDateString();
            $transaction->cost = $request->cost;
            $transaction->note = $request->note;
            $transaction->with_people = $request->with_people;
            $transaction->item_id = $request->item_id;
            $transaction->save();
            return response()->json($transaction);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Transaction $transaction
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $transaction = Transaction::findOrFail($id);
        return response()->json($transaction);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Transaction $transaction
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $transaction = Transaction::findOrFail($id);
        return response()->json($transaction);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request $request
     * @param  \App\Transaction $transaction
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $transaction = Transaction::findOrFail($id);
        $validation = Validator::make($request->all(), [
            'item_id' => 'required',
            'cost' => 'required'
        ]);
        if ($validation->fails()) {
            $errors = $validation->errors();

            return $errors->toJson();
        } else {
            $transaction->wallet_id = $request->wallet_id;
            $transaction->event = $request->event;
            $transaction->date = Carbon::now()->toDateString();
            $transaction->cost = $request->cost;
            $transaction->note = $request->note;
            $transaction->with_people = $request->with_people;
            $transaction->item_id = $request->item_id;
            $transaction->save();
            return response()->json($transaction);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Transaction $transaction
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Transaction::find($id)->delete();
        return response()->json(['Delete'=>'delete success']);
    }

    public function search(Request $request)
    {
        $search = $request->search;
        $walletid = $request->walletId;
        if (empty($search)) {
            $transactions=Transaction::where('wallet_id',$walletid)->get();
            return response()->json($transactions);
        }else{
            $transactions = Transaction::where(function ($query) use ($walletid) {
                $query->where('wallet_id', '=', $walletid);
            })->where(function ($query) use ($search) {
                $query
//                ->where('id','like', '%'.$search.'%')
                    ->where('event','like', '%'.$search.'%')
                    ->orwhere('note','like', '%'.$search.'%')
                    ->orwhere('with_people','like', '%'.$search.'%')
                    ->orwhere('cost','like', '%'.$search.'%')
                    ->orwhere('date','like', '%'.$search.'%')
                    ->orwhere('item_id',ItemHelper::get_itemname($search));
            })->get();
            if (count($transactions) == 0) {
                return \response()->json([['event' => 'Không tìm được kết quả phù hợp cho : ' . $search]]);
            } else {
                return response()->json($transactions);
            }
        }
    }
}
