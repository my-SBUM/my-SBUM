<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peminjaman Peralatan - mySBUM</title>
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

    <!-- SIDEBAR -->
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

            <!-- Profile User dengan Dropdown Hover -->
            @include('components.profile-dropdown')
        </header>

        <!-- MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Breadcrumb & Header Title -->
            <div>
                <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                    <a href="{{ route('dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                    <span>&gt;</span>
                    <span class="text-[#006A4E] font-semibold">Peminjaman Peralatan</span>
                </nav>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Peminjaman Peralatan</h1>
                <p class="text-xs text-gray-500 mt-1">
                    Katalog peminjaman perlengkapan multimedia, audio-visual, perangkat IoT, dan inventaris pendukung
                    kegiatan akademik serta kemahasiswaan.
                </p>
            </div>

            <!-- Search & Filter Bar -->
            <div
                class="bg-white p-3.5 rounded-2xl border border-gray-100 shadow-[0_2px_12px_rgba(0,0,0,0.03)] flex flex-col md:flex-row items-center gap-2.5">

                <!-- Search Input -->
                <div class="relative w-full md:flex-1">
                    <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center text-gray-400">
                        <i class="fa-solid fa-magnifying-glass text-xs"></i>
                    </span>
                    <input type="text" placeholder="Cari ruangan atau gedung (cth: Auditorium, Lab Komputer,"
                        class="w-full pl-9 pr-4 py-2.5 bg-[#F0F3FC] border-0 rounded-xl text-xs text-gray-700 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] transition-all">
                </div>

                <!-- Filter Dropdowns -->
                <div class="flex items-center gap-2.5 w-full md:w-auto shrink-0">

                    <!-- Status -->
                    <div class="relative">
                        <select
                            class="appearance-none bg-[#F0F3FC] text-[#1E293B] font-medium text-xs py-2.5 pl-4 pr-8 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#006A4E] cursor-pointer">
                            <option value="">Status</option>
                            <option value="tersedia">Tersedia</option>
                            <option value="dipinjam">Dipinjam</option>
                            <option value="maintenance">Maintenance</option>
                        </select>
                        <div
                            class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </div>
                    </div>

                    <!-- Jenis Alat -->
                    <div class="relative">
                        <select
                            class="appearance-none bg-[#F0F3FC] text-[#1E293B] font-medium text-xs py-2.5 pl-4 pr-8 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#006A4E] cursor-pointer">
                            <option value="">Jenis Alat</option>
                            <option value="audio">Audio Visual</option>
                            <option value="multimedia">Multimedia</option>
                            <option value="iot">Perangkat IoT</option>
                        </select>
                        <div
                            class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600">
                            <i class="fa-solid fa-chevron-down text-[10px]"></i>
                        </div>
                    </div>

                </div>

            </div>

            <!-- Section Title -->
            <h2 class="text-base font-bold text-gray-800 pt-2">Daftar Peralatan</h2>

            <!-- Cards Grid (3 Columns) -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                <!-- Card 1 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                            <img src="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=600&q=80"
                                alt="Microphone" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                <i class="fa-solid fa-box text-[10px]"></i> SBUM Gudang Utama
                            </span>
                        </div>
                        <h3 class="font-bold text-gray-800 text-sm">Wireless Microphone UHF (Set of 2)</h3>
                        <p class="text-xs text-gray-400 mt-1 line-clamp-2">Dual channel frekuensi dinamis, jangkauan 50
                            meter dengan baterai isi ulang dan receiver...</p>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                        <button
                            class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                            Ruangan</button>
                    </div>
                </div>

                <!-- Card 2 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="PA System" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                <i class="fa-solid fa-box text-[10px]"></i> Ruang Operator SBUM
                            </span>
                        </div>
                        <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                        <p class="text-xs text-gray-400 mt-1 line-clamp-2">Speaker aktif multifungsi dengan Bluetooth,
                            input instrumen 4-channel, dan roda koper...</p>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                        <button
                            class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                            Ruangan</button>
                    </div>
                </div>

                <!-- Card 3 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="PA System" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                <i class="fa-solid fa-box text-[10px]"></i> Ruang Operator SBUM
                            </span>
                        </div>
                        <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                        <p class="text-xs text-gray-400 mt-1 line-clamp-2">Speaker aktif multifungsi dengan Bluetooth,
                            input instrumen 4-channel, dan roda koper...</p>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                        <button
                            class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                            Ruangan</button>
                    </div>
                </div>

                <!-- Card 4 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                            <img src="https://images.unsplash.com/photo-1590658268037-6bf12165a8df?auto=format&fit=crop&w=600&q=80"
                                alt="Microphone" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                <i class="fa-solid fa-box text-[10px]"></i> SBUM Gudang Utama
                            </span>
                        </div>
                        <h3 class="font-bold text-gray-800 text-sm">Wireless Microphone UHF (Set of 2)</h3>
                        <p class="text-xs text-gray-400 mt-1 line-clamp-2">Dual channel frekuensi dinamis, jangkauan 50
                            meter dengan baterai isi ulang dan receiver...</p>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                        <button
                            class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                            Ruangan</button>
                    </div>
                </div>

                <!-- Card 5 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="PA System" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                <i class="fa-solid fa-box text-[10px]"></i> Ruang Operator SBUM
                            </span>
                        </div>
                        <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                        <p class="text-xs text-gray-400 mt-1 line-clamp-2">Speaker aktif multifungsi dengan Bluetooth,
                            input instrumen 4-channel, dan roda koper...</p>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                        <button
                            class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                            Ruangan</button>
                    </div>
                </div>

                <!-- Card 6 -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="PA System" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                <i class="fa-solid fa-box text-[10px]"></i> Ruang Operator SBUM
                            </span>
                        </div>
                        <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                        <p class="text-xs text-gray-400 mt-1 line-clamp-2">Speaker aktif multifungsi dengan Bluetooth,
                            input instrumen 4-channel, dan roda koper...</p>
                    </div>
                    <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                        <button
                            class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                        <button
                            class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                            Ruangan</button>
                    </div>
                </div>

            </div>

            <!-- Footer / Pagination -->
            <div
                class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col sm:flex-row items-center justify-between gap-4">
                <p class="text-xs text-gray-400">
                    Menampilkan 6 dari 24 ruangan total di Kampus Utama Politeknik Negeri Batam
                </p>
                <div class="flex items-center gap-2 text-xs font-semibold text-gray-600">
                    <button
                        class="w-7 h-7 flex items-center justify-center hover:bg-gray-100 rounded-lg text-gray-400">&lt;</button>
                    <button
                        class="w-7 h-7 flex items-center justify-center bg-[#006A4E] text-white rounded-lg">1</button>
                    <button class="w-7 h-7 flex items-center justify-center hover:bg-gray-100 rounded-lg">2</button>
                    <button class="w-7 h-7 flex items-center justify-center hover:bg-gray-100 rounded-lg">3</button>
                    <button
                        class="w-7 h-7 flex items-center justify-center hover:bg-gray-100 rounded-lg text-gray-400">&gt;</button>
                </div>
            </div>

        </main>
    </div>

</body>

</html>