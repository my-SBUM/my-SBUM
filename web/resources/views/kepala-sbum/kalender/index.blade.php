@extends('layouts.app')

@section('title', 'Kalender Peminjaman Kepala SBUM - mySBUM')

@section('content')
<div class="space-y-6">
    
    <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
        <div>
            <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Kalender Peminjaman</h1>
            <p class="text-xs text-slate-500 mt-1">Lihat semua peminjaman ruangan dan alat dalam tampilan kalender.</p>
        </div>

        <div class="flex items-center space-x-3">
            <button class="px-4 py-2 bg-rose-50 border border-rose-200 text-rose-600 font-bold text-xs rounded-xl hover:bg-rose-100 transition flex items-center space-x-1.5">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                <span>Download PDF</span>
            </button>
            <button class="px-4 py-2 bg-[#056839] text-white font-bold text-xs rounded-xl hover:bg-emerald-900 transition flex items-center space-x-1.5 shadow-sm">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
                <span>Download Excel</span>
            </button>
        </div>
    </div>

    <!-- Stats Row -->
    <div class="grid grid-cols-1 md:grid-cols-12 gap-4">
        <div class="md:col-span-8 grid grid-cols-2 sm:grid-cols-4 gap-4">
            <div class="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-[10px] font-bold text-slate-400">Total aktif</span>
                    <p class="text-2xl font-extrabold text-slate-900 mt-0.5">35</p>
                </div>
            </div>

            <div class="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-[10px] font-bold text-amber-600">Menunggu</span>
                    <p class="text-2xl font-extrabold text-amber-600 mt-0.5">16</p>
                </div>
            </div>

            <div class="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-[10px] font-bold text-emerald-600">Disetujui</span>
                    <p class="text-2xl font-extrabold text-emerald-600 mt-0.5">19</p>
                </div>
            </div>

            <div class="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm flex items-center justify-between">
                <div>
                    <span class="text-[10px] font-bold text-indigo-600">Ruangan</span>
                    <p class="text-2xl font-extrabold text-indigo-600 mt-0.5">22</p>
                </div>
            </div>
        </div>

        <div class="md:col-span-4 grid grid-cols-2 gap-3">
            <div class="bg-white p-3 rounded-2xl border border-slate-100 shadow-sm flex flex-col justify-center">
                <span class="text-[10px] font-bold text-slate-400">Jenis peminjaman</span>
                <select class="text-xs font-bold text-slate-800 bg-transparent focus:outline-none mt-1">
                    <option>Semua</option>
                </select>
            </div>
            <div class="bg-white p-3 rounded-2xl border border-slate-100 shadow-sm flex flex-col justify-center">
                <span class="text-[10px] font-bold text-slate-400">Status peminjaman</span>
                <select class="text-xs font-bold text-slate-800 bg-transparent focus:outline-none mt-1">
                    <option>Semua</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Calendar Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
        <div class="lg:col-span-8 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-6">
            <div class="flex items-center justify-between">
                <div>
                    <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Bulan</span>
                    <h2 class="text-xl font-extrabold text-slate-900">Juli 2026</h2>
                </div>
                <div class="flex items-center space-x-2 text-xs font-bold">
                    <button class="px-3 py-1.5 border border-slate-200 rounded-xl hover:bg-slate-50">&lt; Sebelumnya</button>
                    <button class="px-3 py-1.5 border border-emerald-300 text-[#056839] rounded-xl bg-emerald-50">Hari ini</button>
                    <button class="px-3 py-1.5 border border-slate-200 rounded-xl hover:bg-slate-50">Berikutnya &gt;</button>
                </div>
            </div>

            <div class="grid grid-cols-7 gap-1 text-center text-xs font-bold text-slate-400 pb-2 border-b border-slate-100">
                <div>Min</div><div>Sen</div><div>Sel</div><div>Rab</div><div class="text-[#056839]">Kam</div><div>Jum</div><div>Sab</div>
            </div>

            <div class="grid grid-cols-7 gap-1 text-xs font-semibold">
                <div class="h-16 p-1 text-slate-300"></div>
                <div class="h-16 p-1 text-slate-300"></div>
                <div class="h-16 p-1 text-slate-300"></div>
                <div class="h-16 p-2 text-slate-700">1</div>
                <div class="h-16 p-2 text-slate-700">2</div>
                <div class="h-16 p-2 text-slate-700">3</div>
                <div class="h-16 p-2 text-slate-700">4</div>

                <div class="h-16 p-2 text-slate-700">5</div>
                <div class="h-16 p-2 text-slate-700">6</div>
                <div class="h-16 p-2 text-slate-700">7</div>
                <div class="h-16 p-2 text-slate-700">8</div>
                <div class="h-16 p-2 text-slate-700">9</div>
                <div class="h-16 p-2 bg-rose-500 text-white rounded-full w-8 h-8 flex items-center justify-center font-bold">10</div>
                <div class="h-16 p-2 text-slate-700 flex flex-col justify-between">
                    <span>11</span>
                </div>
            </div>
        </div>

        <div class="lg:col-span-4 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-4">
            <div class="flex items-center justify-between pb-3 border-b border-slate-100">
                <div>
                    <span class="text-[10px] font-bold text-slate-400">Detail tanggal</span>
                    <h3 class="text-base font-extrabold text-slate-900">Kamis, 16 Juli 2026</h3>
                </div>
                <span class="bg-amber-100 text-amber-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">5 acara</span>
            </div>
        </div>
    </div>
</div>
@endsection