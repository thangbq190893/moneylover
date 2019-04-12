<?php

namespace App\Http\Controllers\API;

use http\Env\Response;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\User;

class UserController extends Controller
{
    public $successStatus = 200;
//    tao function login
    public function login(){
//        Kiem tra nguoi dung
        if(Auth::attempt(['email'=>\request('email'),'password'=>\request('password')])){
            $user=Auth::user();
            $success['token']=$user->createToken('MyApp')->accessToken;
            return response()->json($success,$this->successStatus);
        }else{
            return \response()->json(['error'=>'khong duoc cap quyen',401]);
        };
    }
//    tao function register
    public function register(Request $request){
//        tao validate cho register
        $validator= Validator::make($request->all(),[
            'name'=>'required',
            'password'=>'required',
            'c_password'=>'required|same:password',
            'email'=>'required'
        ]);
//        check validate
        if($validator->fails()){
            return \response()->json(['error'=>$validator->errors(),401]);
        }
        $user_check= User::where('email',$request->email)->first();
//        return \response()->json($user_check);
        if (empty($user_check)){
            //        Them account vao database
            $input=$request->all();
//        ma hoa password
            $input['password']= bcrypt($input['password']);
            $user=User::create($input);
//        tao token cho user moi
            $success['token']=$user->createToken('Myapp')->accessToken;
            $success['name']=$user->name;
            return \response()->json($success);
        }
        else{
            return \response()->json("User is exist");
        }

    }
//    lay thong tin nguoi dung
    public function details(){
        $user=Auth::user();
        return \response()->json($user,$this->successStatus);

    }

}
