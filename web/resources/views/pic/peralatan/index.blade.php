@extends('layouts.app')

@section('title', 'Kelola Peralatan PIC - mySBUM')

@section('content')
<div class="space-y-6">
    <div>
        <div class="text-xs text-slate-400 font-medium mb-1">
            <span>Dashboard</span> &rsaquo; <span class="text-[#056839] font-bold">Kelola Peralatan</span>
        </div>
        <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Kelola Peralatan</h1>
        <p class="text-xs text-slate-500 mt-1">Manajemen ketersediaan stok, kode aset, kondisi fisik, dan lokasi penyimpanan unit sarana.</p>
    </div>

    <!-- 3 Summary Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
            <div class="space-y-2">
                <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">SIAP DIGUNAKAN</span>
                <div class="flex items-baseline space-x-2">
                    <span class="text-4xl font-extrabold text-slate-900">142</span>
                    <span class="text-xs text-slate-500">Unit</span>
                </div>
            </div>
            <div class="flex flex-col items-end space-y-2">
                <div class="w-10 h-10 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center font-bold text-lg">&#10003;</div>
                <span class="bg-emerald-200/80 text-emerald-950 text-[10px] font-bold px-2.5 py-0.5 rounded-full">Siap Pakai</span>
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
            <div class="space-y-2">
                <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">SEDANG DIPINJAM</span>
                <div class="flex items-baseline space-x-2">
                    <span class="text-4xl font-extrabold text-slate-900">36</span>
                    <span class="text-xs text-slate-500">Unit</span>
                </div>
            </div>
            <div class="flex flex-col items-end space-y-2">
                <div class="w-10 h-10 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center font-bold text-lg">&#128197;</div>
                <span class="bg-indigo-100 text-indigo-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">Terjadwal</span>
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
            <div class="space-y-2">
                <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">RUSAK / SERVIS</span>
                <div class="flex items-baseline space-x-2">
                    <span class="text-4xl font-extrabold text-slate-900">6</span>
                    <span class="text-xs text-slate-500">Unit</span>
                </div>
            </div>
            <div class="flex flex-col items-end space-y-2">
                <div class="w-10 h-10 rounded-full bg-rose-100 text-rose-600 flex items-center justify-center font-bold text-lg">&#128295;</div>
                <span class="bg-rose-100 text-rose-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">Maintenance</span>
            </div>
        </div>
    </div>

    <!-- Filter Bar -->
    <div class="bg-white p-3 rounded-2xl border border-slate-100 shadow-sm flex flex-col md:flex-row items-center justify-between gap-3">
        <div class="relative w-full md:w-1/2">
            <svg class="w-4 h-4 text-slate-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
            <input type="text" placeholder="Cari nama alat, merk, atau kode aset (misal: EQ-AUD-014)..."
                   class="w-full pl-9 pr-4 py-2 text-xs bg-slate-50 border-none rounded-xl focus:ring-2 focus:ring-[#056839]">
        </div>
        <div class="flex items-center space-x-2 w-full md:w-auto">
            <select class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-slate-600 font-semibold focus:outline-none">
                <option>Semua Kategori</option>
            </select>
            <select class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-slate-600 font-semibold focus:outline-none">
                <option>Semua Kondisi</option>
            </select>
            <button class="px-3 py-2 bg-slate-100 text-slate-600 rounded-xl text-xs font-bold hover:bg-slate-200 transition flex items-center space-x-1">
                <span>&#8634; Reset</span>
            </button>
        </div>
    </div>

    <!-- Cards Grid -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Equipment Item 1 -->
        <div class="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden flex flex-col justify-between">
            <div>
                <div class="h-44 bg-slate-200 relative">
                    <img src="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=600&q=80" class="w-full h-full object-cover">
                    <span class="absolute top-3 right-3 bg-emerald-300 text-emerald-950 text-[10px] font-bold px-2.5 py-0.5 rounded-full flex items-center">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-700 mr-1"></span> Tersedia
                    </span>
                    <span class="absolute bottom-3 left-3 bg-slate-900/80 text-white text-[10px] font-semibold px-2.5 py-1 rounded-md backdrop-blur-sm">SBUM Gudang Utama</span>
                    <span class="absolute bottom-3 right-3 bg-white text-slate-700 text-[10px] font-bold px-2 py-0.5 rounded shadow">ALT-104</span>
                </div>
                <div class="p-5 space-y-2">
                    <h3 class="text-sm font-bold text-slate-900">Wireless Microphone UHF (Set of 2)</h3>
                    <p class="text-xs text-slate-500 line-clamp-2">Dual channel frekuensi dinamis jangkauan 50 meter dengan baterai isi ulang dan receiver...</p>
                    <p class="text-[11px] text-slate-600 font-semibold pt-1">&boxbox; Stok : 2</p>
                </div>
            </div>
            <div class="p-5 pt-0">
                <button class="w-full py-2.5 bg-[#056839] text-white font-bold text-xs rounded-xl hover:bg-emerald-900 transition">
                    Edit Alat
                </button>
            </div>
        </div>

        <!-- Equipment Item 2 -->
        <div class="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden flex flex-col justify-between">
            <div>
                <div class="h-44 bg-slate-200 relative">
                    <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80" class="w-full h-full object-cover">
                    <span class="absolute top-3 right-3 bg-emerald-300 text-emerald-950 text-[10px] font-bold px-2.5 py-0.5 rounded-full flex items-center">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-700 mr-1"></span> Tersedia
                    </span>
                    <span class="absolute bottom-3 left-3 bg-slate-900/80 text-white text-[10px] font-semibold px-2.5 py-1 rounded-md backdrop-blur-sm">Ruang Operator SBUM</span>
                    <span class="absolute bottom-3 right-3 bg-white text-slate-700 text-[10px] font-bold px-2 py-0.5 rounded shadow">ALT-104</span>
                </div>
                <div class="p-5 space-y-2">
                    <h3 class="text-sm font-bold text-slate-900">Portable PA System 500W + Stand</h3>
                    <p class="text-xs text-slate-500 line-clamp-2">Speaker aktif multifungsi dengan Bluetooth, input instrumen 4-channel, dan roda koper...</p>
                    <p class="text-[11px] text-slate-600 font-semibold pt-1">&boxbox; Stok : 2</p>
                </div>
            </div>
            <div class="p-5 pt-0">
                <button class="w-full py-2.5 bg-[#056839] text-white font-bold text-xs rounded-xl hover:bg-emerald-900 transition">
                    Edit Alat
                </button>
            </div>
        </div>
    </div>
</div>
@endsection