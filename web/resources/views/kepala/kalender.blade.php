<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kalender Peminjaman - Kepala SBUM</title>
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
                    <a href="{{ route('kepala.dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ route('persetujuan.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <!-- Active Menu: Kalender -->
                    <a href="{{ route('kalender.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl bg-[#006A4E] text-white font-medium text-sm transition-all shadow-sm">
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
                            <a href="#"
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

        <!-- MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Breadcrumb, Title & Export Buttons -->
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                        <a href="{{ route('kepala.dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                        <span>&gt;</span>
                        <span class="text-[#006A4E] font-semibold">Kalender</span>
                    </nav>
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Kalender Peminjaman</h1>
                    <p class="text-xs text-gray-500 mt-1">
                        Lihat semua peminjaman ruangan dan alat dalam tampilan kalender.
                    </p>
                </div>

                <!-- Export Action Buttons -->
                <div class="flex items-center gap-3 shrink-0">
                    <button
                        class="px-4 py-2.5 border border-red-500 text-red-600 hover:bg-red-50 font-bold text-xs rounded-xl transition-all flex items-center gap-2">
                        <i class="fa-regular fa-file-pdf text-sm"></i> Download PDF
                    </button>
                    <button
                        class="px-4 py-2.5 bg-[#006A4E] hover:bg-[#004D39] text-white font-bold text-xs rounded-xl transition-all flex items-center gap-2 shadow-sm">
                        <i class="fa-regular fa-file-excel text-sm"></i> Download Excel
                    </button>
                </div>
            </div>

            <!-- Stats Grid & Filter Bar -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6 items-center">

                <!-- Stat Cards (4 Grid) -->
                <div class="lg:col-span-2 grid grid-cols-2 sm:grid-cols-4 gap-4">
                    <!-- Total Aktif -->
                    <div
                        class="bg-white p-4 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                        <div>
                            <span class="text-[10px] font-bold text-gray-400 uppercase">Total aktif</span>
                            <div class="text-2xl font-bold text-gray-800 mt-1">35</div>
                        </div>
                        <i class="fa-regular fa-calendar text-gray-400 text-base"></i>
                    </div>

                    <!-- Menunggu -->
                    <div
                        class="bg-white p-4 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                        <div>
                            <span class="text-[10px] font-bold text-amber-600 uppercase">Menunggu</span>
                            <div class="text-2xl font-bold text-gray-800 mt-1">16</div>
                        </div>
                        <div class="w-7 h-7 rounded-full bg-amber-100 text-amber-600 flex items-center justify-center">
                            <i class="fa-regular fa-clock text-xs"></i>
                        </div>
                    </div>

                    <!-- Disetujui -->
                    <div
                        class="bg-white p-4 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                        <div>
                            <span class="text-[10px] font-bold text-emerald-600 uppercase">Disetujui</span>
                            <div class="text-2xl font-bold text-gray-800 mt-1">19</div>
                        </div>
                        <div
                            class="w-7 h-7 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center">
                            <i class="fa-regular fa-circle-check text-xs"></i>
                        </div>
                    </div>

                    <!-- Ruangan -->
                    <div
                        class="bg-white p-4 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                        <div>
                            <span class="text-[10px] font-bold text-indigo-600 uppercase">Ruangan</span>
                            <div class="text-2xl font-bold text-gray-800 mt-1">22</div>
                        </div>
                        <i class="fa-regular fa-building text-indigo-500 text-base"></i>
                    </div>
                </div>

                <!-- Filters Dropdown (Jenis & Status Peminjaman) -->
                <div class="grid grid-cols-2 gap-3">
                    <div class="relative">
                        <label class="text-[10px] font-semibold text-gray-400 block mb-1">Jenis peminjaman</label>
                        <select
                            class="w-full appearance-none bg-white border border-gray-200 text-gray-700 text-xs font-semibold py-2.5 pl-3 pr-8 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#006A4E]">
                            <option>Semua</option>
                            <option>Ruangan</option>
                            <option>Alat</option>
                        </select>
                        <i class="fa-solid fa-chevron-down absolute right-3 bottom-3 text-gray-400 text-[10px]"></i>
                    </div>

                    <div class="relative">
                        <label class="text-[10px] font-semibold text-gray-400 block mb-1">Status peminjaman</label>
                        <select
                            class="w-full appearance-none bg-white border border-gray-200 text-gray-700 text-xs font-semibold py-2.5 pl-3 pr-8 rounded-xl focus:outline-none focus:ring-1 focus:ring-[#006A4E]">
                            <option>Semua</option>
                            <option>Menunggu</option>
                            <option>Disetujui</option>
                            <option>Ditolak</option>
                        </select>
                        <i class="fa-solid fa-chevron-down absolute right-3 bottom-3 text-gray-400 text-[10px]"></i>
                    </div>
                </div>

            </div>

            <!-- Main Calendar Section (Calendar Grid + Selected Day Details) -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                <!-- Left: Full Calendar View (Span 2) -->
                <div
                    class="lg:col-span-2 bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] space-y-6">

                    <!-- Calendar Header Controls -->
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                        <div>
                            <span class="text-[10px] font-bold text-gray-400 uppercase tracking-wider">Bulan</span>
                            <h2 class="text-xl font-bold text-gray-800">Juli 2026</h2>
                        </div>

                        <div class="flex items-center gap-2">
                            <button
                                class="px-3.5 py-2 border border-gray-200 rounded-xl text-xs font-semibold text-gray-600 hover:bg-gray-50 transition-all flex items-center gap-1">
                                &lt; Sebelumnya
                            </button>
                            <button
                                class="px-3.5 py-2 bg-emerald-50 border border-emerald-300 text-[#006A4E] rounded-xl text-xs font-bold transition-all">
                                Hari ini
                            </button>
                            <button
                                class="px-3.5 py-2 border border-gray-200 rounded-xl text-xs font-semibold text-gray-600 hover:bg-gray-50 transition-all flex items-center gap-1">
                                Berikutnya &gt;
                            </button>
                        </div>
                    </div>

                    <!-- Calendar Grid Table -->
                    <div class="w-full border-t border-gray-100 pt-4">

                        <!-- Days of Week Header -->
                        <div class="grid grid-cols-7 text-center text-xs font-bold text-gray-400 mb-3">
                            <div>Min</div>
                            <div>Sen</div>
                            <div>Sel</div>
                            <div>Rab</div>
                            <div class="text-[#006A4E]">Kam</div>
                            <div>Jum</div>
                            <div>Sab</div>
                        </div>

                        <!-- Calendar Days Grid (7 Columns x 5 Rows) -->
                        <div class="grid grid-cols-7 gap-1 sm:gap-2 text-center text-xs font-semibold">

                            <!-- Row 1 -->
                            <div class="p-2 min-h-[50px] sm:min-h-[64px]"></div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px]"></div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px]"></div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">1</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">2</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">3</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">4</div>

                            <!-- Row 2 -->
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">5</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">6</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">7</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">8</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">9</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] flex flex-col items-center justify-center">
                                <span
                                    class="w-6 h-6 rounded-full bg-red-500 text-white flex items-center justify-center font-bold text-xs">10</span>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>11</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                </div>
                            </div>

                            <!-- Row 3 -->
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>12</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>13</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">14</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>15</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="text-[9px] text-gray-400 font-bold">+2</span>
                                </div>
                            </div>

                            <!-- Selected Active Date: 16 -->
                            <div
                                class="p-2 min-h-[50px] sm:min-h-[64px] bg-emerald-50/80 border-2 border-[#006A4E] rounded-xl flex flex-col justify-between">
                                <span class="font-bold text-[#006A4E]">16</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                    <span class="text-[9px] text-[#006A4E] font-bold">+2</span>
                                </div>
                            </div>

                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>17</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>18</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                </div>
                            </div>

                            <!-- Row 4 -->
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">19</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">20</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>21</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>22</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#006A4E]"></span>
                                    <span class="w-1.5 h-1.5 rounded-full bg-amber-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>23</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">
                                <span>24</span>
                                <div class="flex items-center justify-center gap-1 mt-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-emerald-500"></span>
                                </div>
                            </div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">25</div>

                            <!-- Row 5 -->
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">26</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">27</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">28</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">29</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">30</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px] text-gray-800">31</div>
                            <div class="p-2 min-h-[50px] sm:min-h-[64px]"></div>

                        </div>

                    </div>

                </div>

                <!-- Right: Selected Day Events Details Panel (Span 1) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <!-- Header Panel -->
                        <div class="flex items-center justify-between pb-4 border-b border-gray-100 mb-4">
                            <div>
                                <span class="text-[10px] font-bold text-gray-400 uppercase">Detail tanggal</span>
                                <h3 class="font-bold text-gray-800 text-sm mt-0.5">Kamis, 16 Juli 2026</h3>
                            </div>
                            <span class="px-2.5 py-1 rounded-full text-[10px] font-bold bg-amber-100 text-amber-700">
                                5 acara
                            </span>
                        </div>

                        <!-- Event List Cards -->
                        <div class="space-y-3.5">

                            <!-- Event 1: Menunggu -->
                            <div class="bg-[#F8FAFC] rounded-2xl p-4 border-l-4 border-l-amber-500 text-xs space-y-2">
                                <div class="flex items-center justify-between">
                                    <span class="font-bold text-gray-800 text-xs">non-akademik 0371</span>
                                    <span
                                        class="px-2 py-0.5 bg-amber-100 text-amber-700 text-[10px] font-bold rounded-md">Menunggu</span>
                                </div>
                                <p class="text-gray-600 font-medium text-[11px]">Siti Nurhaliza - Ruang Kelas A203</p>
                                <div class="space-y-1 text-gray-400 text-[11px] pt-1">
                                    <p class="flex items-center gap-2"><i class="fa-regular fa-clock w-3.5"></i>
                                        08:15:00 - 10:15:00</p>
                                    <p class="flex items-center gap-2"><i class="fa-regular fa-building w-3.5"></i>
                                        Ruangan</p>
                                    <p class="flex items-center gap-2"><i class="fa-solid fa-circle-info w-3.5"></i>
                                        Peminjaman alat untuk keperluan praktikum</p>
                                </div>
                            </div>

                            <!-- Event 2: Disetujui -->
                            <div class="bg-[#F8FAFC] rounded-2xl p-4 border-l-4 border-l-emerald-500 text-xs space-y-2">
                                <div class="flex items-center justify-between">
                                    <span class="font-bold text-gray-800 text-xs">non-akademik C8B6</span>
                                    <span
                                        class="px-2 py-0.5 bg-emerald-100 text-emerald-700 text-[10px] font-bold rounded-md">Disetujui</span>
                                </div>
                                <p class="text-gray-600 font-medium text-[11px]">Dr. Sari Dewi - Proyektor Epson EB-X41
                                </p>
                                <div class="space-y-1 text-gray-400 text-[11px] pt-1">
                                    <p class="flex items-center gap-2"><i class="fa-regular fa-clock w-3.5"></i>
                                        09:00:00 - 11:00:00</p>
                                    <p class="flex items-center gap-2"><i class="fa-solid fa-box-archive w-3.5"></i>
                                        Alat</p>
                                    <p class="flex items-center gap-2"><i class="fa-solid fa-circle-info w-3.5"></i>
                                        Tanpa keterangan tambahan</p>
                                </div>
                            </div>

                            <!-- Event 3: Menunggu -->
                            <div class="bg-[#F8FAFC] rounded-2xl p-4 border-l-4 border-l-amber-500 text-xs space-y-2">
                                <div class="flex items-center justify-between">
                                    <span class="font-bold text-gray-800 text-xs">non-akademik E4BC</span>
                                    <span
                                        class="px-2 py-0.5 bg-amber-100 text-amber-700 text-[10px] font-bold rounded-md">Menunggu</span>
                                </div>
                                <p class="text-gray-600 font-medium text-[11px]">Dra. Lina Hartati - Kamera DSLR Canon
                                    EOS</p>
                                <div class="space-y-1 text-gray-400 text-[11px] pt-1">
                                    <p class="flex items-center gap-2"><i class="fa-regular fa-clock w-3.5"></i>
                                        09:45:00 - 11:45:00</p>
                                    <p class="flex items-center gap-2"><i class="fa-solid fa-box-archive w-3.5"></i>
                                        Alat</p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>

        </main>
    </div>

</body>

</html>