@extends('layouts.app')

@section('title', 'Dashboard Kepala SBUM - mySBUM')

@section('content')
<div class="space-y-6">
    
    <!-- Header Greeting -->
    <div class="space-y-1">
        <div class="flex items-center space-x-2 text-xs font-bold text-[#056839]">
            <span class="w-2 h-2 rounded-full bg-[#056839]"></span>
            <span class="uppercase tracking-wider">PORTAL KENDALI TERPADU SBUM</span>
        </div>
        <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Selamat Datang, Kepala Pengelola SBUM</h1>
        <p class="text-xs text-slate-500">Pusat Operasional Sarana Bersama & Urusan Mandiri Kampus Utama Politeknik Negeri Batam</p>
    </div>

    <!-- Filter Control Bar -->
    <div class="flex flex-wrap items-center gap-3">
        <button class="px-4 py-2 bg-[#056839] text-white font-bold text-xs rounded-xl shadow-sm">Minggu ini</button>
        <button class="px-4 py-2 bg-white text-slate-600 border border-slate-200 font-semibold text-xs rounded-xl hover:bg-slate-50">Bulan ini</button>
        <button class="px-4 py-2 bg-white text-slate-600 border border-slate-200 font-semibold text-xs rounded-xl hover:bg-slate-50">Custom</button>
        
        <input type="text" placeholder="mm/dd/yyyy" class="px-3 py-2 bg-white border border-slate-200 rounded-xl text-xs text-slate-600 focus:outline-none w-36">
        
        <select class="px-3 py-2 bg-white border border-slate-200 rounded-xl text-xs text-slate-600 font-semibold focus:outline-none">
            <option>Semua status</option>
        </select>

        <button class="px-4 py-2 bg-white text-slate-700 border border-slate-200 font-bold text-xs rounded-xl hover:bg-slate-50 flex items-center space-x-1">
            <span>&#8634; Muat ulang</span>
        </button>
    </div>

    <!-- 4 Top Metric Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div class="bg-white p-6 rounded-2xl border-l-4 border-l-[#056839] border border-slate-100 shadow-sm space-y-4">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">MENUNGGU VERIFIKASI</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">5</span>
            </div>
            <div class="inline-block bg-emerald-300 text-emerald-950 text-[11px] font-bold px-3 py-1 rounded-full">
                ! Butuh Tindakan Segera
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">TOTAL RUANGAN SIAP</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">24</span>
                <span class="text-sm font-semibold text-slate-600">Ruangan</span>
            </div>
            <p class="text-xs text-slate-400 font-medium pt-2">14 Dalam Peminjaman</p>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">DIPINJAM</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">5</span>
                <span class="text-sm font-semibold text-slate-600">Fasilitas</span>
            </div>
            <p class="text-xs text-slate-400 font-medium pt-2">7 Dalam Peminjaman</p>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">DISETUJUI</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">8</span>
                <span class="text-sm font-semibold text-slate-600">Fasilitas</span>
            </div>
        </div>
    </div>

    <!-- Chart & Activity Logs Row -->
    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
        
        <!-- Monitoring Telemetry Bar Chart -->
        <div class="lg:col-span-8 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-6">
            <div>
                <h3 class="text-base font-bold text-slate-900">Monitoring Okupansi & Tren Aktivitas Fasilitas</h3>
                <p class="text-xs text-slate-400">Data telemetri pemanfaatan ruangan dan peminjaman sarana real-time minggu ini</p>
            </div>

            <div class="bg-slate-50/70 p-6 rounded-2xl border border-slate-100 space-y-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h4 class="text-xs font-bold text-slate-800">Tren Peminjaman Mingguan</h4>
                        <p class="text-[10px] text-slate-400">Komparasi Peminjaman Fasilitas (Senin - Minggu)</p>
                    </div>
                    <div class="flex items-center space-x-4 text-[10px] font-bold">
                        <span class="flex items-center"><span class="w-2.5 h-2.5 rounded bg-[#056839] mr-1"></span> Selesai</span>
                        <span class="flex items-center"><span class="w-2.5 h-2.5 rounded bg-amber-500 mr-1"></span> Menunggu</span>
                        <span class="flex items-center"><span class="w-2.5 h-2.5 rounded bg-rose-200 mr-1"></span> Ditolak</span>
                    </div>
                </div>

                <div class="h-44 flex items-end justify-between px-4 pt-4 border-b border-slate-200 gap-3">
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-6"></div>
                        <div class="w-8 bg-amber-500 h-8"></div>
                        <div class="w-8 bg-[#056839] h-20"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Sen</span>
                    </div>
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-8"></div>
                        <div class="w-8 bg-amber-500 h-6"></div>
                        <div class="w-8 bg-[#056839] h-24"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Sel</span>
                    </div>
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-5"></div>
                        <div class="w-8 bg-amber-500 h-10"></div>
                        <div class="w-8 bg-[#056839] h-18"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Rab</span>
                    </div>
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-6"></div>
                        <div class="w-8 bg-amber-500 h-12"></div>
                        <div class="w-8 bg-[#056839] h-16"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Kam</span>
                    </div>
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-4"></div>
                        <div class="w-8 bg-amber-500 h-8"></div>
                        <div class="w-8 bg-[#056839] h-28"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Jum</span>
                    </div>
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-10"></div>
                        <div class="w-8 bg-amber-500 h-4"></div>
                        <div class="w-8 bg-[#056839] h-20"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Sab</span>
                    </div>
                    <div class="w-full flex flex-col items-center space-y-1">
                        <div class="w-8 bg-rose-200 rounded-t h-4"></div>
                        <div class="w-8 bg-amber-500 h-4"></div>
                        <div class="w-8 bg-[#056839] h-8"></div>
                        <span class="text-[10px] font-semibold text-slate-500 mt-2">Min</span>
                    </div>
                </div>

                <div class="flex items-center justify-between text-xs text-slate-600 font-semibold pt-1">
                    <span>Puncak penggunaan mingguan: <b>Jumat (84 Sesi)</b></span>
                    <span class="text-emerald-600 font-bold">&uarr; +14.2% vs minggu lalu</span>
                </div>
            </div>
        </div>

        <!-- Aktivitas Terkini -->
        <div class="lg:col-span-4 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex flex-col justify-between space-y-4">
            <div>
                <h3 class="text-base font-bold text-slate-900">Aktivitas Terkini</h3>
                <p class="text-xs text-slate-400">Log pembaruan sistem operasional</p>

                <div class="space-y-3 pt-4">
                    <div class="p-3 bg-slate-50 rounded-xl flex items-start space-x-3 text-xs">
                        <span class="w-2 h-2 rounded-full bg-emerald-500 mt-1.5 flex-shrink-0"></span>
                        <div>
                            <div class="flex items-center justify-between">
                                <span class="font-bold text-slate-800">10:23</span>
                                <span class="text-[10px] text-slate-400 font-medium">Peminjaman Disetujui</span>
                            </div>
                            <p class="text-[11px] text-slate-500 mt-0.5">Ruang Teori 401 - HIMA IF</p>
                        </div>
                    </div>

                    <div class="p-3 bg-slate-50 rounded-xl flex items-start space-x-3 text-xs">
                        <span class="w-2 h-2 rounded-full bg-blue-500 mt-1.5 flex-shrink-0"></span>
                        <div>
                            <div class="flex items-center justify-between">
                                <span class="font-bold text-slate-800">09:15</span>
                                <span class="text-[10px] text-slate-400 font-medium">Fasilitas Dikembalikan</span>
                            </div>
                            <p class="text-[11px] text-slate-500 mt-0.5">Auditorium - Acara BEM Selesai</p>
                        </div>
                    </div>
                </div>
            </div>

            <button class="w-full py-2.5 border border-slate-200 rounded-xl text-xs font-bold text-slate-700 hover:bg-slate-50 transition">
                Lihat Semua Aktivitas &gt;
            </button>
        </div>

    </div>

    <!-- Antrean Permohonan Masuk -->
    <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-4">
        <div class="flex items-center justify-between pb-2">
            <div>
                <h3 class="text-base font-bold text-slate-900">Antrean Permohonan Masuk</h3>
                <p class="text-xs text-slate-400">Verifikasi Tahap 3 (Final Otorisasi Admin SBUM)</p>
            </div>
            <span class="bg-emerald-300 text-emerald-950 text-[10px] font-bold px-3 py-1 rounded-full">5 Terkini</span>
        </div>

        <div class="space-y-3">
            <div class="p-4 bg-slate-50/80 rounded-2xl border border-slate-100 flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                <div class="flex items-center space-x-4">
                    <div class="w-10 h-10 rounded-xl bg-emerald-100 text-[#056839] flex items-center justify-center font-bold">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h18"></path></svg>
                    </div>
                    <div>
                        <h4 class="text-sm font-bold text-slate-900">Seminar Nasional AI & Karir Digital</h4>
                        <p class="text-xs text-slate-500">Pemohon: <b>BEM FT</b> &bull; 26 Nov 2025</p>
                        <p class="text-[11px] text-[#056839] font-bold mt-0.5">&boxbox; Auditorium Graha Widya + Sound System Set</p>
                    </div>
                </div>
                <a href="{{ route('kepala-sbum.persetujuan.index') }}" class="px-5 py-2.5 bg-[#056839] hover:bg-emerald-900 text-white font-bold text-xs rounded-xl shadow-sm transition whitespace-nowrap text-center">
                    Tinjau & Setujui
                </a>
            </div>
        </div>
    </div>

</div>
@endsection