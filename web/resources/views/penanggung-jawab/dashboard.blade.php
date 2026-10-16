@extends('layouts.app')

@section('title', 'Halaman Dashboard - mySBUM')

@section('content')
<div class="space-y-6">
    <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Halaman Dashborad</h1>

    <!-- 3 Top Cards -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Card 1 -->
        <div class="bg-white p-6 rounded-2xl border-l-4 border-l-[#056839] border border-slate-100 shadow-sm space-y-4">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">PERLU DISETUJUI</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">5</span>
                <span class="text-sm font-semibold text-slate-600">Fasilitas</span>
            </div>
            <div class="inline-block bg-emerald-300 text-emerald-950 text-[11px] font-bold px-3 py-1 rounded-full">
                ! Butuh Tindakan Segera
            </div>
        </div>

        <!-- Card 2 -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">TOTAL RUANGAN</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">22</span>
                <span class="text-sm font-semibold text-slate-600">Ruangan</span>
            </div>
            <p class="text-xs text-slate-400 font-medium pt-2">14 Dalam Peminjaman</p>
        </div>

        <!-- Card 3 -->
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">TOTAL PERALATAN</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">7</span>
                <span class="text-sm font-semibold text-slate-600">Peralatan</span>
            </div>
            <p class="text-xs text-slate-400 font-medium pt-2">7 Dalam Peminjaman</p>
        </div>
    </div>

    <!-- Content Grid -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
        
        <!-- Peminjaman yang diajukan Table -->
        <div class="lg:col-span-8 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-6">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-base font-bold text-slate-900">Peminjaman yang diajukan</h2>
                    <p class="text-xs text-slate-400">Peminjaman yang baru - baru ini diajukan</p>
                </div>
                <a href="{{ route('pj.persetujuan.index') }}" class="text-xs font-bold text-[#056839] hover:underline flex items-center space-x-1">
                    <span>Lihat Semua (5)</span>
                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                </a>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="text-[10px] font-bold text-slate-400 uppercase tracking-wider border-b border-slate-100 pb-2">
                            <th class="pb-3 font-semibold">ITEM PEMINJAMAN</th>
                            <th class="pb-3 font-semibold">KATEGORI & WAKTU</th>
                            <th class="pb-3 font-semibold text-right">STATUS</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100 text-xs">
                        <!-- Row 1 -->
                        <tr>
                            <td class="py-3.5 flex items-center space-x-3">
                                <div class="w-9 h-9 rounded-full bg-[#056839] text-white flex items-center justify-center flex-shrink-0">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path></svg>
                                </div>
                                <div>
                                    <p class="font-bold text-slate-800">Scanner Epson</p>
                                    <p class="text-[10px] text-slate-400">PIC: Andi Wijaya</p>
                                </div>
                            </td>
                            <td class="py-3.5">
                                <p class="font-semibold text-slate-800">Non-Akademik BDE8</p>
                                <p class="text-[10px] text-slate-400">16 Juli 2026 - 07:15 - 10:15</p>
                            </td>
                            <td class="py-3.5 text-right">
                                <span class="bg-amber-500 text-white text-[10px] font-bold px-3 py-1 rounded-md uppercase">MENUNGGU</span>
                            </td>
                        </tr>

                        <!-- Row 2 -->
                        <tr>
                            <td class="py-3.5 flex items-center space-x-3">
                                <div class="w-9 h-9 rounded-full bg-[#056839] text-white flex items-center justify-center flex-shrink-0">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
                                </div>
                                <div>
                                    <p class="font-bold text-slate-800">Ruang Rapat Besar B302</p>
                                    <p class="text-[10px] text-slate-400">PIC: Andi Wijaya</p>
                                </div>
                            </td>
                            <td class="py-3.5">
                                <p class="font-semibold text-slate-800">Akademik 4038</p>
                                <p class="text-[10px] text-slate-400">18 Juli 2026 - 11:30 - 14:30</p>
                            </td>
                            <td class="py-3.5 text-right">
                                <span class="bg-rose-500 text-white text-[10px] font-bold px-3 py-1 rounded-md uppercase">DITOLAK</span>
                            </td>
                        </tr>

                        <!-- Row 3 & 4 -->
                        <tr>
                            <td class="py-3.5 flex items-center space-x-3">
                                <div class="w-9 h-9 rounded-full bg-[#056839] text-white flex items-center justify-center flex-shrink-0">
                                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path></svg>
                                </div>
                                <div>
                                    <p class="font-bold text-slate-800">Scanner Epson</p>
                                    <p class="text-[10px] text-slate-400">PIC: Andi Wijaya</p>
                                </div>
                            </td>
                            <td class="py-3.5">
                                <p class="font-semibold text-slate-800">Non-Akademik BDE8</p>
                                <p class="text-[10px] text-slate-400">16 Juli 2026 - 07:15 - 10:15</p>
                            </td>
                            <td class="py-3.5 text-right">
                                <span class="bg-[#056839] text-white text-[10px] font-bold px-3 py-1 rounded-md uppercase">DITERIMA</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Aktivitas Terbaru Sidebar Card -->
        <div class="lg:col-span-4 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-4 flex flex-col justify-between">
            <div>
                <div class="flex items-center justify-between pb-3 border-b border-slate-100">
                    <div class="flex items-center space-x-2">
                        <svg class="w-4 h-4 text-[#056839]" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                        <h3 class="text-sm font-bold text-slate-900">Aktivitas Terbaru</h3>
                    </div>
                    <span class="bg-emerald-300 text-emerald-950 text-[10px] font-bold px-2.5 py-0.5 rounded-full">Disetujui</span>
                </div>

                <div class="space-y-3 pt-4">
                    <!-- Activity 1 -->
                    <div class="bg-slate-50 p-3 rounded-xl flex items-start space-x-3 border border-slate-100">
                        <div class="w-6 h-6 rounded-full bg-amber-100 text-amber-600 flex items-center justify-center font-bold text-xs flex-shrink-0 mt-0.5">!</div>
                        <div>
                            <div class="flex items-center justify-between">
                                <p class="text-xs font-bold text-slate-800">Peminjaman Dibat..</p>
                                <span class="text-[9px] text-slate-400">Hari ini, 09:30 WIB</span>
                            </div>
                            <p class="text-[10px] text-slate-500 mt-0.5">Kamera DSLR Canon EOS dibatalkan oleh Budi Santoso.</p>
                        </div>
                    </div>

                    <!-- Activity 2 -->
                    <div class="bg-slate-50 p-3 rounded-xl flex items-start space-x-3 border border-slate-100">
                        <div class="w-6 h-6 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center font-bold text-xs flex-shrink-0 mt-0.5">&#10003;</div>
                        <div>
                            <div class="flex items-center justify-between">
                                <p class="text-xs font-bold text-slate-800">Peminjaman Baru</p>
                                <span class="text-[9px] text-slate-400">Kemarin, 14:15 WIB</span>
                            </div>
                            <p class="text-[10px] text-slate-500 mt-0.5">Scanner Epson diajukan oleh Budi Santoso, perlu persetujuan.</p>
                        </div>
                    </div>
                </div>
            </div>

            <a href="#" class="w-full text-center py-2 border border-slate-200 rounded-xl text-xs font-bold text-slate-700 hover:bg-slate-50 transition">
                Lihat Semua Aktivitas &gt;
            </a>
        </div>

    </div>
</div>
@endsection