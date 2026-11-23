<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class ProfileController extends Controller
{
    /**
     * Tampilkan halaman profil pengguna
     */
    public function edit()
    {
        return view('profile.index');
    }

    /**
     * Perbarui data profil (Nama, Email, Telepon)
     */
    public function update(Request $request)
    {
        $user = Auth::user();

        $validated = $request->validate([
            'name' => 'required|string|max:100',
            'email' => 'required|email|max:100|unique:users,email,'.$user->id_number.',id_number',
            'phone_number' => 'required|string|max:20',
            'profile_picture' => ['nullable', 'image', 'mimes:jpeg,png,webp', 'max:2048'],
        ]);

        $previousProfilePhotoPath = $user->profile_picture;
        $profilePhotoPath = $previousProfilePhotoPath;

        if ($request->hasFile('profile_picture')) {
            $profilePhotoPath = $request->file('profile_picture')->storePublicly('profile-photos', 'public');

            if ($profilePhotoPath === false) {
                return back()->withInput()->with('error', 'Foto profil gagal diunggah. Silakan coba lagi.');
            }
        }

        try {
            DB::table('users')
                ->where('id_number', $user->id_number)
                ->update([
                    'name' => $validated['name'],
                    'email' => $validated['email'],
                    'phone_number' => $validated['phone_number'],
                    'profile_picture' => $profilePhotoPath,
                    'updated_at' => now(),
                ]);
        } catch (\Exception $e) {
            if ($profilePhotoPath !== $previousProfilePhotoPath && $profilePhotoPath !== null) {
                if (! Storage::disk('public')->delete($profilePhotoPath)) {
                    Log::warning('Failed to remove a profile photo after the profile update failed.', [
                        'id_number' => $user->id_number,
                        'path' => $profilePhotoPath,
                    ]);
                }
            }

            return back()->with('error', 'Gagal memperbarui profil: '.$e->getMessage());
        }

        if ($previousProfilePhotoPath !== null && $previousProfilePhotoPath !== $profilePhotoPath) {
            if (! Storage::disk('public')->delete($previousProfilePhotoPath)) {
                Log::warning('Failed to delete the previous profile photo.', [
                    'id_number' => $user->id_number,
                    'path' => $previousProfilePhotoPath,
                ]);
            }
        }

        return back()->with('success', 'Profil berhasil diperbarui!');
    }

    /**
     * Perbarui kata sandi akun
     */
    public function updatePassword(Request $request)
    {
        $request->validate([
            'current_password' => 'required',
            'password' => 'required|string|min:8|confirmed',
        ]);

        $user = Auth::user();

        // Pengecekan password lama
        if (! Hash::check($request->current_password, $user->password)) {
            return back()->withErrors(['current_password' => 'Password saat ini tidak sesuai.']);
        }

        try {
            DB::table('users')
                ->where('id_number', $user->id_number)
                ->update([
                    'password' => Hash::make($request->password),
                    'updated_at' => now(),
                ]);

            return back()->with('success', 'Kata sandi berhasil diperbarui!');
        } catch (\Exception $e) {
            return back()->with('error', 'Gagal mengubah kata sandi: '.$e->getMessage());
        }
    }
}
