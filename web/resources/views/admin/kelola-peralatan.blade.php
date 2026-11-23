<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelola Peralatan - Admin SBUM</title>
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

            <!-- Profile User Dropdown -->
            @include('components.profile-dropdown')
        </header>

        <!-- MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Breadcrumb & Header Title -->
            <div>
                <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                    <a href="{{ route('admin.dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                    <span>&gt;</span>
                    <span class="text-[#006A4E] font-semibold">Kelola Peralatan</span>
                </nav>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Kelola Peralatan</h1>
                <p class="text-xs text-gray-500 mt-1">
                    Manajemen ketersediaan stok, kode aset, kondisi fisik, dan lokasi penyimpanan unit sarana.
                </p>
            </div>

            <!-- Overview Status Cards (3 Columns) -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

                <!-- Card 1: Siap Digunakan -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">SIAP DIGUNAKAN</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">142</span>
                            <span class="text-xs text-gray-400 font-medium">Unit</span>
                            <span
                                class="px-2.5 py-0.5 bg-emerald-100 text-emerald-700 text-[10px] font-bold rounded-full">
                                Siap Pakai
                            </span>
                        </div>
                    </div>
                    <div
                        class="w-10 h-10 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-check text-sm"></i>
                    </div>
                </div>

                <!-- Card 2: Sedang Dipinjam -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">SEDANG
                            DIPINJAM</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">36</span>
                            <span class="text-xs text-gray-400 font-medium">Unit</span>
                            <span
                                class="px-2.5 py-0.5 bg-indigo-100 text-indigo-700 text-[10px] font-bold rounded-full">
                                Terjadwal
                            </span>
                        </div>
                    </div>
                    <div
                        class="w-10 h-10 rounded-xl bg-indigo-100 text-indigo-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-box-archive text-sm"></i>
                    </div>
                </div>

                <!-- Card 3: Rusak / Servis -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">RUSAK / SERVIS</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">6</span>
                            <span class="text-xs text-gray-400 font-medium">Unit</span>
                            <span class="px-2.5 py-0.5 bg-rose-100 text-rose-700 text-[10px] font-bold rounded-full">
                                Maintenance
                            </span>
                        </div>
                    </div>
                    <div
                        class="w-10 h-10 rounded-xl bg-rose-100 text-rose-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-wrench text-sm"></i>
                    </div>
                </div>

            </div>

            <!-- Search Bar & Dropdown Filters -->
            <div
                class="flex flex-col md:flex-row items-center justify-between gap-3 bg-white p-2 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)]">
                <!-- Search Input -->
                <div class="relative w-full md:flex-grow">
                    <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center text-gray-400">
                        <i class="fa-solid fa-magnifying-glass text-xs"></i>
                    </span>
                    <input type="text" placeholder="Cari nama alat, merk, atau kode aset (misal: EQ-AUD-014)..."
                        class="w-full pl-9 pr-4 py-2 bg-transparent text-xs text-gray-700 placeholder-gray-400 focus:outline-none">
                </div>

                <!-- Dropdowns & Reset Button -->
                <div class="flex flex-wrap sm:flex-nowrap items-center gap-2 w-full md:w-auto shrink-0">
                    <div class="relative w-full sm:w-40">
                        <select
                            class="w-full appearance-none bg-[#F8FAFC] border border-gray-100 text-gray-600 text-xs font-semibold py-2 pl-3 pr-8 rounded-xl focus:outline-none cursor-pointer">
                            <option>Semua Kategori</option>
                            <option>Audio & Sound</option>
                            <option>Visual & Proyektor</option>
                            <option>Elektronik</option>
                        </select>
                        <i class="fa-solid fa-chevron-down absolute right-3 top-2.5 text-gray-400 text-[10px]"></i>
                    </div>

                    <div class="relative w-full sm:w-40">
                        <select
                            class="w-full appearance-none bg-[#F8FAFC] border border-gray-100 text-gray-600 text-xs font-semibold py-2 pl-3 pr-8 rounded-xl focus:outline-none cursor-pointer">
                            <option>Semua Kondisi</option>
                            <option>Bagus (Siap Pakai)</option>
                            <option>Sedang Dipakai</option>
                            <option>Maintenance</option>
                        </select>
                        <i class="fa-solid fa-chevron-down absolute right-3 top-2.5 text-gray-400 text-[10px]"></i>
                    </div>

                    <button
                        class="bg-[#F8FAFC] hover:bg-gray-100 text-gray-600 text-xs font-semibold px-4 py-2 rounded-xl transition-all flex items-center gap-1.5 shrink-0 border border-gray-100">
                        <i class="fa-solid fa-rotate text-[10px]"></i> Reset
                    </button>
                </div>
            </div>

            <!-- Cards Grid (3 Columns) -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                <!-- Card 1: Wireless Microphone UHF -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <!-- Image Container with Overlays -->
                        <div class="relative h-44 w-full bg-gray-100">
                            <img src="https://images.unsplash.com/photo-1590602847861-f357a9332bbc?auto=format&fit=crop&w=600&q=80"
                                alt="Peralatan" class="w-full h-full object-cover">
                            <!-- Top Right Badge -->
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                            </span>
                            <!-- Bottom Left Overlay -->
                            <span
                                class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                SBUM Gudang Utama
                            </span>
                            <!-- Bottom Right Overlay -->
                            <span
                                class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                ALT-104
                            </span>
                        </div>

                        <!-- Card Content -->
                        <div class="p-5 space-y-2">
                            <h3 class="font-bold text-gray-800 text-sm">Wireless Microphone UHF (Set of 2)</h3>
                            <p class="text-[11px] text-gray-400 leading-relaxed line-clamp-2">
                                Dual channel frekuensi dinamis jangkauan 50 meter dengan baterai isi ulang dan
                                receiver...
                            </p>
                            <p class="text-[11px] text-gray-400 font-medium pt-1">
                                <i class="fa-regular fa-clock text-gray-400 mr-1"></i> Stok : <strong
                                    class="text-gray-700">2</strong>
                            </p>
                        </div>
                    </div>

                    <div class="p-5 pt-0">
                        <button
                            class="w-full bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm">
                            Edit Peralatan
                        </button>
                    </div>
                </div>

                <!-- Card 2: Portable PA System 500W + Stand -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <!-- Image Container with Overlays -->
                        <div class="relative h-44 w-full bg-gray-100">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="Peralatan" class="w-full h-full object-cover">
                            <!-- Top Right Badge -->
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                            </span>
                            <!-- Bottom Left Overlay -->
                            <span
                                class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                Ruang Operator SBUM
                            </span>
                            <!-- Bottom Right Overlay -->
                            <span
                                class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                ALT-104
                            </span>
                        </div>

                        <!-- Card Content -->
                        <div class="p-5 space-y-2">
                            <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                            <p class="text-[11px] text-gray-400 leading-relaxed line-clamp-2">
                                Speaker aktif multifungsi dengan Bluetooth, input instrumen 4-channel, dan roda koper...
                            </p>
                            <p class="text-[11px] text-gray-400 font-medium pt-1">
                                <i class="fa-regular fa-clock text-gray-400 mr-1"></i> Stok : <strong
                                    class="text-gray-700">2</strong>
                            </p>
                        </div>
                    </div>

                    <div class="p-5 pt-0">
                        <button
                            class="w-full bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm">
                            Edit Peralatan
                        </button>
                    </div>
                </div>

                <!-- Card 3: Portable PA System 500W + Stand (Duplikasi Card 2) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative h-44 w-full bg-gray-100">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="Peralatan" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                Ruang Operator SBUM
                            </span>
                            <span
                                class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                ALT-104
                            </span>
                        </div>

                        <div class="p-5 space-y-2">
                            <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                            <p class="text-[11px] text-gray-400 leading-relaxed line-clamp-2">
                                Speaker aktif multifungsi dengan Bluetooth, input instrumen 4-channel, dan roda koper...
                            </p>
                            <p class="text-[11px] text-gray-400 font-medium pt-1">
                                <i class="fa-regular fa-clock text-gray-400 mr-1"></i> Stok : <strong
                                    class="text-gray-700">2</strong>
                            </p>
                        </div>
                    </div>

                    <div class="p-5 pt-0">
                        <button
                            class="w-full bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm">
                            Edit Peralatan
                        </button>
                    </div>
                </div>

                <!-- Card 4: Wireless Microphone UHF (Row 2) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative h-44 w-full bg-gray-100">
                            <img src="https://images.unsplash.com/photo-1590602847861-f357a9332bbc?auto=format&fit=crop&w=600&q=80"
                                alt="Peralatan" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                SBUM Gudang Utama
                            </span>
                            <span
                                class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                ALT-104
                            </span>
                        </div>

                        <div class="p-5 space-y-2">
                            <h3 class="font-bold text-gray-800 text-sm">Wireless Microphone UHF (Set of 2)</h3>
                            <p class="text-[11px] text-gray-400 leading-relaxed line-clamp-2">
                                Dual channel frekuensi dinamis jangkauan 50 meter dengan baterai isi ulang dan
                                receiver...
                            </p>
                            <p class="text-[11px] text-gray-400 font-medium pt-1">
                                <i class="fa-regular fa-clock text-gray-400 mr-1"></i> Stok : <strong
                                    class="text-gray-700">2</strong>
                            </p>
                        </div>
                    </div>

                    <div class="p-5 pt-0">
                        <button
                            class="w-full bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm">
                            Edit Peralatan
                        </button>
                    </div>
                </div>

                <!-- Card 5: Portable PA System 500W + Stand (Row 2) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative h-44 w-full bg-gray-100">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="Peralatan" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                Ruang Operator SBUM
                            </span>
                            <span
                                class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                ALT-104
                            </span>
                        </div>

                        <div class="p-5 space-y-2">
                            <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                            <p class="text-[11px] text-gray-400 leading-relaxed line-clamp-2">
                                Speaker aktif multifungsi dengan Bluetooth, input instrumen 4-channel, dan roda koper...
                            </p>
                            <p class="text-[11px] text-gray-400 font-medium pt-1">
                                <i class="fa-regular fa-clock text-gray-400 mr-1"></i> Stok : <strong
                                    class="text-gray-700">2</strong>
                            </p>
                        </div>
                    </div>

                    <div class="p-5 pt-0">
                        <button
                            class="w-full bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm">
                            Edit Peralatan
                        </button>
                    </div>
                </div>

                <!-- Card 6: Portable PA System 500W + Stand (Row 2) -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <div class="relative h-44 w-full bg-gray-100">
                            <img src="https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&w=600&q=80"
                                alt="Peralatan" class="w-full h-full object-cover">
                            <span
                                class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                            </span>
                            <span
                                class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                Ruang Operator SBUM
                            </span>
                            <span
                                class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                ALT-104
                            </span>
                        </div>

                        <div class="p-5 space-y-2">
                            <h3 class="font-bold text-gray-800 text-sm">Portable PA System 500W + Stand</h3>
                            <p class="text-[11px] text-gray-400 leading-relaxed line-clamp-2">
                                Speaker aktif multifungsi dengan Bluetooth, input instrumen 4-channel, dan roda koper...
                            </p>
                            <p class="text-[11px] text-gray-400 font-medium pt-1">
                                <i class="fa-regular fa-clock text-gray-400 mr-1"></i> Stok : <strong
                                    class="text-gray-700">2</strong>
                            </p>
                        </div>
                    </div>

                    <div class="p-5 pt-0">
                        <button
                            class="w-full bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm">
                            Edit Peralatan
                        </button>
                    </div>
                </div>

            </div>

            <!-- Footer Pagination -->
            <div class="flex flex-col sm:flex-row items-center justify-between gap-4 pt-2 border-t border-gray-100">
                <p class="text-xs text-gray-400">
                    Menampilkan <strong class="text-gray-700">6</strong> dari <strong class="text-gray-700">24</strong>
                    peralatan total di Kampus Utama Politeknik Negeri Batam
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