<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\KepalaController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RuanganController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

Route::get('/', function () {
    return view('welcome');
});

// Route Publik / Guest (Pendaftaran & Login)
Route::get('/register', function () {
    return view('auth.register');
})->name('register');

Route::post('/register', [AuthController::class, 'registerStore'])->name('register.store');

Route::get('/login', function () {
    return view('auth.login');
})->name('login');

Route::post('/login', [AuthController::class, 'loginStore'])->name('login.store');

// Route Terproteksi (Wajib Login)
Route::middleware(['auth'])->group(function () {

    // 1. Kelompok Route Role Penanggung Jawab (PJ)
    Route::prefix('pj')->group(function () {
        Route::get('/dashboard', function () {
            return view('pj.dashboard');
        })->name('dashboard');

        Route::get('/ruangan', function () {
            return view('pj.ruangan');
        })->name('ruangan.pj');

        Route::get('/peralatan', function () {
            return view('pj.peralatan');
        })->name('peralatan.pj');

        Route::get('/persetujuan', function () {
            return view('pj.persetujuan');
        })->name('persetujuan.pj');

        Route::get('/riwayat', function () {
            return view('pj.riwayat');
        })->name('riwayat.pj');
    });

    // 2. Kelompok Route Role PIC
    Route::prefix('pic')->group(function () {
        Route::get('/dashboard', function () {
            return view('pic.dashboard');
        })->name('pic.dashboard');

        Route::get('/ruangan', function () {
            return view('pic.ruangan');
        })->name('ruangan.pic');

        Route::get('/peralatan', function () {
            return view('pic.peralatan');
        })->name('peralatan.pic');

        Route::get('/persetujuan', function () {
            return view('pic.persetujuan');
        })->name('persetujuan.pic');

        Route::get('/riwayat', function () {
            return view('pic.riwayat');
        })->name('riwayat.pic');

        Route::get('/kelola-ruangan', function () {
            return view('pic.kelola-ruangan');
        })->name('kelola.ruangan.pic');

        Route::get('/kelola-peralatan', function () {
            return view('pic.kelola-peralatan');
        })->name('kelola.peralatan.pic');
    });

    // 3. Kelompok Route Role Kepala SBUM
    Route::prefix('kepala')->group(function () {
        Route::get('/dashboard', function () {
            return view('kepala.dashboard');
        })->name('kepala.dashboard');

        Route::get('/persetujuan', function () {
            return view('kepala.persetujuan');
        })->name('persetujuan.kepala');

        Route::get('/kalender', function () {
            return view('kepala.kalender');
        })->name('kalender.kepala');

        // Route Kelola Admin
        Route::get('/kelola-admin', [KepalaController::class, 'indexAdmin'])->name('admin.kepala');
        Route::get('/kelola-admin/tambah', [KepalaController::class, 'createAdmin'])->name('admin.create.kepala');
        Route::post('/kelola-admin/store', [KepalaController::class, 'storeAdmin'])->name('admin.store.kepala');
    });

    // 4. Kelompok Route Role Admin
    Route::prefix('admin')->group(function () {
        Route::get('/dashboard', function () {
            return view('admin.dashboard');
        })->name('admin.dashboard');

        Route::get('/persetujuan', function () {
            return view('admin.persetujuan');
        })->name('persetujuan.admin');

        // Kelola Ruangan Admin (Terhubung ke RuanganController)
        Route::get('/kelola-ruangan', [RuanganController::class, 'index'])->name('kelola.ruangan.admin');
        Route::post('/kelola-ruangan/store', [RuanganController::class, 'store'])->name('kelola.ruangan.store');
        Route::delete('/kelola-ruangan/{id}', [RuanganController::class, 'destroy'])->name('kelola.ruangan.destroy');

        Route::get('/kelola-peralatan', function () {
            return view('admin.kelola-peralatan');
        })->name('kelola.peralatan.admin');

        Route::get('/kalender', function () {
            return view('admin.kalender');
        })->name('kalender.admin');
    });

    // Route Manajemen Profil Akun
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::put('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::put('/profile/password', [ProfileController::class, 'updatePassword'])->name('profile.password');

    // Process Logout
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');

});