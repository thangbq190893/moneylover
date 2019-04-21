<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class UserRequest extends FormRequest
{
    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json($validator->errors(), 422));
    }
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'email' => 'required|string|email',
//            'password' => 'required|string|confirmed',
//            'token' => 'required|string',
        ];
    }
    public function messages()
    {
        return [
            'email.required' => 'email is required',
            'email.string' => 'email is string',
            'email.email' => 'email must have type is email',
//            'password' => 'required|string|confirmed',
//            'token' => 'required|string',
        ];
    }
}
