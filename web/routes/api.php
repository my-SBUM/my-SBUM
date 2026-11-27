<?php

use App\Http\Controllers\MobileAuthController;
use Illuminate\Support\Facades\Route;

Route::post('login', [MobileAuthController::class, 'login'])->middleware('throttle:10,1');
Route::middleware('auth:sanctum')->group(function () {
    Route::get('me', [MobileAuthController::class, 'me']);
    Route::post('logout', [MobileAuthController::class, 'logout']);
});
