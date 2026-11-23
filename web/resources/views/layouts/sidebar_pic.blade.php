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

                <!-- Dashboard -->
                <a href="{{ route('pic.dashboard') }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('pic.dashboard') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                    <i class="fa-solid fa-border-all w-5"></i>
                    Dashboard
                </a>

                <!-- Peminjaman Ruangan -->
                <a href="{{ route('ruangan.pic') }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('ruangan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                    <i class="fa-regular fa-building w-5"></i>
                    Peminjaman Ruangan
                </a>

                <!-- Peminjaman Alat -->
                <a href="{{ Route::has('peralatan.pic') ? route('peralatan.pic') : '#' }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('peralatan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                    <i class="fa-solid fa-box-archive w-5"></i>
                    Peminjaman Alat
                </a>

                <!-- Persetujuan -->
                <a href="{{ Route::has('persetujuan.pic') ? route('persetujuan.pic') : '#' }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('persetujuan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                    <i class="fa-regular fa-circle-check w-5"></i>
                    Persetujuan
                </a>

                <!-- Riwayat -->
                <a href="{{ Route::has('riwayat.pic') ? route('riwayat.pic') : '#' }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('riwayat.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                    <i class="fa-solid fa-rotate-left w-5"></i>
                    Riwayat
                </a>

                <!-- Kelola Ruangan -->
                <a href="{{ Route::has('kelola.ruangan.pic') ? route('kelola.ruangan.pic') : '#' }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kelola.ruangan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                    <i class="fa-solid fa-list-check w-5"></i>
                    Kelola Ruangan
                </a>

                <!-- Kelola Peralatan -->
                <a href="{{ Route::has('kelola.peralatan.pic') ? route('kelola.peralatan.pic') : '#' }}"
                    class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kelola.peralatan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
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