@extends('layouts.auth')

@section('title', 'Daftar - mySBUM')

@section('content')
<div class="w-full bg-white rounded-2xl shadow-sm border border-slate-200/80 p-6 sm:p-8">
    <!-- Header Logo / Icon -->
    <div class="flex flex-col items-center text-center mb-6">
        <div class="w-12 h-12 rounded-xl bg-emerald-50 text-emerald-800 flex items-center justify-center mb-3 border border-emerald-100">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
            </svg>
        </div>
        <h1 class="text-xl font-bold text-slate-900">Pendaftaran Akun mySBUM</h1>
        <p class="text-xs text-slate-500 mt-1">Lengkapi data singkat untuk akses peminjaman fasilitas</p>
    </div>

    <!-- Register Form -->
    <form action="#" method="POST" class="space-y-4">
        @csrf

        <!-- Nama Lengkap -->
        <div>
            <label for="name" class="block text-xs font-semibold text-slate-700 mb-1.5">Nama Lengkap *</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                </div>
                <input type="text" id="name" name="name" required 
                       placeholder="Contoh: Ahmad Rizky Pratama" 
                       class="w-full pl-9 pr-3 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
            </div>
        </div>

        <!-- NIM / NIP -->
        <div>
            <label for="nim_nip" class="block text-xs font-semibold text-slate-700 mb-1.5">NIM / NIP *</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                    <span class="text-sm font-bold leading-none">#</span>
                </div>
                <input type="text" id="nim_nip" name="nim_nip" required 
                       placeholder="3312101045" 
                       class="w-full pl-9 pr-3 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
            </div>
        </div>

        <!-- Email Institusi -->
        <div>
            <label for="email" class="block text-xs font-semibold text-slate-700 mb-1.5">Email Institusi (@polibatam.ac.id) *</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                    </svg>
                </div>
                <input type="email" id="email" name="email" required 
                       placeholder="nama@polibatam.ac.id" 
                       class="w-full pl-9 pr-3 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
            </div>
        </div>

        <!-- Password & Konfirmasi Password Row -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3" x-data="{ showPass: false, showConfirm: false }">
            <div>
                <label for="password" class="block text-xs font-semibold text-slate-700 mb-1.5">Password *</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                    </div>
                    <input :type="showPass ? 'text' : 'password'" id="password" name="password" required 
                           placeholder="Min. 8 Karakter" 
                           class="w-full pl-9 pr-8 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
                    <button type="button" @click="showPass = !showPass" class="absolute inset-y-0 right-0 pr-2.5 flex items-center text-slate-400 hover:text-slate-600">
                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                        </svg>
                    </button>
                </div>
            </div>

            <div>
                <label for="password_confirmation" class="block text-xs font-semibold text-slate-700 mb-1.5">Konfirmasi Password *</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                    </div>
                    <input :type="showConfirm ? 'text' : 'password'" id="password_confirmation" name="password_confirmation" required 
                           placeholder="Ulangi Password" 
                           class="w-full pl-9 pr-8 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
                    <button type="button" @click="showConfirm = !showConfirm" class="absolute inset-y-0 right-0 pr-2.5 flex items-center text-slate-400 hover:text-slate-600">
                        <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="w-full mt-2 bg-[#056839] hover:bg-emerald-900 text-white font-semibold py-2.5 px-4 rounded-lg text-xs flex items-center justify-center space-x-2 transition shadow-sm">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
            </svg>
            <span>Daftar Akun</span>
        </button>
    </form>

    <!-- Bottom Link -->
    <div class="text-center mt-6 pt-4 border-t border-slate-100">
        <p class="text-xs text-slate-500">
            Sudah punya akun? 
            <a href="{{ route('login') }}" class="font-semibold text-slate-800 hover:text-emerald-800 transition">Login &rsaquo;</a>
        </p>
    </div>
</div>
@endsection
