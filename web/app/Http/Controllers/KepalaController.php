<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class KepalaController extends Controller
{
    /**
     * Menampilkan daftar admin
     */
    public function indexAdmin(Request $request)
    {
        $search = $request->input('search');

        $totalActive = DB::table('users')->count();

        $picCount = DB::table('users')
            ->where('role', 'pic')
            ->count();

        $lecturerCount = DB::table('users')
            ->where('role', 'lecturer')
            ->count();

        $inactiveCount = 0;

        $query = DB::table('users')
            ->whereIn('role', ['admin', 'pic', 'kepala']);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('id_number', 'like', "%{$search}%");
            });
        }

        $admins = $query->orderBy('created_at', 'desc')->paginate(10)->withQueryString();

        return view('kepala.kelola-admin', compact(
            'admins',
            'totalActive',
            'picCount',
            'lecturerCount',
            'inactiveCount',
            'search'
        ));
    }

    /**
     * Menampilkan form tambah admin baru
     */
    public function createAdmin()
    {
        return view('kepala.tambah-admin');
    }

    /**
     * Memproses penyimpanan admin baru ke database
     */
    public function storeAdmin(Request $request)
    {
        // 1. Validasi Input Form (Password menggantikan department)
        $request->validate([
            'name' => 'required|string|max:100',
            'id_number' => 'required|numeric|unique:users,id_number',
            'email' => 'required|email|max:100|unique:users,email',
            'phone_number' => 'required|string|max:20',
            'password' => 'required|string|min:6',
        ]);

        // Format nomor telepon
        $phoneNumber = ltrim($request->phone_number, '+62');
        $phoneNumber = '08' . ltrim($phoneNumber, '0');

        DB::beginTransaction();
        try {
            // 2. Hash password yang diinputkan
            $hashedPassword = Hash::make($request->password);

            // Simpan ke tabel users (Tanpa kolom department untuk menghindari error 1054)
            DB::table('users')->insert([
                'id_number' => $request->id_number,
                'name' => $request->name,
                'email' => $request->email,
                'phone_number' => $phoneNumber,
                'password' => $hashedPassword,
                'role' => 'admin', // Role default admin SBUM
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            DB::commit();

            return redirect()->route('admin.kepala')->with('success', 'Administrator baru berhasil ditambahkan!');

        } catch (\Exception $e) {
            DB::rollBack();
            return back()->withInput()->with('error', 'Gagal menyimpan data admin: ' . $e->getMessage());
        }
    }
}