<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Penanggung Jawab - mySBUM</title>
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
<!-- BODY: h-screen & overflow-hidden agar scrollbar window tidak muncul -->

<body class="bg-[#F8F9FC] text-[#1E293B] h-screen flex overflow-hidden">

    <!-- SIDEBAR  -->
    @include('layouts.sidebar')

    <!-- MAIN WRAPPER AREA -->
    <div class="flex-grow flex flex-col min-w-0 h-full overflow-hidden">

        <!-- TOP NAVBAR / HEADER (Tetap Diam di Atas) -->
        <header class="h-20 bg-white border-b border-gray-100 flex items-center justify-between px-6 md:px-10 shrink-0">
            <div class="flex items-center gap-4">
                <button class="md:hidden text-gray-500 hover:text-gray-700">
                    <i class="fa-solid fa-bars text-xl"></i>
                </button>
            </div>

            <!-- Profile User dengan Dropdown Hover -->
            @include('components.profile-dropdown')
        </header>

        <!-- DASHBOARD BODY CONTENT (HANYA AREA INI YANG DAPAT DI-SCROLL) -->
        <main class="p-6 md:p-10 space-y-8 flex-grow overflow-y-auto">

            <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Halaman Dashboard</h1>

            <!-- CARDS OVERVIEW (3 Grid) -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                <!-- Card 1: Perlu Disetujui -->
                <div
                    class="bg-white p-6 rounded-2xl border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.02)] relative overflow-hidden flex flex-col justify-between">
                    <div class="absolute left-0 top-0 bottom-0 w-1.5 bg-[#006A4E]"></div>
                    <div>
                        <span class="text-[11px] font-bold text-gray-400 tracking-wider uppercase">PERLU
                            DISETUJUI</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-4xl font-bold text-gray-800">5</span>
                            <span class="text-sm font-medium text-gray-500">Fasilitas</span>
                        </div>
                    </div>
                    <div class="mt-6">
                        <span
                            class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold bg-[#56E39F] text-[#004D39]">
                            ! Butuh Tindakan Segera
                        </span>
                    </div>
                </div>

                <!-- Card 2: Total Ruangan -->
                <div
                    class="bg-white p-6 rounded-2xl border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[11px] font-bold text-gray-400 tracking-wider uppercase">TOTAL RUANGAN</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-4xl font-bold text-gray-800">22</span>
                            <span class="text-sm font-medium text-gray-500">Ruangan</span>
                        </div>
                    </div>
                    <div class="mt-6">
                        <span class="text-xs text-gray-400 font-medium">14 Dalam Peminjaman</span>
                    </div>
                </div>

                <!-- Card 3: Total Peralatan -->
                <div
                    class="bg-white p-6 rounded-2xl border border-gray-100 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[11px] font-bold text-gray-400 tracking-wider uppercase">TOTAL
                            PERALATAN</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-4xl font-bold text-gray-800">7</span>
                            <span class="text-sm font-medium text-gray-500">Peralatan</span>
                        </div>
                    </div>
                    <div class="mt-6">
                        <span class="text-xs text-gray-400 font-medium">7 Dalam Peminjaman</span>
                    </div>
                </div>

            </div>

            <!-- LOWER GRID SECTION: TABLE & RECENT ACTIVITY -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                <!-- LEFT COLUMN: PEMINJAMAN YANG DIAJUKAN (Span 2) -->
                <div
                    class="lg:col-span-2 bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="flex justify-between items-start mb-6">
                            <div>
                                <h2 class="text-lg font-bold text-gray-800">Peminjaman yang diajukan</h2>
                                <p class="text-xs text-gray-400 mt-0.5">Peminjaman yang baru - baru ini diajukan</p>
                            </div>
                            <a href="#"
                                class="text-xs font-bold text-[#006A4E] hover:underline flex items-center gap-1">
                                Lihat Semua (5) <i class="fa-solid fa-arrow-right text-[10px]"></i>
                            </a>
                        </div>

                        <!-- Table -->
                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr
                                        class="text-[11px] font-bold text-gray-400 tracking-wider border-b border-gray-50">
                                        <th class="pb-3 uppercase">ITEM PEMINJAMAN</th>
                                        <th class="pb-3 uppercase">KATEGORI & WAKTU</th>
                                        <th class="pb-3 uppercase text-center">STATUS</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-50 text-xs">
                                    <!-- Row 1 -->
                                    <tr>
                                        <td class="py-3.5 pr-4">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="w-9 h-9 rounded-full bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                                    <i class="fa-solid fa-wrench text-xs"></i>
                                                </div>
                                                <div>
                                                    <p class="font-bold text-gray-800">Scanner Epson</p>
                                                    <p class="text-[10px] text-gray-400">PIC: Andi Wijaya</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="py-3.5 px-2">
                                            <p class="font-bold text-gray-700">Non-Akademik BDE8</p>
                                            <p class="text-[10px] text-gray-400">16 Juli 2026 - 07:15 - 10:15</p>
                                        </td>
                                        <td class="py-3.5 pl-2 text-center">
                                            <span
                                                class="px-3 py-1 rounded-full text-[10px] font-bold bg-[#F59E0B] text-white">MENUNGGU</span>
                                        </td>
                                    </tr>

                                    <!-- Row 2 -->
                                    <tr>
                                        <td class="py-3.5 pr-4">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="w-9 h-9 rounded-full bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                                    <i class="fa-solid fa-door-closed text-xs"></i>
                                                </div>
                                                <div>
                                                    <p class="font-bold text-gray-800">Ruang Rapat Besar B302</p>
                                                    <p class="text-[10px] text-gray-400">PIC: Andi Wijaya</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="py-3.5 px-2">
                                            <p class="font-bold text-gray-700">Akademik 4038</p>
                                            <p class="text-[10px] text-gray-400">18 Juli 2026 - 11:30 - 14:30</p>
                                        </td>
                                        <td class="py-3.5 pl-2 text-center">
                                            <span
                                                class="px-3 py-1 rounded-full text-[10px] font-bold bg-[#EF4444] text-white">DITOLAK</span>
                                        </td>
                                    </tr>

                                    <!-- Row 3 -->
                                    <tr>
                                        <td class="py-3.5 pr-4">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="w-9 h-9 rounded-full bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                                    <i class="fa-solid fa-wrench text-xs"></i>
                                                </div>
                                                <div>
                                                    <p class="font-bold text-gray-800">Scanner Epson</p>
                                                    <p class="text-[10px] text-gray-400">PIC: Andi Wijaya</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="py-3.5 px-2">
                                            <p class="font-bold text-gray-700">Non-Akademik BDE8</p>
                                            <p class="text-[10px] text-gray-400">16 Juli 2026 - 07:15 - 10:15</p>
                                        </td>
                                        <td class="py-3.5 pl-2 text-center">
                                            <span
                                                class="px-3 py-1 rounded-full text-[10px] font-bold bg-[#006A4E] text-white">DITERIMA</span>
                                        </td>
                                    </tr>

                                    <!-- Row 4 -->
                                    <tr>
                                        <td class="py-3.5 pr-4">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="w-9 h-9 rounded-full bg-[#006A4E] text-white flex items-center justify-center shrink-0">
                                                    <i class="fa-solid fa-door-closed text-xs"></i>
                                                </div>
                                                <div>
                                                    <p class="font-bold text-gray-800">Scanner Epson</p>
                                                    <p class="text-[10px] text-gray-400">PIC: Andi Wijaya</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="py-3.5 px-2">
                                            <p class="font-bold text-gray-700">Non-Akademik BDE8</p>
                                            <p class="text-[10px] text-gray-400">16 Juli 2026 - 07:15 - 10:15</p>
                                        </td>
                                        <td class="py-3.5 pl-2 text-center">
                                            <span
                                                class="px-3 py-1 rounded-full text-[10px] font-bold bg-[#006A4E] text-white">DITERIMA</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- RIGHT COLUMN: AKTIVITAS TERBARU (Span 1) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="flex justify-between items-center mb-6">
                            <div class="flex items-center gap-2">
                                <i class="fa-regular fa-calendar text-[#006A4E]"></i>
                                <h2 class="text-base font-bold text-gray-800">Aktivitas Terbaru</h2>
                            </div>
                            <span class="px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#6EE7B7] text-[#004D39]">
                                Disetujui
                            </span>
                        </div>

                        <!-- Activity Feed List -->
                        <div class="space-y-3">
                            <!-- Activity Item 1 -->
                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-start gap-3">
                                <div
                                    class="w-7 h-7 rounded-full bg-amber-100 text-amber-600 flex items-center justify-center shrink-0 mt-0.5 text-xs font-bold">
                                    !
                                </div>
                                <div class="text-xs">
                                    <div class="flex justify-between items-center gap-2">
                                        <h3 class="font-bold text-gray-800">Peminjaman Dibat..</h3>
                                        <span class="text-[10px] text-gray-400">Hari ini, 09:30 WIB</span>
                                    </div>
                                    <p class="text-gray-500 text-[11px] mt-0.5">Kamera DSLR Canon EOS dibatalkan oleh
                                        Budi Santoso.</p>
                                </div>
                            </div>

                            <!-- Activity Item 2 -->
                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-start gap-3">
                                <div
                                    class="w-7 h-7 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center shrink-0 mt-0.5 text-xs">
                                    <i class="fa-solid fa-check"></i>
                                </div>
                                <div class="text-xs">
                                    <div class="flex justify-between items-center gap-2">
                                        <h3 class="font-bold text-gray-800">Peminjaman Baru</h3>
                                        <span class="text-[10px] text-gray-400">Kemarin, 14:15 WIB</span>
                                    </div>
                                    <p class="text-gray-500 text-[11px] mt-0.5">Scanner Epson diajukan oleh Budi
                                        Santoso, perlu persetujuan.</p>
                                </div>
                            </div>

                            <!-- Activity Item 3 -->
                            <div class="p-3 bg-[#F8FAFC] rounded-xl flex items-start gap-3">
                                <div
                                    class="w-7 h-7 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center shrink-0 mt-0.5 text-xs">
                                    <i class="fa-solid fa-check"></i>
                                </div>
                                <div class="text-xs">
                                    <div class="flex justify-between items-center gap-2">
                                        <h3 class="font-bold text-gray-800">Peminjaman Baru</h3>
                                        <span class="text-[10px] text-gray-400">Kemarin, 10:05 WIB</span>
                                    </div>
                                    <p class="text-gray-500 text-[11px] mt-0.5">Ruang Rapat Besar B302 diajukan oleh
                                        Budi Santoso.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Button -->
                    <div class="mt-6">
                        <button
                            class="w-full py-2.5 border border-gray-200 rounded-xl text-xs font-bold text-gray-600 hover:bg-gray-50 transition-all">
                            Lihat Semua Aktivitas &gt;
                        </button>
                    </div>
                </div>

            </div>

        </main>
    </div>

</body>

</html>