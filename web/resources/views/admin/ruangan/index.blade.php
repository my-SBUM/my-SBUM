@extends('layouts.app')

@section('title', 'Kelola Ruangan Admin - mySBUM')

@section('content')
<div class="space-y-6">
    <div>
        <div class="text-xs text-slate-400 font-medium mb-1">
            <span>Dashboard</span> &rsaquo; <span class="text-[#056839] font-bold">Ruangan</span>
        </div>
        <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Kelola Ruangan</h1>
        <p class="text-xs text-slate-500 mt-1">Daftar, atur ketersediaan, kapasitas, dan status operasional seluruh ruangan kampus.</p>
    </div>

    <!-- Summary Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
            <div class="space-y-2">
                <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">SIAP DIGUNAKAN</span>
                <div class="flex items-baseline space-x-2">
                    <span class="text-4xl font-extrabold text-slate-900">23</span>
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
                <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">SEDANG DIPAKAI</span>
                <div class="flex items-baseline space-x-2">
                    <span class="text-4xl font-extrabold text-slate-900">14</span>
                    <span class="text-xs text-slate-500">Unit</span>
                </div>
            </div>
            <div class="flex flex-col items-end space-y-2">
                <div class="w-10 h-10 rounded-full bg-indigo-100 text-indigo-600 flex items-center justify-center font-bold text-lg">((.))</div>
                <span class="bg-indigo-100 text-indigo-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">Aktif Sekarang</span>
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
            <div class="space-y-2">
                <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">TIDAK TERSEDIA</span>
                <div class="flex items-baseline space-x-2">
                    <span class="text-4xl font-extrabold text-slate-900">1</span>
                    <span class="text-xs text-slate-500">Unit</span>
                </div>
            </div>
            <div class="flex flex-col items-end space-y-2">
                <div class="w-10 h-10 rounded-full bg-rose-100 text-rose-600 flex items-center justify-center font-bold text-lg">&#9888;</div>
                <span class="bg-rose-100 text-rose-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">Maintence</span>
            </div>
        </div>
    </div>

    <!-- Filter & Search -->
    <div class="bg-white p-3 rounded-2xl border border-slate-100 shadow-sm flex flex-col md:flex-row items-center justify-between gap-3">
        <div class="relative w-full md:w-3/4">
            <input type="text" placeholder="Cari nama ruangan, gedung, atau kode"
                   class="w-full pl-9 pr-4 py-2 text-xs bg-slate-50 border-none rounded-xl focus:ring-2 focus:ring-[#056839]">
        </div>
        <select class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-slate-600 font-semibold focus:outline-none w-full md:w-auto">
            <option>Semua Status</option>
        </select>
    </div>

    <!-- Cards Grid -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden flex flex-col justify-between">
            <div>
                <div class="h-44 bg-slate-200 relative">
                    <img src="https://images.unsplash.com/photo-1517502884422-41eaead166d4?auto=format&fit=crop&w=600&q=80" class="w-full h-full object-cover">
                    <span class="absolute top-3 right-3 bg-emerald-300 text-emerald-950 text-[10px] font-bold px-2.5 py-0.5 rounded-full flex items-center">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-700 mr-1"></span> Tersedia
                    </span>
                    <span class="absolute bottom-3 left-3 bg-slate-900/80 text-white text-[10px] font-semibold px-2.5 py-1 rounded-md backdrop-blur-sm">Gedung Utama Lt. 2</span>
                    <span class="absolute bottom-3 right-3 bg-white text-slate-700 text-[10px] font-bold px-2 py-0.5 rounded shadow">A-104</span>
                </div>
                <div class="p-5 space-y-2">
                    <h3 class="text-sm font-bold text-slate-900">Auditorium Graha Widya</h3>
                    <p class="text-xs text-slate-500 line-clamp-1">Ruang aula konferensi utama dengan akustik...</p>
                    <div class="text-[11px] text-slate-600 font-medium space-y-1 pt-1">
                        <p>&bull; PIC: Andi Wijaya</p>
                        <p>&bull; Kapasitas: 40 orang</p>
                    </div>
                </div>
            </div>
            <div class="p-5 pt-0">
                <button class="w-full py-2.5 bg-[#056839] text-white font-bold text-xs rounded-xl hover:bg-emerald-900 transition">Edit Ruangan</button>
            </div>
        </div>
    </div>
</div>
@endsection