<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Persetujuan Peminjaman - Admin SBUM</title>
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

    <!-- SIDEBAR FIXED (ROLE ADMIN PENGELOLA SBUM) -->
    @include('layouts.sidebar')

    <!-- MAIN WRAPPER AREA -->
    <div class="flex-grow flex flex-col min-w-0 h-full overflow-hidden">

        <!-- TOP NAVBAR / HEADER -->
        <header class="h-20 bg-white border-b border-gray-100 flex items-center justify-between px-6 md:px-10 shrink-0">
            <div class="flex items-center gap-4">
                <button class="md:hidden text-gray-500 hover:text-gray-700">
                    <i class="fa-solid fa-bars text-xl"></i>
                </button>
            </div>

            <!-- Profile User Dropdown Hover -->
            @include('components.profile-dropdown')
        </header>

        <!-- MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Breadcrumb & Header Title -->
            <div>
                <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                    <a href="{{ route('admin.dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                    <span>&gt;</span>
                    <span class="text-[#006A4E] font-semibold">Persetujuan</span>
                </nav>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Halaman Peminjaman</h1>
                <p class="text-xs text-gray-500 mt-1">
                    Pantau dan setujui seluruh peminjaman alat atau ruangan
                </p>
            </div>

            <!-- Overview Status Cards (3 Columns) -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                <!-- Card 1: Telah Disetujui -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center gap-4">
                    <div
                        class="w-12 h-12 rounded-2xl bg-emerald-100/70 text-emerald-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-check text-lg"></i>
                    </div>
                    <div>
                        <span class="text-3xl font-bold text-gray-800">0</span>
                        <p class="text-xs font-semibold text-gray-400 mt-0.5">Telah disetujui</p>
                    </div>
                </div>

                <!-- Card 2: Perlu Disetujui (Highlight) -->
                <div
                    class="bg-amber-50/40 p-5 rounded-2xl border border-amber-200/80 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div
                            class="w-12 h-12 rounded-2xl bg-amber-100 text-amber-600 flex items-center justify-center shrink-0">
                            <i class="fa-regular fa-clock text-lg"></i>
                        </div>
                        <div>
                            <span class="text-3xl font-bold text-gray-800">2</span>
                            <p class="text-xs font-semibold text-amber-800 mt-0.5">Perlu disetujui</p>
                        </div>
                    </div>
                    <span class="px-3 py-1 bg-amber-500 text-white text-[10px] font-bold rounded-full shadow-sm">
                        Butuh aksi
                    </span>
                </div>

                <!-- Card 3: Telah Ditolak -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center gap-4">
                    <div
                        class="w-12 h-12 rounded-2xl bg-red-100/70 text-red-500 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-xmark text-lg"></i>
                    </div>
                    <div>
                        <span class="text-3xl font-bold text-gray-800">0</span>
                        <p class="text-xs font-semibold text-gray-400 mt-0.5">Telah ditolak</p>
                    </div>
                </div>

            </div>

            <!-- Controls: Filter Tabs, Status Dropdown, and Search Input -->
            <div class="flex flex-col md:flex-row items-center justify-between gap-3">

                <!-- Left: Tabs & Status Filter -->
                <div class="flex items-center gap-2.5 w-full md:w-auto">
                    <!-- Tabs Alat / Ruangan -->
                    <div class="bg-[#EEF2F6] p-1 rounded-xl flex items-center gap-1">
                        <button class="px-5 py-2 rounded-lg bg-[#006A4E] text-white text-xs font-bold transition-all">
                            ALAT
                        </button>
                        <button
                            class="px-5 py-2 rounded-lg text-gray-500 hover:text-gray-700 text-xs font-bold transition-all">
                            RUANGAN
                        </button>
                    </div>

                    <!-- Status Dropdown -->
                    <div class="relative">
                        <button
                            class="bg-white border border-gray-200 text-gray-700 text-xs font-semibold px-4 py-2.5 rounded-xl flex items-center gap-2 hover:bg-gray-50">
                            <i class="fa-solid fa-bars-staggered text-gray-400 text-xs"></i>
                            Status
                        </button>
                    </div>
                </div>

                <!-- Right: Search Input -->
                <div class="relative w-full md:w-96">
                    <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center text-gray-400">
                        <i class="fa-solid fa-magnifying-glass text-xs"></i>
                    </span>
                    <input type="text" placeholder="Cari peralatan, kode, atau nama peminjam..."
                        class="w-full pl-9 pr-4 py-2.5 bg-white border border-gray-100 rounded-xl text-xs text-gray-700 placeholder-gray-400 shadow-[0_2px_10px_rgba(0,0,0,0.02)] focus:outline-none focus:ring-2 focus:ring-[#006A4E] transition-all">
                </div>

            </div>

            <!-- Cards Grid: List Peminjaman (3 Columns) -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                <!-- Card 1: ALT-002 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-center justify-between pb-4 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                    <i class="fa-solid fa-wrench text-sm"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">ALT-002</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">ALT-002 &bull; Peralatan</p>
                                </div>
                            </div>
                            <span class="px-3 py-1 bg-amber-100 text-amber-700 text-[10px] font-bold rounded-full">
                                Menunggu
                            </span>
                        </div>

                        <!-- User Info -->
                        <div class="flex items-center gap-2 mt-4 mb-3">
                            <h4 class="font-bold text-gray-800 text-sm">Dr. Budi Santoso</h4>
                            <span
                                class="px-2 py-0.5 bg-gray-100 text-gray-500 text-[10px] font-semibold rounded">Lecturer</span>
                        </div>

                        <!-- Details Grid -->
                        <div class="bg-[#F8FAFC] rounded-xl p-4 text-xs space-y-2 text-gray-600">
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-envelope w-3.5 text-center"></i> Email
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: budi.santoso@polibatam.ac.id</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-user w-3.5 text-center"></i> PIC
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-solid fa-phone w-3.5 text-center"></i> Nomor Telp
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: 081200000002</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-calendar w-3.5 text-center"></i> Hari/Tanggal
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: Jumat, 10 Juli 2026</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-clock w-3.5 text-center"></i> Waktu
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: 08:00 s/d 10:00</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-solid fa-tag w-3.5 text-center"></i> Jenis
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: akademik</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-file-lines w-3.5 text-center"></i> Kegiatan
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: rapat</span>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="grid grid-cols-2 gap-3 mt-5">
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all flex items-center justify-center gap-1.5 shadow-sm">
                            <i class="fa-solid fa-check text-xs"></i> Setujui
                        </button>
                        <button
                            class="bg-[#D92D20] hover:bg-[#B42318] text-white text-xs font-bold py-2.5 rounded-xl transition-all flex items-center justify-center gap-1.5 shadow-sm">
                            <i class="fa-solid fa-xmark text-xs"></i> Tolak
                        </button>
                    </div>
                </div>

                <!-- Card 2: ALT-001 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-center justify-between pb-4 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                    <i class="fa-solid fa-wrench text-sm"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">ALT-001</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">ALT-001 &bull; Peralatan</p>
                                </div>
                            </div>
                            <span class="px-3 py-1 bg-amber-100 text-amber-700 text-[10px] font-bold rounded-full">
                                Menunggu
                            </span>
                        </div>

                        <!-- User Info -->
                        <div class="flex items-center gap-2 mt-4 mb-3">
                            <h4 class="font-bold text-gray-800 text-sm">Siti Nurhaliza</h4>
                            <span
                                class="px-2 py-0.5 bg-emerald-100 text-emerald-700 text-[10px] font-semibold rounded">Mahasiswa</span>
                        </div>

                        <!-- Details Grid -->
                        <div class="bg-[#F8FAFC] rounded-xl p-4 text-xs space-y-2 text-gray-600">
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-envelope w-3.5 text-center"></i> Email
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: budi.santoso@polibatam.ac.id</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-user w-3.5 text-center"></i> PIC
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-solid fa-phone w-3.5 text-center"></i> Nomor Telp
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: 081200000002</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-calendar w-3.5 text-center"></i> Hari/Tanggal
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: Jumat, 10 Juli 2026</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-clock w-3.5 text-center"></i> Waktu
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: 08:00 s/d 10:00</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-solid fa-tag w-3.5 text-center"></i> Jenis
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: akademik</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-file-lines w-3.5 text-center"></i> Kegiatan
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: rapat</span>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="grid grid-cols-2 gap-3 mt-5">
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all flex items-center justify-center gap-1.5 shadow-sm">
                            <i class="fa-solid fa-check text-xs"></i> Setujui
                        </button>
                        <button
                            class="bg-[#D92D20] hover:bg-[#B42318] text-white text-xs font-bold py-2.5 rounded-xl transition-all flex items-center justify-center gap-1.5 shadow-sm">
                            <i class="fa-solid fa-xmark text-xs"></i> Tolak
                        </button>
                    </div>
                </div>

                <!-- Card 3: ALT-001 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <!-- Header Card -->
                        <div class="flex items-center justify-between pb-4 border-b border-gray-100">
                            <div class="flex items-center gap-3">
                                <div
                                    class="w-10 h-10 rounded-xl bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                    <i class="fa-solid fa-wrench text-sm"></i>
                                </div>
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">ALT-001</h3>
                                    <p class="text-[11px] text-gray-400 font-medium">ALT-001 &bull; Peralatan</p>
                                </div>
                            </div>
                            <span class="px-3 py-1 bg-amber-100 text-amber-700 text-[10px] font-bold rounded-full">
                                Menunggu
                            </span>
                        </div>

                        <!-- User Info -->
                        <div class="flex items-center gap-2 mt-4 mb-3">
                            <h4 class="font-bold text-gray-800 text-sm">Siti Nurhaliza</h4>
                            <span
                                class="px-2 py-0.5 bg-emerald-100 text-emerald-700 text-[10px] font-semibold rounded">Mahasiswa</span>
                        </div>

                        <!-- Details Grid -->
                        <div class="bg-[#F8FAFC] rounded-xl p-4 text-xs space-y-2 text-gray-600">
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-envelope w-3.5 text-center"></i> Email
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: budi.santoso@polibatam.ac.id</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-user w-3.5 text-center"></i> PIC
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: Andi Wijaya</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-solid fa-phone w-3.5 text-center"></i> Nomor Telp
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: 081200000002</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-calendar w-3.5 text-center"></i> Hari/Tanggal
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: Jumat, 10 Juli 2026</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-clock w-3.5 text-center"></i> Waktu
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: 08:00 s/d 10:00</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-solid fa-tag w-3.5 text-center"></i> Jenis
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: akademik</span>
                            </div>
                            <div class="grid grid-cols-3 gap-2">
                                <span class="text-gray-400 font-medium flex items-center gap-2">
                                    <i class="fa-regular fa-file-lines w-3.5 text-center"></i> Kegiatan
                                </span>
                                <span class="col-span-2 font-medium text-gray-800">: rapat</span>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="grid grid-cols-2 gap-3 mt-5">
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all flex items-center justify-center gap-1.5 shadow-sm">
                            <i class="fa-solid fa-check text-xs"></i> Setujui
                        </button>
                        <button
                            class="bg-[#D92D20] hover:bg-[#B42318] text-white text-xs font-bold py-2.5 rounded-xl transition-all flex items-center justify-center gap-1.5 shadow-sm">
                            <i class="fa-solid fa-xmark text-xs"></i> Tolak
                        </button>
                    </div>
                </div>

            </div>

        </main>
    </div>

</body>

</html>