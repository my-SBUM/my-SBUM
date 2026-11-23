<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Kepala SBUM - mySBUM</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Font Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>

<body class="bg-[#F8F9FC] text-[#1E293B] h-screen flex overflow-hidden">

    <!-- SIDEBAR FIXED (ROLE KEPALA SBUM) -->
    <aside class="w-64 bg-white border-r border-gray-100 flex flex-col justify-between hidden md:flex shrink-0 h-full">
        <div>
            <!-- Sidebar Header / Logo -->
            <div class="p-6 flex items-center justify-between border-b border-gray-50">
                <div class="flex items-center gap-3">
                    <div class="bg-[#006A4E] text-white p-2 rounded-xl flex items-center justify-center">
                        <i class="fa-solid fa-door-open text-lg"></i>
                    </div>
                    <div>
                        <h1 class="font-bold text-lg text-[#006A4E] leading-none">mySBUM</h1>
                        <span class="text-[10px] text-gray-400 font-semibold tracking-wider">POLIBATAM</span>
                    </div>
                </div>
                <button class="text-gray-400 hover:text-gray-600">
                    <i class="fa-regular fa-square-minus text-lg"></i>
                </button>
            </div>

            <!-- Menu Navigation (Kepala SBUM) -->
            <div class="p-4">
                <p class="text-[10px] font-bold text-gray-400 tracking-wider mb-3 px-3 uppercase">OPERASIONAL UTAMA</p>
                <nav class="space-y-1">
                    <!-- Active Menu: Dashboard -->
                    <a href="{{ route('kepala.dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl bg-[#006A4E] text-white font-medium text-sm transition-all shadow-sm">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ Route::has('persetujuan.kepala') ? route('persetujuan.kepala') : '#' }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <a href="{{ Route::has('kalender.kepala') ? route('kalender.kepala') : '#' }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-regular fa-calendar-days w-5"></i>
                        Kalender
                    </a>

                    <a href="{{ Route::has('admin.kepala') ? route('admin.kepala') : '#' }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-users-gear w-5"></i>
                        Kelola Admin
                    </a>
                </nav>
            </div>
        </div>

        <div class="p-4 border-t border-gray-50 text-center">
            <span class="text-[10px] text-gray-400">&copy; 2026 mySBUM Polibatam</span>
        </div>
    </aside>

    <!-- MAIN WRAPPER AREA -->
    <div class="flex-grow flex flex-col min-w-0 h-full overflow-hidden">

        <!-- TOP NAVBAR / HEADER -->
        <header class="h-20 bg-white border-b border-gray-100 flex items-center justify-between px-6 md:px-10 shrink-0">
            <div class="flex items-center gap-4">
                <button class="md:hidden text-gray-500 hover:text-gray-700">
                    <i class="fa-solid fa-bars text-xl"></i>
                </button>
            </div>

            <!-- Profile User dengan Dropdown Hover -->
            <div class="relative group cursor-pointer py-2">
                <div class="flex items-center gap-3">
                    <div class="text-right hidden sm:block">
                        <h2 class="text-sm font-bold text-gray-800 leading-tight">
                            {{ Auth::user()->name ?? 'Dr. Ir. Hendra W.' }}
                        </h2>
                        <p class="text-xs text-gray-400 capitalize">
                            {{ Auth::user()->role ?? 'Koordinator Lab' }}
                        </p>
                    </div>
                    <div
                        class="w-10 h-10 rounded-full bg-[#006A4E] text-white flex items-center justify-center font-bold text-sm">
                        <i class="fa-regular fa-user"></i>
                    </div>
                    <i
                        class="fa-solid fa-chevron-down text-xs text-gray-400 group-hover:rotate-180 transition-transform"></i>
                </div>

                <div class="absolute right-0 top-full w-44 pt-2 hidden group-hover:block z-50">
                    <div class="bg-white rounded-xl shadow-lg border border-gray-100 relative">
                        <div
                            class="absolute -top-1.5 right-4 w-3 h-3 bg-white border-t border-l border-gray-100 rotate-45">
                        </div>
                        <div class="py-2 relative z-10">
                            <a href="{{ route('profile.edit') }}"
                                class="flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-gray-700 hover:bg-gray-50 hover:text-[#006A4E] transition-colors">
                                <i class="fa-regular fa-user text-gray-400 w-4"></i>
                                Akun Saya
                            </a>
                            <div class="border-t border-gray-100 my-1"></div>
                            <form action="{{ route('logout') }}" method="POST">
                                @csrf
                                <button type="submit"
                                    class="w-full flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-red-600 hover:bg-red-50 transition-colors text-left">
                                    <i class="fa-solid fa-right-from-bracket text-red-500 w-4"></i>
                                    Log Out
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- DASHBOARD CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Banner Welcome Section -->
            <div class="space-y-1">
                <div class="flex items-center gap-2 text-[11px] font-bold text-[#006A4E] tracking-wider uppercase">
                    <span class="w-2 h-2 rounded-full bg-[#006A4E]"></span>
                    PORTAL KENDALI TERPADU SBUM
                </div>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Selamat Datang, Kepala Pengelola SBUM</h1>
                <p class="text-xs text-gray-400">
                    Pusat Operasional Sarana Bersama & Urusan Mandiri &bull; Kampus Utama Politeknik Negeri Batam
                </p>
            </div>

            <!-- Filter Toolbar Bar -->
            <div class="flex flex-wrap items-center gap-3">
                <div class="flex items-center bg-gray-100 p-1 rounded-xl text-xs font-semibold">
                    <button class="px-4 py-2 bg-[#006A4E] text-white rounded-lg shadow-sm">Minggu ini</button>
                    <button class="px-4 py-2 text-gray-600 hover:text-gray-800">Bulan ini</button>
                    <button class="px-4 py-2 text-gray-600 hover:text-gray-800">Custom</button>
                </div>

                <div class="relative">
                    <input type="text" placeholder="mm/dd/yyyy"
                        class="bg-white border border-gray-200 text-gray-600 text-xs rounded-xl px-3.5 py-2 pr-8 focus:outline-none focus:ring-1 focus:ring-[#006A4E]">
                    <i class="fa-regular fa-calendar absolute right-3 top-2.5 text-gray-400 text-xs"></i>
                </div>

                <div class="relative">
                    <select
                        class="appearance-none bg-white border border-gray-200 text-gray-600 text-xs rounded-xl px-3.5 py-2 pr-8 focus:outline-none focus:ring-1 focus:ring-[#006A4E]">
                        <option>Semua status</option>
                        <option>Disetujui</option>
                        <option>Menunggu</option>
                    </select>
                    <i class="fa-solid fa-chevron-down absolute right-3 top-2.5 text-gray-400 text-[10px]"></i>
                </div>

                <button
                    class="bg-white border border-gray-200 text-gray-600 text-xs font-semibold px-4 py-2 rounded-xl hover:bg-gray-50 flex items-center gap-2">
                    <i class="fa-solid fa-rotate text-xs"></i> Muat ulang
                </button>
            </div>

            <!-- Overview Cards (4 Grid) -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">

                <!-- Card 1: Menunggu Verifikasi -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-4 border-l-[#006A4E] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">MENUNGGU
                            VERIFIKASI</span>
                        <div class="text-3xl font-bold text-gray-800 mt-2">5</div>
                    </div>
                    <div class="mt-4">
                        <span
                            class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-bold bg-[#56E39F] text-[#004D39]">
                            ! Butuh Tindakan Segera
                        </span>
                    </div>
                </div>

                <!-- Card 2: Total Ruangan Siap -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">TOTAL RUANGAN
                            SIAP</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">24</span>
                            <span class="text-xs text-gray-400 font-medium">Ruangan</span>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Dipinjam -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">DIPINJAM</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">5</span>
                            <span class="text-xs text-gray-400 font-medium">Fasilitas</span>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Disetujui -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">DISETUJUI</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">8</span>
                            <span class="text-xs text-gray-400 font-medium">Fasilitas</span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Middle Section: Chart & Recent Activity (2 Columns) -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                <!-- Left: Monitoring Okupansi (Span 2) -->
                <div
                    class="lg:col-span-2 bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="flex items-center gap-3 mb-4">
                            <div
                                class="w-9 h-9 rounded-xl bg-emerald-50 text-[#006A4E] flex items-center justify-center shrink-0">
                                <i class="fa-solid fa-chart-simple text-sm"></i>
                            </div>
                            <div>
                                <h3 class="font-bold text-gray-800 text-sm">Monitoring Okupansi & Tren Aktivitas
                                    Fasilitas</h3>
                                <p class="text-[11px] text-gray-400">Data telemetri pemanfaatan ruangan dan peminjaman
                                    sarana real-time minggu ini</p>
                            </div>
                        </div>

                        <!-- Inner Chart Card Container -->
                        <div class="bg-[#F8FAFC] rounded-2xl p-5 border border-gray-100">
                            <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-2 mb-6">
                                <div>
                                    <h4 class="font-bold text-xs text-gray-800">Tren Peminjaman Mingguan</h4>
                                    <p class="text-[10px] text-gray-400">Komparasi Peminjaman Fasilitas (Senin - Minggu)
                                    </p>
                                </div>
                                <!-- Legend -->
                                <div class="flex items-center gap-3 text-[10px] font-semibold">
                                    <span class="flex items-center gap-1 text-gray-600">
                                        <span class="w-2.5 h-2.5 rounded bg-[#006A4E]"></span> Selesai
                                    </span>
                                    <span class="flex items-center gap-1 text-gray-600">
                                        <span class="w-2.5 h-2.5 rounded bg-amber-500"></span> Menunggu
                                    </span>
                                    <span class="flex items-center gap-1 text-gray-600">
                                        <span class="w-2.5 h-2.5 rounded bg-rose-200"></span> Ditolak
                                    </span>
                                </div>
                            </div>

                            <!-- Stacked Bar Chart Visual Mockup -->
                            <div class="h-44 flex items-end justify-between gap-3 px-4 pt-4 border-b border-gray-200">
                                <!-- Sen -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-rose-200 rounded-t h-[20%]"></div>
                                    <div class="w-6 bg-amber-500 h-[30%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[40%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Sen</span>
                                </div>
                                <!-- Sel -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-amber-500 rounded-t h-[35%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[45%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Sel</span>
                                </div>
                                <!-- Rab -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-rose-200 rounded-t h-[15%]"></div>
                                    <div class="w-6 bg-amber-500 h-[40%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[35%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Rab</span>
                                </div>
                                <!-- Kam -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-rose-200 rounded-t h-[20%]"></div>
                                    <div class="w-6 bg-amber-500 h-[35%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[35%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Kam</span>
                                </div>
                                <!-- Jum -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-rose-200 rounded-t h-[10%]"></div>
                                    <div class="w-6 bg-amber-500 h-[25%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[55%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Jum</span>
                                </div>
                                <!-- Sab -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-rose-200 rounded-t h-[25%]"></div>
                                    <div class="w-6 bg-amber-500 h-[30%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[40%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Sab</span>
                                </div>
                                <!-- Min -->
                                <div class="flex-1 flex flex-col items-center gap-1 h-full justify-end">
                                    <div class="w-6 bg-amber-500 rounded-t h-[20%]"></div>
                                    <div class="w-6 bg-[#006A4E] rounded-b h-[20%]"></div>
                                    <span class="text-[10px] font-semibold text-gray-400 mt-2">Min</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer Note -->
                    <div
                        class="mt-4 pt-3 border-t border-gray-50 flex items-center justify-between text-[11px] text-gray-500">
                        <span>Puncak penggunaan mingguan: <strong class="text-gray-800">Jumat (84 Sesi)</strong></span>
                        <span class="text-emerald-600 font-semibold"><i class="fa-solid fa-arrow-trend-up"></i> +14.2%
                            vs minggu lalu</span>
                    </div>
                </div>

                <!-- Right: Aktivitas Terkini (Span 1) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <h3 class="font-bold text-gray-800 text-sm">Aktivitas Terkini</h3>
                        <p class="text-[11px] text-gray-400 mb-4">Log pembaruan sistem operasional</p>

                        <!-- Activity List -->
                        <div class="space-y-3">
                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-center gap-3">
                                <span class="w-2.5 h-2.5 rounded-full bg-emerald-500 shrink-0"></span>
                                <div class="text-[11px]">
                                    <span class="text-gray-400 font-medium">10:23</span>
                                    <p class="font-bold text-gray-800">Peminjaman Disetujui</p>
                                    <p class="text-gray-400 text-[10px]">Ruang Teori 401 - HIMA IF</p>
                                </div>
                            </div>

                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-center gap-3">
                                <span class="w-2.5 h-2.5 rounded-full bg-blue-500 shrink-0"></span>
                                <div class="text-[11px]">
                                    <span class="text-gray-400 font-medium">09:15</span>
                                    <p class="font-bold text-gray-800">Fasilitas Dikembalikan</p>
                                    <p class="text-gray-400 text-[10px]">Auditorium - Acara BEM Selesai</p>
                                </div>
                            </div>

                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-center gap-3">
                                <span class="w-2.5 h-2.5 rounded-full bg-amber-500 shrink-0"></span>
                                <div class="text-[11px]">
                                    <span class="text-gray-400 font-medium">08:45</span>
                                    <p class="font-bold text-gray-800">Permohonan Baru</p>
                                    <p class="text-gray-400 text-[10px]">Lab Komputer Dasar 2 - Pengganti</p>
                                </div>
                            </div>

                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-center gap-3">
                                <span class="w-2.5 h-2.5 rounded-full bg-rose-500 shrink-0"></span>
                                <div class="text-[11px]">
                                    <span class="text-gray-400 font-medium">07:30</span>
                                    <p class="font-bold text-gray-800">Laporan Kerusakan</p>
                                    <p class="text-gray-400 text-[10px]">AC Ruang Dosen FT Bermasalah</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <button
                        class="w-full mt-4 py-2.5 border border-gray-200 text-gray-600 rounded-xl text-xs font-bold hover:bg-gray-50 transition-all">
                        Lihat Semua Aktivitas &gt;
                    </button>
                </div>

            </div>

            <!-- Bottom Section: Antrean Permohonan Masuk -->
            <div class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] space-y-4">

                <div class="flex items-center justify-between">
                    <div class="border-l-4 border-l-[#006A4E] pl-3">
                        <h3 class="font-bold text-gray-800 text-sm">Antrean Permohonan Masuk</h3>
                        <p class="text-[11px] text-gray-400">Verifikasi Tahap 3 (Final Otorisasi Admin SBUM)</p>
                    </div>
                    <span class="px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#56E39F] text-[#004D39]">
                        5 Terkini
                    </span>
                </div>

                <!-- List Items (3 Cards) -->
                <div class="space-y-3">

                    <!-- Item 1 -->
                    <div
                        class="bg-[#F8FAFC] rounded-2xl p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex items-center gap-3">
                            <div
                                class="w-10 h-10 rounded-xl bg-emerald-100 text-[#006A4E] flex items-center justify-center shrink-0">
                                <i class="fa-solid fa-bullhorn text-sm"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-xs">Seminar Nasional AI &amp; Karir Digital</h4>
                                <p class="text-[10px] text-gray-400">Pemohon: <span
                                        class="font-semibold text-gray-600">BEM FT</span> &bull; 26 Nov 2025</p>
                                <p class="text-[11px] text-[#006A4E] font-medium mt-0.5"><i
                                        class="fa-solid fa-building text-[10px]"></i> Auditorium Graha Widya + Sound
                                    System Set</p>
                            </div>
                        </div>

                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold px-5 py-2.5 rounded-xl transition-all shrink-0">
                            Tinjau &amp; Setujui
                        </button>
                    </div>

                    <!-- Item 2 -->
                    <div
                        class="bg-[#F8FAFC] rounded-2xl p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex items-center gap-3">
                            <div
                                class="w-10 h-10 rounded-xl bg-emerald-100 text-[#006A4E] flex items-center justify-center shrink-0">
                                <i class="fa-solid fa-bullhorn text-sm"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-xs">Seminar Nasional AI &amp; Karir Digital</h4>
                                <p class="text-[10px] text-gray-400">Pemohon: <span
                                        class="font-semibold text-gray-600">BEM FT</span> &bull; 26 Nov 2025</p>
                                <p class="text-[11px] text-[#006A4E] font-medium mt-0.5"><i
                                        class="fa-solid fa-building text-[10px]"></i> Auditorium Graha Widya + Sound
                                    System Set</p>
                            </div>
                        </div>

                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold px-5 py-2.5 rounded-xl transition-all shrink-0">
                            Tinjau &amp; Setujui
                        </button>
                    </div>

                    <!-- Item 3 -->
                    <div
                        class="bg-[#F8FAFC] rounded-2xl p-4 flex flex-col md:flex-row md:items-center justify-between gap-4">
                        <div class="flex items-center gap-3">
                            <div
                                class="w-10 h-10 rounded-xl bg-emerald-100 text-[#006A4E] flex items-center justify-center shrink-0">
                                <i class="fa-solid fa-bullhorn text-sm"></i>
                            </div>
                            <div>
                                <h4 class="font-bold text-gray-800 text-xs">Seminar Nasional AI &amp; Karir Digital</h4>
                                <p class="text-[10px] text-gray-400">Pemohon: <span
                                        class="font-semibold text-gray-600">BEM FT</span> &bull; 26 Nov 2025</p>
                                <p class="text-[11px] text-[#006A4E] font-medium mt-0.5"><i
                                        class="fa-solid fa-building text-[10px]"></i> Auditorium Graha Widya + Sound
                                    System Set</p>
                            </div>
                        </div>

                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold px-5 py-2.5 rounded-xl transition-all shrink-0">
                            Tinjau &amp; Setujui
                        </button>
                    </div>

                </div>

                <div class="text-right pt-2">
                    <a href="#" class="text-xs font-bold text-[#006A4E] hover:underline">
                        Lihat Semua Antrean Verifikasi (5) &rarr;
                    </a>
                </div>

            </div>

        </main>
    </div>

</body>

</html>