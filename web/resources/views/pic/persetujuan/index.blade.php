@extends('layouts.app')

@section('title', 'Persetujuan 2 - mySBUM')

@section('content')
<div class="space-y-6">
    <!-- Breadcrumb & Title -->
    <div>
        <div class="text-xs text-slate-400 font-medium mb-1">
            <span>Dashboard</span> &rsaquo; <span class="text-[#056839] font-bold">Persetujuan</span>
        </div>
        <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Halaman Peminjaman</h1>
        <p class="text-xs text-slate-500 mt-1">Pantau dan setujui seluruh peminjaman alat atau ruangan</p>
    </div>

    <!-- Stat Badges Row -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Disetujui -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center space-x-4">
            <div class="w-12 h-12 rounded-2xl bg-emerald-50 text-emerald-600 flex items-center justify-center font-bold text-lg">
                &#10003;
            </div>
            <div>
                <span class="text-3xl font-extrabold text-slate-900">0</span>
                <p class="text-xs font-semibold text-slate-400 mt-0.5">Telah disetujui</p>
            </div>
        </div>

        <!-- Perlu disetujui -->
        <div class="bg-amber-50/50 p-6 rounded-2xl border border-amber-200/60 shadow-sm flex items-center justify-between">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 rounded-2xl bg-amber-100 text-amber-600 flex items-center justify-center font-bold text-lg">
                    &#9200;
                </div>
                <div>
                    <span class="text-3xl font-extrabold text-amber-700">2</span>
                    <p class="text-xs font-semibold text-amber-800 mt-0.5">Perlu disetujui</p>
                </div>
            </div>
            <span class="bg-amber-500 text-white text-[10px] font-bold px-3 py-1 rounded-md">Butuh aksi</span>
        </div>

        <!-- Ditolak -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center space-x-4">
            <div class="w-12 h-12 rounded-2xl bg-rose-50 text-rose-600 flex items-center justify-center font-bold text-lg">
                &#10005;
            </div>
            <div>
                <span class="text-3xl font-extrabold text-slate-900">0</span>
                <p class="text-xs font-semibold text-slate-400 mt-0.5">Telah ditolak</p>
            </div>
        </div>
    </div>

    <!-- Filter & Search Bar -->
    <div class="flex flex-col md:flex-row items-center justify-between gap-4">
        <div class="flex items-center space-x-2">
            <button class="px-5 py-2.5 bg-[#056839] text-white font-bold text-xs rounded-xl shadow-sm">ALAT</button>
            <button class="px-5 py-2.5 bg-slate-200/70 text-slate-600 font-bold text-xs rounded-xl hover:bg-slate-300 transition">RUANGAN</button>
            <button class="px-4 py-2.5 bg-white border border-slate-200 text-slate-600 font-semibold text-xs rounded-xl flex items-center space-x-1">
                <span>Status</span>
            </button>
        </div>

        <div class="relative w-full md:w-1/2">
            <svg class="w-4 h-4 text-slate-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
            <input type="text" placeholder="Cari peralatan, kode, atau nama peminjam..." 
                   class="w-full pl-9 pr-4 py-2 text-xs bg-white border border-slate-100 rounded-xl focus:ring-2 focus:ring-[#056839] shadow-sm">
        </div>
    </div>

    <!-- Approval Cards Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        
        <!-- Card 1 -->
        <div class="bg-white rounded-2xl border border-slate-100 shadow-sm p-6 space-y-4">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 rounded-xl bg-[#056839] text-white flex items-center justify-center">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path></svg>
                    </div>
                    <div>
                        <h3 class="text-sm font-bold text-slate-900">ALT-002</h3>
                        <p class="text-xs text-slate-400">ALT-002 &bull; Peralatan</p>
                    </div>
                </div>
                <span class="bg-amber-100 text-amber-800 text-[10px] font-bold px-3 py-1 rounded-full">Menunggu</span>
            </div>

            <div class="flex items-center space-x-2 pt-2 border-t border-slate-100">
                <span class="text-xs font-bold text-slate-800">Dr. Budi Santoso</span>
                <span class="bg-slate-100 text-slate-600 text-[10px] font-bold px-2 py-0.5 rounded">Lecturer</span>
            </div>

            <div class="bg-slate-50 p-4 rounded-xl text-xs space-y-1 text-slate-600">
                <div class="grid grid-cols-3"><span class="text-slate-400">Email</span><span class="col-span-2 font-medium">: budi.santoso@polibatam.ac.id</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">PIC</span><span class="col-span-2 font-medium">: Andi Wijaya</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Nomor Telp</span><span class="col-span-2 font-medium">: 081200000002</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Hari/Tanggal</span><span class="col-span-2 font-medium">: Jumat, 10 Juli 2026</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Waktu</span><span class="col-span-2 font-medium">: 08:00 s/d 10:00</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Jenis</span><span class="col-span-2 font-medium">: akademik</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Kegiatan</span><span class="col-span-2 font-medium">: rapat</span></div>
            </div>

            <div class="grid grid-cols-2 gap-3 pt-2">
                <button class="py-2.5 bg-[#056839] text-white font-bold text-xs rounded-xl flex items-center justify-center space-x-1 hover:bg-emerald-900 transition">
                    <span>&#10003; Setujui</span>
                </button>
                <button class="py-2.5 bg-rose-600 text-white font-bold text-xs rounded-xl flex items-center justify-center space-x-1 hover:bg-rose-700 transition">
                    <span>&#10005; Tolak</span>
                </button>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="bg-white rounded-2xl border border-slate-100 shadow-sm p-6 space-y-4">
            <div class="flex items-center justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-10 h-10 rounded-xl bg-[#056839] text-white flex items-center justify-center">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path></svg>
                    </div>
                    <div>
                        <h3 class="text-sm font-bold text-slate-900">ALT-001</h3>
                        <p class="text-xs text-slate-400">ALT-001 &bull; Peralatan</p>
                    </div>
                </div>
                <span class="bg-amber-100 text-amber-800 text-[10px] font-bold px-3 py-1 rounded-full">Menunggu</span>
            </div>

            <div class="flex items-center space-x-2 pt-2 border-t border-slate-100">
                <span class="text-xs font-bold text-slate-800">Siti Nurhaliza</span>
                <span class="bg-emerald-100 text-[#056839] text-[10px] font-bold px-2 py-0.5 rounded">Mahasiswa</span>
            </div>

            <div class="bg-slate-50 p-4 rounded-xl text-xs space-y-1 text-slate-600">
                <div class="grid grid-cols-3"><span class="text-slate-400">Email</span><span class="col-span-2 font-medium">: budi.santoso@polibatam.ac.id</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">PIC</span><span class="col-span-2 font-medium">: Andi Wijaya</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Nomor Telp</span><span class="col-span-2 font-medium">: 081200000002</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Hari/Tanggal</span><span class="col-span-2 font-medium">: Jumat, 10 Juli 2026</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Waktu</span><span class="col-span-2 font-medium">: 08:00 s/d 10:00</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Jenis</span><span class="col-span-2 font-medium">: akademik</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Kegiatan</span><span class="col-span-2 font-medium">: rapat</span></div>
            </div>

            <div class="grid grid-cols-2 gap-3 pt-2">
                <button class="py-2.5 bg-[#056839] text-white font-bold text-xs rounded-xl flex items-center justify-center space-x-1 hover:bg-emerald-900 transition">
                    <span>&#10003; Setujui</span>
                </button>
                <button class="py-2.5 bg-rose-600 text-white font-bold text-xs rounded-xl flex items-center justify-center space-x-1 hover:bg-rose-700 transition">
                    <span>&#10005; Tolak</span>
                </button>
            </div>
        </div>

    </div>
</div>
@endsection