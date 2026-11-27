<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;

class MobileAuthController extends Controller
{
    public function login(Request $request): JsonResponse
    {
        $data = $request->validate([
            'identifier' => ['required', 'string', 'max:100'],
            'password' => ['required', 'string', 'max:1024'],
        ]);

        $field = ctype_digit($data['identifier']) ? 'id_number' : 'email';
        $user = User::where($field, $data['identifier'])->first();

        if (! $user || ! Hash::check($data['password'], $user->password) || ! $user->is_active) {
            return response()->json(['message' => 'Identitas atau kata sandi salah, atau akun tidak aktif.'], 401);
        }

        $token = $user->createToken('mobile', ['mobile'], now()->addDay());

        return response()->json(['token' => $token->plainTextToken], 200, ['Cache-Control' => 'no-store']);
    }

    public function me(Request $request): JsonResponse
    {
        abort_unless($request->user()->is_active, 401);

        return response()->json($request->user()->only('id_number', 'name', 'role'));
    }

    public function logout(Request $request): Response
    {
        $request->user()->currentAccessToken()->delete();

        return response()->noContent();
    }
}
