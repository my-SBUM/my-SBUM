<?php

use Illuminate\Support\Facades\Route;
use SebastianBergmann\CodeCoverage\Report\Html\Dashboard;


// Landing Page Utama
Route::get('/', function () {
    return view('welcome');
})->name('landing');

// Tampilan Login
Route::get('/login', function () {
    return view('auth.login');
})->name('login');

// Tampilan Register
Route::get('/register', function () {
    return view('auth.register');
})->name('register');

// Penanggu Jawab
Route::prefix('penanggung-jawab')->name('pj.')->group(function () {
    Route::get('/dashboard', function () {
        return view('penanggung-jawab.dashboard');
    })->name('dashboard');

    Route::get('/peminjaman/ruangan', function () {
        return view('penanggung-jawab.peminjaman.ruangan');
    })->name('peminjaman.ruangan');

    Route::get('/peminjaman/alat', function () {
        return view('penanggung-jawab.peminjaman.alat');
    })->name('peminjaman.alat');

    Route::get('/persetujuan', function () {
        return view('penanggung-jawab.persetujuan.index');
    })->name('persetujuan.index');

    Route::get('/riwayat', function () {
        return view('penanggung-jawab.riwayat.index');
    })->name('riwayat.index');
});

// PIC Routes
Route::prefix('pic')->name('pic.')->group(function () {
    Route::get('/dashboard', function () {
        return view('pic.dashboard');
    })->name('dashboard');

    Route::get('/peminjaman/ruangan', function () {
        return view('pic.peminjaman.ruangan');
    })->name('peminjaman.ruangan');

    Route::get('/peminjaman/alat', function () {
        return view('pic.peminjaman.alat');
    })->name('peminjaman.alat');

    Route::get('/persetujuan', function () {
        return view('pic.persetujuan.index');
    })->name('persetujuan.index');

    Route::get('/riwayat', function () {
        return view('pic.riwayat.index');
    })->name('riwayat.index');

    Route::get('/ruangan', function () {
        return view('pic.ruangan.index');
    })->name('ruangan.index');

    Route::get('/peralatan', function () {
        return view('pic.peralatan.index');
    })->name('peralatan.index');
});

// Admin Routes
Route::prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', function () {
        return view('admin.dashboard');
    })->name('dashboard');

    Route::get('/persetujuan', function () {
        return view('admin.persetujuan.index');
    })->name('persetujuan.index');

    Route::get('/ruangan', function () {
        return view('admin.ruangan.index');
    })->name('ruangan.index');

    Route::get('/peralatan', function () {
        return view('admin.peralatan.index');
    })->name('peralatan.index');

    Route::get('/kalender', function () {
        return view('admin.kalender.index');
    })->name('kalender.index');
});

// Kepala SBUM Routes
Route::prefix('kepala-sbum')->name('kepala-sbum.')->group(function () {
    Route::get('/dashboard', function () {
        return view('kepala-sbum.dashboard');
    })->name('dashboard');

    Route::get('/persetujuan', function () {
        return view('kepala-sbum.persetujuan.index');
    })->name('persetujuan.index');

    Route::get('/kalender', function () {
        return view('kepala-sbum.kalender.index');
    })->name('kalender.index');

    Route::get('/admin', function () {
        return view('kepala-sbum.admin.index');
    })->name('admin.index');
});