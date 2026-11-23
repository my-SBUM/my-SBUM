<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    /**
     * Memproses pendaftaran akun baru (Penanggung Jawab, PIC, Admin SBUM, Kepala SBUM)
     */
    public function registerStore(Request $request)
    {
        // 1. Validasi Input (Mendukung 4 Role)
        $request->validate([
            'id_number' => 'required|numeric|unique:users,id_number',
            'name' => 'required|string|max:100',
            'email' => 'required|string|email|max:100|unique:users,email',
            'phone_number' => 'required|string|max:15',
            'role' => 'required|in:lecturer,pic,admin,kepala',
            'password' => 'required|string|min:8|confirmed',
        ]);

        // Gunakan DB Transaction agar jika gagal di salah satu tabel, data dibatalkan semua
        DB::beginTransaction();
        try {
            // 2. Simpan ke tabel users (Tabel Utama)
            DB::table('users')->insert([
                'id_number' => $request->id_number,
                'name' => $request->name,
                'email' => $request->email,
                'phone_number' => $request->phone_number,
                'password' => Hash::make($request->password),
                'role' => $request->role,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // 3. Simpan ke tabel spesifik berdasarkan aktor (Role)
            if ($request->role === 'lecturer') {
                // Penanggung Jawab
                DB::table('lecturers')->insert([
                    'id_number' => $request->id_number,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            } elseif ($request->role === 'pic') {
                // PIC
                DB::table('pics')->insert([
                    'id_number' => $request->id_number,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            } elseif ($request->role === 'admin' || $request->role === 'kepala') {
                // Pegawai SBUM (Admin / Kepala)
                DB::table('pegawai_sbums')->insert([
                    'id_number' => $request->id_number,
                    'role' => $request->role === 'kepala' ? 'ketua' : 'admin',
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }

            DB::commit();
            return redirect()->route('login')->with('success', 'Akun berhasil dibuat. Silakan Login!');

        } catch (\Exception $e) {
            DB::rollBack();
            return back()->withInput()->withErrors(['error' => 'Gagal mendaftar: ' . $e->getMessage()]);
        }
    }

    /**
     * Memproses login pengguna (NIM/NIP/Email)
     */
    public function loginStore(Request $request)
    {
        // 1. Validasi Input Login
        $request->validate([
            'login_id' => 'required|string',
            'password' => 'required|string',
        ]);

        // 2. Deteksi apakah input berupa Email atau NIM/NIP (id_number)
        $fieldType = filter_var($request->login_id, FILTER_VALIDATE_EMAIL) ? 'email' : 'id_number';

        // 3. Coba Autentikasi
        $credentials = [
            $fieldType => $request->login_id,
            'password' => $request->password,
        ];

        if (Auth::attempt($credentials, $request->has('remember'))) {
            $request->session()->regenerate();

            $user = Auth::user();

            // Redirect otomatis sesuai dengan 4 role pengguna
            if ($user->role === 'lecturer' || $user->role === 'pj') {
                return redirect()->route('dashboard'); // Mengarah ke route Penanggung Jawab (/pj/dashboard)
            } elseif ($user->role === 'pic') {
                return redirect()->route('pic.dashboard'); // Mengarah ke route PIC (/pic/dashboard)
            } elseif ($user->role === 'admin') {
                return redirect()->route('admin.dashboard'); // Mengarah ke route Admin SBUM (/admin/dashboard)
            } elseif ($user->role === 'kepala') {
                return redirect()->route('kepala.dashboard'); // Mengarah ke route Kepala SBUM (/kepala/dashboard)
            }

            // Fallback default redirect
            return redirect()->route('dashboard');
        }

        // Jika login gagal
        return back()->withErrors([
            'login_id' => 'NIM/NIP/Email atau password tidak ditemukan / salah.',
        ])->onlyInput('login_id');
    }

    /**
     * Memproses logout pengguna
     */
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login');
    }
}