@extends('layouts.app')

@section('title', 'Riwayat PIC - mySBUM')

@section('content')
<div class="space-y-6">
    <div>
        <div class="text-xs text-slate-400 font-medium mb-1">
            <span>Dashboard</span> &rsaquo; <span class="text-[#056839] font-bold">Riwayat</span>
        </div>
        <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Riwayat</h1>
        <p class="text-xs text-slate-500 mt-1">Daftar riwayat permohonan kegiatan binaan yang telah disetujui, ditolak, atau selesai dilaksanakan di lingkungan Polibatam.</p>
    </div>

    <div class="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm space-y-4">
        <div class="flex flex-wrap items-center gap-2">
            <button class="px-4 py-1.5 bg-emerald-100 text-[#056839] font-bold text-xs rounded-full">Semua (2)</button>
            <button class="px-4 py-1.5 bg-slate-100 text-slate-600 font-semibold text-xs rounded-full hover:bg-slate-200">Disetujui (0)</button>
            <button class="px-4 py-1.5 bg-slate-100 text-slate-600 font-semibold text-xs rounded-full hover:bg-slate-200">Menunggu (1)</button>
            <button class="px-4 py-1.5 bg-slate-100 text-slate-600 font-semibold text-xs rounded-full hover:bg-slate-200">Ditolak (1)</button>
        </div>

        <div class="flex flex-col md:flex-row items-center justify-between gap-3">
            <div class="relative w-full md:w-3/4">
                <svg class="w-4 h-4 text-slate-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                <input type="text" placeholder="Cari berdasarkan kode booking, kegiatan, atau nama pemohon..." 
                       class="w-full pl-9 pr-4 py-2 text-xs bg-slate-50 border-none rounded-xl focus:ring-2 focus:ring-[#056839]">
            </div>
            <button class="w-full md:w-auto px-4 py-2 bg-slate-100 text-slate-700 font-semibold text-xs rounded-xl flex items-center justify-center space-x-1">
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"></path></svg>
                <span>Filter Lanjutan</span>
            </button>
        </div>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white rounded-2xl border-l-4 border-l-amber-500 border border-slate-100 shadow-sm p-5 space-y-4">
            <div class="flex items-start justify-between">
                <div class="flex items-center space-x-3">
                    <div class="w-9 h-9 rounded-xl bg-amber-100 text-amber-700 flex items-center justify-center">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                    </div>
                    <div>
                        <h3 class="text-sm font-bold text-slate-900">Ruang Kelas A102</h3>
                        <p class="text-[11px] text-slate-400 font-medium">rapat</p>
                    </div>
                </div>
                <span class="bg-amber-100 text-amber-800 text-[10px] font-bold px-2.5 py-0.5 rounded-md">MENUNGGU</span>
            </div>

            <div class="text-xs space-y-1 text-slate-600 pt-2 border-t border-slate-100">
                <div class="grid grid-cols-3"><span class="text-slate-400">Tanggal</span><span class="col-span-2 font-medium">: Sabtu, 11 Juli 2026</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Waktu</span><span class="col-span-2 font-medium">: 08:21 - 09:21</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">Jenis</span><span class="col-span-2 font-medium">: non-akademik</span></div>
                <div class="grid grid-cols-3"><span class="text-slate-400">PIC</span><span class="col-span-2 font-medium">: Andi Wijaya</span></div>
            </div>

            <div class="grid grid-cols-2 gap-2 pt-1">
                <button class="py-2 bg-slate-100 text-slate-700 font-semibold text-xs rounded-xl">Detail</button>
                <button class="py-2 bg-rose-50 border border-rose-200 text-rose-600 font-semibold text-xs rounded-xl">Batalkan</button>
            </div>
        </div>
    </div>
</div>
@endsection