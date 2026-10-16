@extends('layouts.auth')

@section('title', 'Login - mySBUM')

@section('content')
<div class="w-full bg-white rounded-2xl shadow-sm border border-slate-200/80 p-6 sm:p-8">
    <!-- Header Logo / Icon -->
    <div class="flex flex-col items-center text-center mb-6">
        <div class="w-12 h-12 rounded-xl bg-emerald-50 text-emerald-800 flex items-center justify-center mb-3 border border-emerald-100">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
            </svg>
        </div>
        <h1 class="text-xl font-bold text-slate-900">Masuk ke mySBUM</h1>
        <p class="text-xs text-slate-500 mt-1">Sistem Peminjaman Alat & Fasilitas Politeknik Negeri Batam</p>
        <span class="text-[11px] text-slate-400 mt-2 font-medium">atau dengan NIM / NIP</span>
    </div>

    <!-- Login Form -->
    <form action="#" method="POST" class="space-y-4">
        @csrf

        <!-- NIM / NIP / Email -->
        <div>
            <label for="identity" class="block text-xs font-semibold text-slate-700 mb-1.5">NIM / NIP / Email Institusi</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V5a2 2 0 012-2h2a2 2 0 012 2v1m-6 0h6"></path>
                    </svg>
                </div>
                <input type="text" id="identity" name="identity" required 
                       placeholder="Contoh: 3312101045 atau nama@polibatam.ac.id" 
                       class="w-full pl-9 pr-3 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
            </div>
        </div>

        <!-- Password -->
        <div x-data="{ showPassword: false }">
            <div class="flex items-center justify-between mb-1.5">
                <label for="password" class="block text-xs font-semibold text-slate-700">Password</label>
                <a href="#" class="text-xs text-slate-500 hover:text-emerald-700 transition">Lupa sandi?</a>
            </div>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                    </svg>
                </div>
                <input :type="showPassword ? 'text' : 'password'" id="password" name="password" required 
                       placeholder="Masukkan Password" 
                       class="w-full pl-9 pr-9 py-2.5 text-xs bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-600 focus:bg-white transition text-slate-800 placeholder-slate-400">
                <button type="button" @click="showPassword = !showPassword" class="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-slate-600">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                    </svg>
                </button>
            </div>
        </div>

        <!-- Checkbox & Link Options -->
        <div class="flex items-center justify-between pt-1 text-xs">
            <label class="flex items-center text-slate-600 cursor-pointer">
                <input type="checkbox" name="remember" class="w-3.5 h-3.5 text-emerald-800 border-slate-300 rounded focus:ring-emerald-700">
                <span class="ml-2 text-slate-600">Ingat saya</span>
            </label>
            <a href="#" class="inline-flex items-center text-slate-600 hover:text-emerald-800 transition font-medium">
                <svg class="w-3.5 h-3.5 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 01-9 9m9-9a9 9 0 00-9-9m9 9H3m9 9a9 9 0 01-9-9m9 9c1.657 0 3-4.03 3-9s-1.343-9-3-9m0 18c-1.657 0-3-4.03-3-9s1.343-9 3-9"></path>
                </svg>
                Portal Resmi
            </a>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="w-full mt-2 bg-[#056839] hover:bg-emerald-900 text-white font-semibold py-2.5 px-4 rounded-lg text-xs flex items-center justify-center space-x-2 transition shadow-sm">
            <span>Masuk</span>
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path>
            </svg>
        </button>
    </form>

    <!-- Bottom Link -->
    <div class="text-center mt-6 pt-4 border-t border-slate-100">
        <p class="text-xs text-slate-500">
            Belum terdaftar? 
            <a href="{{ route('register') }}" class="font-semibold text-slate-800 hover:text-emerald-800 transition">Daftar Akun Baru</a>
        </p>
    </div>
</div>
@endsection
