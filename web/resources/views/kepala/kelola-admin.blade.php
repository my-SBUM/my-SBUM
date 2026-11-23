<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelola Admin - Kepala SBUM</title>
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

            <!-- Menu Navigation -->
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

                    <a href="{{ route('kalender.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-regular fa-calendar-days w-5"></i>
                        Kalender
                    </a>

                    <a href="{{ route('admin.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl bg-[#006A4E] text-white font-medium text-sm transition-all shadow-sm">
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

            <!-- Profile User -->
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
                </div>
            </div>
        </header>

        <!-- MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Breadcrumb, Header Title & Button Tambah Admin -->
            <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                        <a href="{{ route('kepala.dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                        <span>&gt;</span>
                        <span class="text-[#006A4E] font-semibold">Kelola Admin</span>
                    </nav>
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Kelola Admin</h1>
                    <p class="text-xs text-gray-500 mt-1">
                        Kelola hak akses, tambah admin baru, dan hapus
                    </p>
                </div>

                <!-- Link ke Halaman Tambah Admin -->
                <a href="{{ route('admin.create.kepala') }}"
                    class="bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold px-5 py-3 rounded-xl transition-all flex items-center gap-2 shadow-sm shrink-0 self-start md:self-auto">
                    <i class="fa-solid fa-plus text-xs"></i> Tambah Admin Baru
                </a>
            </div>

            <!-- Alert Success Message -->
            @if(session('success'))
                <div
                    class="bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs p-4 rounded-xl flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <i class="fa-solid fa-circle-check text-emerald-600"></i>
                        <span>{{ session('success') }}</span>
                    </div>
                </div>
            @endif

            <!-- Overview Cards (Hasil Hitung Dinamis Database) -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

                <!-- Card 1: Total Pengguna Aktif -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">Total Pengguna
                            Aktif</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">{{ $totalActive }}</span>
                            <span class="text-xs text-gray-400 font-medium">Akun</span>
                        </div>
                    </div>
                </div>

                <!-- Card 2: PIC Laboratorium -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">PIC
                            Laboratorium</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">{{ $picCount }}</span>
                            <span class="text-xs text-gray-400 font-medium">PIC</span>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Dosen Pembina -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">Dosen Pembina</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">{{ $lecturerCount }}</span>
                            <span class="text-xs text-gray-400 font-medium">Dosen</span>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Akun Nonaktif / Suspend -->
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] border-l-4 border-l-amber-500 flex flex-col justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">Akun Nonaktif /
                            Suspend</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">{{ $inactiveCount }}</span>
                            <span class="text-xs text-gray-400 font-medium">Akun</span>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Table Container: Daftar Administrator & Otoritas -->
            <div class="bg-white rounded-2xl border border-gray-100 shadow-[0_2px_12px_rgba(0,0,0,0.02)] p-6 space-y-6">

                <!-- Table Header & Search Input -->
                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
                    <h2 class="font-bold text-gray-800 text-base">Daftar Administrator &amp; Otoritas</h2>

                    <form action="{{ route('admin.kepala') }}" method="GET" class="relative w-full sm:w-80">
                        <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center text-gray-400">
                            <i class="fa-solid fa-magnifying-glass text-xs"></i>
                        </span>
                        <input type="text" name="search" value="{{ $search }}" placeholder="Cari nama atau NIP..."
                            class="w-full pl-9 pr-4 py-2.5 bg-[#F8FAFC] border border-gray-100 rounded-xl text-xs text-gray-700 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] transition-all">
                    </form>
                </div>

                <!-- Data Table Dinamis -->
                <div class="overflow-x-auto">
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr
                                class="text-[10px] font-bold text-gray-400 uppercase tracking-wider border-b border-gray-100 pb-3">
                                <th class="pb-3 font-semibold">PENGGUNA &amp; NIP</th>
                                <th class="pb-3 font-semibold">DEPARTEMEN / UNIT KERJA</th>
                                <th class="pb-3 font-semibold">STATUS</th>
                                <th class="pb-3 font-semibold text-right pr-4">AKSI</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50 text-xs">

                            @forelse($admins as $admin)
                                <tr class="hover:bg-gray-50/50 transition-colors">
                                    <td class="py-4">
                                        <div class="flex items-center gap-3">
                                            <!-- Avatar Otomatis dari Nama -->
                                            <img src="https://ui-avatars.com/api/?name={{ urlencode($admin->name) }}&background=006A4E&color=fff&bold=true"
                                                alt="{{ $admin->name }}" class="w-10 h-10 rounded-full object-cover">
                                            <div>
                                                <h3 class="font-bold text-gray-800 text-xs">{{ $admin->name }}</h3>
                                                <p class="text-[11px] text-gray-400 font-medium">NIP:
                                                    {{ $admin->id_number }}</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-4 text-gray-600 font-medium text-xs">
                                        {{ $admin->department ?? 'Pusat Operasional Sarana' }}
                                    </td>
                                    <td class="py-4">
                                        @if(isset($admin->is_active) && $admin->is_active == 0)
                                            <span
                                                class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-bold bg-rose-50 text-rose-600">
                                                <span class="w-1.5 h-1.5 rounded-full bg-rose-500"></span> Nonaktif
                                            </span>
                                        @else
                                            <span
                                                class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-[10px] font-bold bg-[#DCFCE7] text-[#15803D]">
                                                <span class="w-1.5 h-1.5 rounded-full bg-[#15803D]"></span> Aktif
                                            </span>
                                        @endif
                                    </td>
                                    <td class="py-4 text-right pr-2">
                                        <div class="flex items-center justify-end gap-2">
                                            <button
                                                class="bg-[#FF6B35] hover:bg-[#e05825] text-white text-[11px] font-bold px-3.5 py-1.5 rounded-xl transition-all flex items-center gap-1.5 shadow-sm">
                                                <i class="fa-solid fa-pen text-[10px]"></i> Edit
                                            </button>
                                            <button
                                                class="bg-[#F04438] hover:bg-[#d93226] text-white text-[11px] font-bold px-3.5 py-1.5 rounded-xl transition-all flex items-center gap-1.5 shadow-sm">
                                                <i class="fa-regular fa-trash-can text-[10px]"></i> Hapus
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="text-center py-8 text-gray-400 text-xs">
                                        Belum ada data administrator atau data tidak ditemukan.
                                    </td>
                                </tr>
                            @endforelse

                        </tbody>
                    </table>
                </div>

                <!-- Footer Pagination Dinamis -->
                <div class="flex flex-col sm:flex-row items-center justify-between gap-4 pt-2 border-t border-gray-50">
                    <p class="text-xs text-gray-400">
                        Menampilkan <strong class="text-gray-700">{{ $admins->firstItem() ?? 0 }} -
                            {{ $admins->lastItem() ?? 0 }}</strong> dari <strong
                            class="text-gray-700">{{ $admins->total() }}</strong> pengguna
                    </p>
                    <div>
                        {{ $admins->links() }}
                    </div>
                </div>

            </div>

        </main>
    </div>

</body>

</html>