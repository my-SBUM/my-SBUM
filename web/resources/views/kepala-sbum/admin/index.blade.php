@extends('layouts.app')

@section('title', 'Kelola Admin - mySBUM')

@section('content')
<div class="space-y-6">
    
    <!-- Title & Action Button -->
    <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
        <div>
            <div class="text-xs text-slate-400 font-medium mb-1">
                <span>Dashboard</span> &rsaquo; <span class="text-[#056839] font-bold">Kelola Admin</span>
            </div>
            <h1 class="text-3xl font-extrabold text-slate-900 tracking-tight">Kelola Admin</h1>
            <p class="text-xs text-slate-500 mt-1">Kelola hak akses, tambah admin baru, dan hapus</p>
        </div>

        <button class="px-5 py-2.5 bg-[#056839] hover:bg-emerald-900 text-white font-bold text-xs rounded-xl shadow-sm transition flex items-center space-x-2">
            <span class="text-base font-bold">+</span>
            <span>Tambah Admin Baru</span>
        </button>
    </div>

    <!-- 4 Summary Stat Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">TOTAL PENGGUNA AKTIF</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">45</span>
                <span class="text-xs text-slate-500 font-medium">Akun</span>
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">PIC LABORATORIUM</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">12</span>
                <span class="text-xs text-slate-500 font-medium">PIC</span>
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">DOSEN PEMBINA</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-slate-900">30</span>
                <span class="text-xs text-slate-500 font-medium">Dosen</span>
            </div>
        </div>

        <div class="bg-white p-6 rounded-2xl border-l-4 border-l-amber-500 border border-slate-100 shadow-sm space-y-2">
            <span class="text-[10px] font-bold text-slate-400 tracking-wider uppercase">AKUN NONAKTIF / SUSPEND</span>
            <div class="flex items-baseline space-x-2">
                <span class="text-4xl font-extrabold text-amber-600">3</span>
                <span class="text-xs text-slate-500 font-medium">Akun</span>
            </div>
        </div>
    </div>

    <!-- Data Table Container -->
    <div class="bg-white rounded-2xl border border-slate-100 shadow-sm p-6 space-y-6">
        
        <!-- Table Search Bar -->
        <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
            <h3 class="text-base font-bold text-slate-900">Daftar Administrator & Otoritas</h3>
            
            <div class="relative w-full sm:w-72">
                <svg class="w-4 h-4 text-slate-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                <input type="text" placeholder="Cari nama atau NIP..." 
                       class="w-full pl-9 pr-4 py-2 text-xs bg-slate-50 border-none rounded-xl focus:ring-2 focus:ring-[#056839]">
            </div>
        </div>

        <!-- Table Content -->
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <thead>
                    <tr class="text-[10px] font-bold text-slate-400 uppercase tracking-wider border-b border-slate-100 pb-2">
                        <th class="pb-3 font-semibold">PENGGUNA & NIP</th>
                        <th class="pb-3 font-semibold">DEPARTEMEN / UNIT KERJA</th>
                        <th class="pb-3 font-semibold">STATUS</th>
                        <th class="pb-3 font-semibold text-right">AKSI</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100 text-xs">
                    
                    <!-- Row 1 -->
                    <tr>
                        <td class="py-4 flex items-center space-x-3">
                            <div class="w-10 h-10 rounded-full bg-amber-400 overflow-hidden flex-shrink-0">
                                <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=150&q=80" class="w-full h-full object-cover">
                            </div>
                            <div>
                                <p class="font-bold text-slate-900">Dr. Ir. Hendra W.</p>
                                <p class="text-[10px] text-slate-400">NIP: 1978051201</p>
                            </div>
                        </td>
                        <td class="py-4 text-slate-700 font-medium">Pusat Operasional Sarana</td>
                        <td class="py-4">
                            <span class="inline-flex items-center bg-emerald-100 text-emerald-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">
                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-600 mr-1.5"></span> Aktif
                            </span>
                        </td>
                        <td class="py-4 text-right">
                            <div class="flex items-center justify-end space-x-2">
                                <button class="px-3 py-1.5 bg-coral-500 bg-orange-500 hover:bg-orange-600 text-white font-bold text-xs rounded-lg transition">Edit</button>
                                <button class="px-3 py-1.5 bg-rose-500 hover:bg-rose-600 text-white font-bold text-xs rounded-lg transition">Hapus</button>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 2 -->
                    <tr>
                        <td class="py-4 flex items-center space-x-3">
                            <div class="w-10 h-10 rounded-full bg-purple-400 overflow-hidden flex-shrink-0">
                                <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80" class="w-full h-full object-cover">
                            </div>
                            <div>
                                <p class="font-bold text-slate-900">Ahmad Zulfikar, M.T.</p>
                                <p class="text-[10px] text-slate-400">NIP: 1985032204</p>
                            </div>
                        </td>
                        <td class="py-4 text-slate-700 font-medium">Jurusan Teknik Informatika</td>
                        <td class="py-4">
                            <span class="inline-flex items-center bg-emerald-100 text-emerald-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">
                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-600 mr-1.5"></span> Aktif
                            </span>
                        </td>
                        <td class="py-4 text-right">
                            <div class="flex items-center justify-end space-x-2">
                                <button class="px-3 py-1.5 bg-orange-500 hover:bg-orange-600 text-white font-bold text-xs rounded-lg transition">Edit</button>
                                <button class="px-3 py-1.5 bg-rose-500 hover:bg-rose-600 text-white font-bold text-xs rounded-lg transition">Hapus</button>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 3 -->
                    <tr>
                        <td class="py-4 flex items-center space-x-3">
                            <div class="w-10 h-10 rounded-full bg-yellow-400 overflow-hidden flex-shrink-0">
                                <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80" class="w-full h-full object-cover">
                            </div>
                            <div>
                                <p class="font-bold text-slate-900">Siti Rahmawati, S.E.</p>
                                <p class="text-[10px] text-slate-400">NIP: 1990081502</p>
                            </div>
                        </td>
                        <td class="py-4 text-slate-700 font-medium">Jurusan Manajemen Bisnis</td>
                        <td class="py-4">
                            <span class="inline-flex items-center bg-emerald-100 text-emerald-800 text-[10px] font-bold px-2.5 py-0.5 rounded-full">
                                <span class="w-1.5 h-1.5 rounded-full bg-emerald-600 mr-1.5"></span> Aktif
                            </span>
                        </td>
                        <td class="py-4 text-right">
                            <div class="flex items-center justify-end space-x-2">
                                <button class="px-3 py-1.5 bg-orange-500 hover:bg-orange-600 text-white font-bold text-xs rounded-lg transition">Edit</button>
                                <button class="px-3 py-1.5 bg-rose-500 hover:bg-rose-600 text-white font-bold text-xs rounded-lg transition">Hapus</button>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 4 -->
                    <tr>
                        <td class="py-4 flex items-center space-x-3">
                            <div class="w-10 h-10 rounded-full bg-amber-400 overflow-hidden flex-shrink-0">
                                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=150&q=80" class="w-full h-full object-cover">
                            </div>
                            <div>
                                <p class="font-bold text-slate-900">Rudi Hermawan</p>
                                <p class="text-[10px] text-slate-400">NIP: 1982110903</p>
                            </div>
                        </td>
                        <td class="py-4 text-slate-700 font-medium">Jurusan Teknik Elektro</td>
                        <td class="py-4">
                            <span class="inline-flex items-center bg-slate-100 text-slate-600 text-[10px] font-bold px-2.5 py-0.5 rounded-full">
                                <span class="w-1.5 h-1.5 rounded-full bg-slate-400 mr-1.5"></span> Nonaktif
                            </span>
                        </td>
                        <td class="py-4 text-right">
                            <div class="flex items-center justify-end space-x-2">
                                <button class="px-3 py-1.5 bg-orange-500 hover:bg-orange-600 text-white font-bold text-xs rounded-lg transition">Edit</button>
                                <button class="px-3 py-1.5 bg-rose-500 hover:bg-rose-600 text-white font-bold text-xs rounded-lg transition">Hapus</button>
                            </div>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>

        <!-- Pagination Bar -->
        <div class="pt-4 flex items-center justify-between text-xs text-slate-500">
            <p>Menampilkan <b>1 - 4</b> dari <b>45</b> pengguna</p>
            <div class="flex items-center space-x-2 font-bold">
                <button class="w-8 h-8 rounded-lg bg-slate-100 text-slate-400 flex items-center justify-center cursor-not-allowed">&lsaquo;</button>
                <button class="w-8 h-8 rounded-lg bg-[#056839] text-white flex items-center justify-center">1</button>
                <button class="w-8 h-8 rounded-lg hover:bg-slate-100 text-slate-700 flex items-center justify-center">2</button>
                <button class="w-8 h-8 rounded-lg hover:bg-slate-100 text-slate-700 flex items-center justify-center">3</button>
                <button class="w-8 h-8 rounded-lg hover:bg-slate-100 text-slate-700 flex items-center justify-center">&rsaquo;</button>
            </div>
        </div>

    </div>

</div>
@endsection