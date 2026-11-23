<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Riwayat Peminjaman - mySBUM</title>
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

    <!-- SIDEBAR FIXED (ROLE PIC) -->
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

            <!-- Menu Navigation (PIC) -->
            <div class="p-4">
                <p class="text-[10px] font-bold text-gray-400 tracking-wider mb-3 px-3 uppercase">OPERASIONAL UTAMA</p>
                <nav class="space-y-1">
                    <a href="{{ route('pic.dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ route('ruangan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-regular fa-building w-5"></i>
                        Peminjaman Ruangan
                    </a>

                    <a href="{{ route('peralatan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-box-archive w-5"></i>
                        Peminjaman Alat
                    </a>

                    <a href="{{ route('persetujuan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <!-- Active Menu: Riwayat -->
                    <a href="{{ route('riwayat.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl bg-[#006A4E] text-white font-medium text-sm transition-all shadow-sm">
                        <i class="fa-solid fa-rotate-left w-5"></i>
                        Riwayat
                    </a>

                    <a href="{{ Route::has('kelola.ruangan.pic') ? route('kelola.ruangan.pic') : '#' }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-list-check w-5"></i>
                        Kelola Ruangan
                    </a>

                    <a href="{{ Route::has('kelola.peralatan.pic') ? route('kelola.peralatan.pic') : '#' }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-boxes-stacked w-5"></i>
                        Kelola Peralatan
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

            <!-- Breadcrumb & Header Title -->
            <div>
                <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                    <a href="{{ route('pic.dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                    <span>&gt;</span>
                    <span class="text-[#006A4E] font-semibold">Riwayat</span>
                </nav>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Riwayat</h1>
                <p class="text-xs text-gray-500 mt-1">
                    Daftar riwayat permohonan kegiatan binaan yang telah disetujui, ditolak, atau selesai dilaksanakan
                    di lingkungan Polibatam.
                </p>
            </div>

            <!-- Filter Card Container (Tabs + Search + Filter Lanjutan) -->
            <div class="bg-white p-4 rounded-2xl border border-gray-100 shadow-[0_2px_12px_rgba(0,0,0,0.02)] space-y-4">

                <!-- Filter Tabs -->
                <div class="flex items-center gap-2 overflow-x-auto pb-1 text-xs">
                    <button class="px-4 py-2 rounded-xl bg-[#F0F3FC] text-[#006A4E] font-bold shadow-sm shrink-0">
                        Semua (2)
                    </button>
                    <button class="px-4 py-2 rounded-xl text-gray-500 hover:text-gray-700 font-semibold shrink-0">
                        Disetujui (0)
                    </button>
                    <button class="px-4 py-2 rounded-xl text-gray-500 hover:text-gray-700 font-semibold shrink-0">
                        Menunggu (1)
                    </button>
                    <button class="px-4 py-2 rounded-xl text-gray-500 hover:text-gray-700 font-semibold shrink-0">
                        Ditolak (1)
                    </button>
                </div>

                <!-- Search Input and Filter Lanjutan Button -->
                <div class="flex flex-col md:flex-row items-center gap-3">
                    <div class="relative w-full md:flex-1">
                        <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center text-gray-400">
                            <i class="fa-solid fa-magnifying-glass text-xs"></i>
                        </span>
                        <input type="text" placeholder="Cari berdasarkan kode booking, kegiatan, atau nama pemohon..."
                            class="w-full pl-9 pr-4 py-2.5 bg-[#F0F3FC] border-0 rounded-xl text-xs text-gray-700 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] transition-all">
                    </div>

                    <button
                        class="w-full md:w-auto px-4 py-2.5 bg-[#F0F3FC] text-gray-700 font-semibold text-xs rounded-xl hover:bg-gray-200 transition-all flex items-center justify-center gap-2 shrink-0">
                        <i class="fa-solid fa-sliders text-xs text-gray-500"></i>
                        Filter Lanjutan
                    </button>
                </div>

            </div>

            <!-- Cards Grid: List Riwayat (3 Columns) -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                <!-- Card 1: Menunggu -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-5 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-[5px] border-l-amber-500 flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-start justify-between pb-3 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-amber-100 text-amber-600 flex items-center justify-center shrink-0">
                                    <i class="fa-regular fa-file-lines text-base"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">Ruang Kelas A102</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">rapat</p>
                                </div>
                            </div>
                            <span class="px-2.5 py-1 bg-amber-100 text-amber-700 text-[10px] font-bold rounded-full">
                                MENUNGGU
                            </span>
                        </div>

                        <!-- Info List -->
                        <div class="py-4 text-xs space-y-1.5 text-gray-600">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Tanggal</span>
                                <span class="ml-auto font-medium text-gray-800">: Sabtu, 11 Juli 2026</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-clock w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Waktu</span>
                                <span class="ml-auto font-medium text-gray-800">: 08:21 - 09:21</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-tag w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Jenis</span>
                                <span class="ml-auto font-medium text-gray-800">: non-akademik</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-user w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">PIC</span>
                                <span class="ml-auto font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons for Pending State -->
                    <div class="grid grid-cols-2 gap-2.5 pt-2">
                        <button
                            class="w-full py-2 bg-[#E2E8F0] hover:bg-gray-300 text-gray-700 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5">
                            <i class="fa-solid fa-circle-info text-xs"></i> Detail
                        </button>
                        <button
                            class="w-full py-2 bg-red-100 hover:bg-red-200 text-red-600 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5">
                            <i class="fa-solid fa-circle-xmark text-xs"></i> Batalkan
                        </button>
                    </div>
                </div>

                <!-- Card 2: Ditolak -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-5 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-[5px] border-l-red-500 flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-start justify-between pb-3 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-red-100 text-red-500 flex items-center justify-center shrink-0">
                                    <i class="fa-regular fa-file-lines text-base"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">Ruang Rapat Be...</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">akademik 4038</p>
                                </div>
                            </div>
                            <span class="px-2.5 py-1 bg-red-100 text-red-600 text-[10px] font-bold rounded-full">
                                DITOLAK
                            </span>
                        </div>

                        <!-- Info List -->
                        <div class="py-4 text-xs space-y-1.5 text-gray-600">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Tanggal</span>
                                <span class="ml-auto font-medium text-gray-800">: Sabtu, 18 Juli 2026</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-clock w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Waktu</span>
                                <span class="ml-auto font-medium text-gray-800">: 11:30 - 14:30</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-tag w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Jenis</span>
                                <span class="ml-auto font-medium text-gray-800">: non-akademik</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-user w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">PIC</span>
                                <span class="ml-auto font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                        </div>
                    </div>

                    <button
                        class="w-full py-2 bg-[#E2E8F0] hover:bg-gray-300 text-gray-700 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5 pt-2">
                        <i class="fa-solid fa-circle-info text-xs"></i> Detail
                    </button>
                </div>

                <!-- Card 3: Ditolak -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-5 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-[5px] border-l-red-500 flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-start justify-between pb-3 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-red-100 text-red-500 flex items-center justify-center shrink-0">
                                    <i class="fa-regular fa-file-lines text-base"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">Ruang Rapat Be...</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">akademik 4038</p>
                                </div>
                            </div>
                            <span class="px-2.5 py-1 bg-red-100 text-red-600 text-[10px] font-bold rounded-full">
                                DITOLAK
                            </span>
                        </div>

                        <!-- Info List -->
                        <div class="py-4 text-xs space-y-1.5 text-gray-600">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Tanggal</span>
                                <span class="ml-auto font-medium text-gray-800">: Sabtu, 18 Juli 2026</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-clock w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Waktu</span>
                                <span class="ml-auto font-medium text-gray-800">: 11:30 - 14:30</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-tag w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Jenis</span>
                                <span class="ml-auto font-medium text-gray-800">: non-akademik</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-user w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">PIC</span>
                                <span class="ml-auto font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                        </div>
                    </div>

                    <button
                        class="w-full py-2 bg-[#E2E8F0] hover:bg-gray-300 text-gray-700 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5 pt-2">
                        <i class="fa-solid fa-circle-info text-xs"></i> Detail
                    </button>
                </div>

                <!-- Card 4: Ditolak -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-5 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-[5px] border-l-red-500 flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-start justify-between pb-3 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-red-100 text-red-500 flex items-center justify-center shrink-0">
                                    <i class="fa-regular fa-file-lines text-base"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">Ruang Rapat Be...</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">akademik 4038</p>
                                </div>
                            </div>
                            <span class="px-2.5 py-1 bg-red-100 text-red-600 text-[10px] font-bold rounded-full">
                                DITOLAK
                            </span>
                        </div>

                        <!-- Info List -->
                        <div class="py-4 text-xs space-y-1.5 text-gray-600">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Tanggal</span>
                                <span class="ml-auto font-medium text-gray-800">: Sabtu, 18 Juli 2026</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-clock w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Waktu</span>
                                <span class="ml-auto font-medium text-gray-800">: 11:30 - 14:30</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-tag w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Jenis</span>
                                <span class="ml-auto font-medium text-gray-800">: non-akademik</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-user w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">PIC</span>
                                <span class="ml-auto font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                        </div>
                    </div>

                    <button
                        class="w-full py-2 bg-[#E2E8F0] hover:bg-gray-300 text-gray-700 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5 pt-2">
                        <i class="fa-solid fa-circle-info text-xs"></i> Detail
                    </button>
                </div>

                <!-- Card 5: Ditolak -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-5 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-[5px] border-l-red-500 flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-start justify-between pb-3 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-red-100 text-red-500 flex items-center justify-center shrink-0">
                                    <i class="fa-regular fa-file-lines text-base"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">Ruang Rapat Be...</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">akademik 4038</p>
                                </div>
                            </div>
                            <span class="px-2.5 py-1 bg-red-100 text-red-600 text-[10px] font-bold rounded-full">
                                DITOLAK
                            </span>
                        </div>

                        <!-- Info List -->
                        <div class="py-4 text-xs space-y-1.5 text-gray-600">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Tanggal</span>
                                <span class="ml-auto font-medium text-gray-800">: Sabtu, 18 Juli 2026</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-clock w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Waktu</span>
                                <span class="ml-auto font-medium text-gray-800">: 11:30 - 14:30</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-tag w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Jenis</span>
                                <span class="ml-auto font-medium text-gray-800">: non-akademik</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-user w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">PIC</span>
                                <span class="ml-auto font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                        </div>
                    </div>

                    <button
                        class="w-full py-2 bg-[#E2E8F0] hover:bg-gray-300 text-gray-700 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5 pt-2">
                        <i class="fa-solid fa-circle-info text-xs"></i> Detail
                    </button>
                </div>

                <!-- Card 6: Diterima -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-5 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-[5px] border-l-emerald-600 flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-start justify-between pb-3 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center shrink-0">
                                    <i class="fa-regular fa-file-lines text-base"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">Ruang Rapat Be...</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">akademik 4038</p>
                                </div>
                            </div>
                            <span
                                class="px-2.5 py-1 bg-emerald-100 text-emerald-700 text-[10px] font-bold rounded-full">
                                DITERIMA
                            </span>
                        </div>

                        <!-- Info List -->
                        <div class="py-4 text-xs space-y-1.5 text-gray-600">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Tanggal</span>
                                <span class="ml-auto font-medium text-gray-800">: Sabtu, 18 Juli 2026</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-clock w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Waktu</span>
                                <span class="ml-auto font-medium text-gray-800">: 11:30 - 14:30</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-solid fa-tag w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">Jenis</span>
                                <span class="ml-auto font-medium text-gray-800">: non-akademik</span>
                            </div>
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-user w-4 text-gray-400"></i>
                                <span class="text-gray-400 font-medium">PIC</span>
                                <span class="ml-auto font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                        </div>
                    </div>

                    <button
                        class="w-full py-2 bg-[#E2E8F0] hover:bg-gray-300 text-gray-700 text-xs font-semibold rounded-xl transition-all flex items-center justify-center gap-1.5 pt-2">
                        <i class="fa-solid fa-circle-info text-xs"></i> Detail
                    </button>
                </div>

            </div>

        </main>
    </div>

</body>

</html>