<aside class="w-64 bg-white border-r border-gray-100 flex flex-col justify-between hidden md:flex shrink-0 h-full">
    <div>
        <!-- Sidebar Header / Logo -->
        <div class="p-6 flex items-center justify-between border-b border-gray-50">
            <div class="flex items-center gap-3">
                <img src="{{ asset('storage/images/logo.png') }}" alt="Logo mySBUM" class="w-10 h-10 object-contain">
                <div>
                    <h1 class="font-bold text-lg text-[#006A4E] leading-none">mySBUM</h1>
                    <span class="text-[10px] text-gray-400 font-semibold tracking-wider">POLIBATAM</span>
                </div>
            </div>
        </div>

        <!-- Menu Navigation Berdasarkan Role -->
        <div class="p-4">
            <p class="text-[10px] font-bold text-gray-400 tracking-wider mb-3 px-3 uppercase">OPERASIONAL UTAMA</p>
            <nav class="space-y-1">

                @php
                    $role = Auth::user()->role ?? '';
                @endphp

                {{-- ========================================== --}}
                {{-- 1. MENU PENANGGUNG JAWAB (lecturer) --}}
                {{-- ========================================== --}}
                @if($role === 'lecturer')
                    <a href="{{ route('dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('dashboard') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ route('ruangan.pj') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('ruangan.pj') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-building w-5"></i>
                        Peminjaman Ruangan
                    </a>

                    <a href="{{ route('peralatan.pj') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('peralatan.pj') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-box-archive w-5"></i>
                        Peminjaman Alat
                    </a>

                    <a href="{{ route('persetujuan.pj') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('persetujuan.pj') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <a href="{{ route('riwayat.pj') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('riwayat.pj') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-rotate-left w-5"></i>
                        Riwayat
                    </a>

                    {{-- ========================================== --}}
                    {{-- 2. MENU PIC (pic) --}}
                    {{-- ========================================== --}}
                @elseif($role === 'pic')
                    <a href="{{ route('pic.dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('pic.dashboard') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ route('ruangan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('ruangan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-building w-5"></i>
                        Peminjaman Ruangan
                    </a>

                    <a href="{{ route('peralatan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('peralatan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-box-archive w-5"></i>
                        Peminjaman Alat
                    </a>

                    <a href="{{ route('persetujuan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('persetujuan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <a href="{{ route('riwayat.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('riwayat.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-rotate-left w-5"></i>
                        Riwayat
                    </a>

                    <p class="text-[10px] font-bold text-gray-400 tracking-wider pt-4 pb-2 px-3 uppercase">KELOLA INVENTARIS
                    </p>

                    <a href="{{ route('kelola.ruangan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kelola.ruangan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-door-open w-5"></i>
                        Kelola Ruangan
                    </a>

                    <a href="{{ route('kelola.peralatan.pic') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kelola.peralatan.pic') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-toolbox w-5"></i>
                        Kelola Peralatan
                    </a>

                    {{-- ========================================== --}}
                    {{-- 3. MENU ADMIN SBUM (admin) --}}
                    {{-- ========================================== --}}
                @elseif($role === 'admin')
                    <a href="{{ route('admin.dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('admin.dashboard') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ route('persetujuan.admin') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('persetujuan.admin') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <a href="{{ route('kelola.ruangan.admin') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kelola.ruangan.admin') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-door-open w-5"></i>
                        Kelola Ruangan
                    </a>

                    <a href="{{ route('kelola.peralatan.admin') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kelola.peralatan.admin') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-toolbox w-5"></i>
                        Kelola Peralatan
                    </a>

                    <a href="{{ route('kalender.admin') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kalender.admin') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-calendar-days w-5"></i>
                        Kalender Peminjaman
                    </a>

                    {{-- ========================================== --}}
                    {{-- 4. MENU KEPALA SBUM (kepala) --}}
                    {{-- ========================================== --}}
                @elseif($role === 'kepala')
                    <a href="{{ route('kepala.dashboard') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kepala.dashboard') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-border-all w-5"></i>
                        Dashboard
                    </a>

                    <a href="{{ route('persetujuan.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('persetujuan.kepala') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-circle-check w-5"></i>
                        Persetujuan
                    </a>

                    <a href="{{ route('kalender.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('kalender.kepala') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-regular fa-calendar-days w-5"></i>
                        Kalender Peminjaman
                    </a>

                    <p class="text-[10px] font-bold text-gray-400 tracking-wider pt-4 pb-2 px-3 uppercase">MANAJEMEN AKUN
                    </p>

                    <a href="{{ route('admin.kepala') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl font-medium text-sm transition-all {{ request()->routeIs('admin.kepala') || request()->routeIs('admin.create.kepala') ? 'bg-[#006A4E] text-white shadow-sm' : 'text-gray-500 hover:bg-gray-50 hover:text-gray-700' }}">
                        <i class="fa-solid fa-users-gear w-5"></i>
                        Kelola Admin
                    </a>
                @endif

            </nav>
        </div>
    </div>
</aside>