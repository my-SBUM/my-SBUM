@extends('layouts.app')

@section('title', 'Peminjaman Ruangan PIC - mySBUM')

@section('content')
<div class="space-y-6">
    <div>
        <div class="text-xs text-slate-400 font-medium mb-1">
            <span>Dashboard</span> &rsaquo; <span class="text-[#056839] font-bold">Peminjaman Ruangan</span>
        </div>
        <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Peminjaman Ruangan</h1>
        <p class="text-xs text-slate-500 mt-1">Cari ruangan kelas, auditorium, laboratorium, dan aula yang tersedia untuk kegiatan akademik maupun ormawa.</p>
    </div>

    <div class="bg-white p-3 rounded-2xl border border-slate-100 shadow-sm flex flex-col md:flex-row items-center justify-between gap-3">
        <div class="relative w-full md:w-2/3">
            <svg class="w-4 h-4 text-slate-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
            <input type="text" placeholder="Cari ruangan atau gedung (cth: Auditorium, Lab Komputer,"
                   class="w-full pl-9 pr-4 py-2 text-xs bg-slate-50 border-none rounded-xl focus:ring-2 focus:ring-[#056839]">
        </div>

        <div class="flex items-center space-x-2 w-full md:w-auto">
            <select class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-slate-600 font-semibold focus:outline-none">
                <option>Kapasitas</option>
            </select>
            <select class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-slate-600 font-semibold focus:outline-none">
                <option>Gedung</option>
            </select>
            <select class="text-xs bg-slate-50 border border-slate-200 rounded-xl px-3 py-2 text-slate-600 font-semibold focus:outline-none">
                <option>Lantai</option>
            </select>
        </div>
    </div>

    <h2 class="text-base font-bold text-slate-900 pt-2">Daftar Ruangan</h2>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden flex flex-col justify-between">
            <div>
                <div class="h-44 bg-slate-200 relative">
                    <img src="https://images.unsplash.com/photo-1517502884422-41eaead166d4?auto=format&fit=crop&w=600&q=80" class="w-full h-full object-cover">
                    <span class="absolute top-3 right-3 bg-emerald-300 text-emerald-950 text-[10px] font-bold px-2.5 py-0.5 rounded-full flex items-center">
                        <span class="w-1.5 h-1.5 rounded-full bg-emerald-700 mr-1"></span> Tersedia
                    </span>
                    <span class="absolute bottom-3 left-3 bg-slate-900/80 text-white text-[10px] font-semibold px-2.5 py-1 rounded-md backdrop-blur-sm">
                        Gedung Utama Lt. 2
                    </span>
                </div>
                <div class="p-5 space-y-1">
                    <h3 class="text-sm font-bold text-slate-900">Auditorium Graha Widya</h3>
                    <p class="text-xs text-slate-500">Ruang aula konferensi utama dengan akustik...</p>
                </div>
            </div>
            <div class="p-5 pt-0 grid grid-cols-2 gap-2">
                <button class="py-2 bg-slate-500 text-white font-semibold text-xs rounded-xl hover:bg-slate-600 transition">Detail</button>
                <button class="py-2 bg-[#056839] text-white font-semibold text-xs rounded-xl hover:bg-emerald-900 transition">Pinjam Ruangan</button>
            </div>
        </div>
    </div>
</div>
@endsection