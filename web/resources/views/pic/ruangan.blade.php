<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peminjaman Ruangan - mySBUM</title>
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
    @include('layouts.sidebar_pic')

        <!-- MAIN WRAPPER AREA -->
        <div class="flex-grow flex flex-col min-w-0 h-full overflow-hidden">

            <!-- TOP NAVBAR / HEADER -->
            <header
                class="h-20 bg-white border-b border-gray-100 flex items-center justify-between px-6 md:px-10 shrink-0">
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
                        <span class="text-[#006A4E] font-semibold">Peminjaman Ruangan</span>
                    </nav>
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Peminjaman Ruangan</h1>
                    <p class="text-xs text-gray-500 mt-1">
                        Cari ruangan kelas, auditorium, laboratorium, dan aula yang tersedia untuk kegiatan akademik
                        maupun
                        ormawa.
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

                        <!-- Kapasitas -->
                        <div class="relative">
                            <select
                                class="appearance-none bg-[#F0F3FC] text-[#1E293B] font-medium text-xs py-2.5 pl-4 pr-8 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#006A4E] cursor-pointer">
                                <option value="">Kapasitas</option>
                                <option value="1">1 - 30 Orang</option>
                                <option value="2">31 - 50 Orang</option>
                                <option value="3">&gt; 50 Orang</option>
                            </select>
                            <div
                                class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600">
                                <i class="fa-solid fa-chevron-down text-[10px]"></i>
                            </div>
                        </div>

                        <!-- Gedung -->
                        <div class="relative">
                            <select
                                class="appearance-none bg-[#F0F3FC] text-[#1E293B] font-medium text-xs py-2.5 pl-4 pr-8 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#006A4E] cursor-pointer">
                                <option value="">Gedung</option>
                                <option value="utama">Gedung Utama</option>
                                <option value="gkb">Gedung Kuliah Bersama</option>
                                <option value="tf">Gedung Teaching Factory</option>
                            </select>
                            <div
                                class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600">
                                <i class="fa-solid fa-chevron-down text-[10px]"></i>
                            </div>
                        </div>

                        <!-- Lantai -->
                        <div class="relative">
                            <select
                                class="appearance-none bg-[#F0F3FC] text-[#1E293B] font-medium text-xs py-2.5 pl-4 pr-8 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#006A4E] cursor-pointer">
                                <option value="">Lantai</option>
                                <option value="1">Lantai 1</option>
                                <option value="2">Lantai 2</option>
                                <option value="3">Lantai 3</option>
                            </select>
                            <div
                                class="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-3 text-gray-600">
                                <i class="fa-solid fa-chevron-down text-[10px]"></i>
                            </div>
                        </div>

                    </div>

                </div>

                <!-- Section Title -->
                <h2 class="text-base font-bold text-gray-800 pt-2">Daftar Ruangan</h2>

                <!-- Cards Grid (3 Columns) -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">

                    <!-- Card 1: Auditorium Graha Widya (Tersedia) -->
                    <div
                        class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                        <div>
                            <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                                <img src="https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=600&q=80"
                                    alt="Auditorium" class="w-full h-full object-cover">
                                <span
                                    class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                                </span>
                                <span
                                    class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                    <i class="fa-solid fa-building text-[10px]"></i> Gedung Utama Lt. 2
                                </span>
                            </div>
                            <h3 class="font-bold text-gray-800 text-sm">Auditorium Graha Widya</h3>
                            <p class="text-xs text-gray-400 mt-1 line-clamp-2">Ruang aula konferensi utama dengan
                                akustik...
                            </p>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                            <button
                                class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                            <button
                                class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                                Ruangan</button>
                        </div>
                    </div>

                    <!-- Card 2: Smart Classroom B.301 (Tersedia) -->
                    <div
                        class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                        <div>
                            <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                                <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=600&q=80"
                                    alt="Smart Classroom" class="w-full h-full object-cover">
                                <span
                                    class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                                </span>
                                <span
                                    class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                    <i class="fa-solid fa-building text-[10px]"></i> Gedung Kuliah Bersama Lt. 3
                                </span>
                            </div>
                            <h3 class="font-bold text-gray-800 text-sm">Smart Classroom B.301</h3>
                            <p class="text-xs text-gray-400 mt-1 line-clamp-2">Ruang kelas interaktif digital ideal
                                untuk
                                kuliah</p>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                            <button
                                class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                            <button
                                class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                                Ruangan</button>
                        </div>
                    </div>

                    <!-- Card 3: Laboratorium Multimedia & VR (Tidak Tersedia) -->
                    <div
                        class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                        <div>
                            <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                                <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=600&q=80"
                                    alt="Lab Multimedia" class="w-full h-full object-cover">
                                <span
                                    class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#FFE4E6] text-[#E11D48] flex items-center gap-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#E11D48]"></span> Tidak Tersedia
                                </span>
                                <span
                                    class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                    <i class="fa-solid fa-building text-[10px]"></i> Gedung Teaching Factory Lt. 2
                                </span>
                            </div>
                            <h3 class="font-bold text-gray-800 text-sm">Laboratorium Multimedia & VR</h3>
                            <p class="text-xs text-gray-400 mt-1 line-clamp-2">Komputasi grafis tinggi dan rendering
                                3D..
                            </p>
                        </div>
                    </div>

                    <!-- Card 4: Auditorium Graha Widya (Tersedia) -->
                    <div
                        class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                        <div>
                            <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                                <img src="https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=600&q=80"
                                    alt="Auditorium" class="w-full h-full object-cover">
                                <span
                                    class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                                </span>
                                <span
                                    class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                    <i class="fa-solid fa-building text-[10px]"></i> Gedung Utama Lt. 2
                                </span>
                            </div>
                            <h3 class="font-bold text-gray-800 text-sm">Auditorium Graha Widya</h3>
                            <p class="text-xs text-gray-400 mt-1 line-clamp-2">Ruang aula konferensi utama dengan
                                akustik...
                            </p>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                            <button
                                class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                            <button
                                class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                                Ruangan</button>
                        </div>
                    </div>

                    <!-- Card 5: Smart Classroom B.301 (Tersedia) -->
                    <div
                        class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                        <div>
                            <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                                <img src="https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=600&q=80"
                                    alt="Smart Classroom" class="w-full h-full object-cover">
                                <span
                                    class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D] flex items-center gap-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Tersedia
                                </span>
                                <span
                                    class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                    <i class="fa-solid fa-building text-[10px]"></i> Gedung Kuliah Bersama Lt. 3
                                </span>
                            </div>
                            <h3 class="font-bold text-gray-800 text-sm">Smart Classroom B.301</h3>
                            <p class="text-xs text-gray-400 mt-1 line-clamp-2">Ruang kelas interaktif digital ideal
                                untuk
                                kuliah</p>
                        </div>
                        <div class="grid grid-cols-2 gap-2 mt-4 pt-2">
                            <button
                                class="bg-[#5B636A] hover:bg-[#4A5056] text-white text-xs font-semibold py-2 rounded-lg transition-all">Detail</button>
                            <button
                                class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-semibold py-2 rounded-lg transition-all">Pinjam
                                Ruangan</button>
                        </div>
                    </div>

                    <!-- Card 6: Laboratorium Multimedia & VR (Tidak Tersedia) -->
                    <div
                        class="bg-white rounded-2xl border border-gray-100 p-4 shadow-[0_4px_20px_rgb(0,0,0,0.02)] flex flex-col justify-between">
                        <div>
                            <div class="relative rounded-xl overflow-hidden h-44 mb-3">
                                <img src="https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&w=600&q=80"
                                    alt="Lab Multimedia" class="w-full h-full object-cover">
                                <span
                                    class="absolute top-3 right-3 px-2.5 py-1 rounded-full text-[10px] font-bold bg-[#FFE4E6] text-[#E11D48] flex items-center gap-1">
                                    <span class="w-1.5 h-1.5 rounded-full bg-[#E11D48]"></span> Tidak Tersedia
                                </span>
                                <span
                                    class="absolute bottom-3 left-3 bg-slate-900/70 text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5 backdrop-blur-sm">
                                    <i class="fa-solid fa-building text-[10px]"></i> Gedung Teaching Factory Lt. 2
                                </span>
                            </div>
                            <h3 class="font-bold text-gray-800 text-sm">Laboratorium Multimedia & VR</h3>
                            <p class="text-xs text-gray-400 mt-1 line-clamp-2">Komputasi grafis tinggi dan rendering
                                3D..
                            </p>
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