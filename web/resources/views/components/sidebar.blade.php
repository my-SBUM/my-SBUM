<aside class="w-64 bg-white border-r border-slate-200/80 flex-shrink-0 hidden md:flex flex-col justify-between">
    <div>
        <!-- Brand Header -->
        <div class="h-20 flex items-center justify-between px-6 border-b border-slate-100">
            <a href="#" class="flex items-center space-x-3">
                <div class="w-9 h-9 rounded-xl bg-[#056839] flex items-center justify-center text-white font-extrabold text-sm shadow-sm">
                    SB
                </div>
                <div class="flex flex-col">
                    <span class="font-extrabold text-slate-900 text-base leading-none">mySBUM</span>
                    <span class="text-[10px] text-slate-400 font-bold uppercase tracking-wider mt-1">POLIBATAM</span>
                </div>
            </a>
            <button class="text-slate-400 hover:text-slate-600">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7"></path></svg>
            </button>
        </div>

        <div class="px-6 pt-6 pb-2">
            <span class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">OPERASIONAL UTAMA</span>
        </div>

        <!-- Navigation Menu -->
        <nav class="px-3 space-y-1 text-xs font-semibold">
            @if(request()->is('kepala-sbum*'))
                <!-- ==================== NAVIGASI KHUSUS KEPALA SBUM ==================== -->
                <a href="{{ route('kepala-sbum.dashboard') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('kepala-sbum.dashboard') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                    <span>Dashboard</span>
                </a>

                <a href="{{ route('kepala-sbum.persetujuan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('kepala-sbum.persetujuan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>Prsetujuan</span>
                </a>

                <a href="{{ route('kepala-sbum.kalender.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('kepala-sbum.kalender.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    <span>Kalender</span>
                </a>

                <a href="{{ route('kepala-sbum.admin.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('kepala-sbum.admin.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                    <span>Kelola Admin</span>
                </a>

            @elseif(request()->is('admin*'))
                <!-- ==================== NAVIGASI KHUSUS ADMIN ==================== -->
                <a href="{{ route('admin.dashboard') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('admin.dashboard') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                    <span>Dashboard</span>
                </a>
                <a href="{{ route('admin.persetujuan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('admin.persetujuan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>Prsetujuan</span>
                </a>
                <a href="{{ route('admin.ruangan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('admin.ruangan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>
                    <span>Kelola Ruangan</span>
                </a>
                <a href="{{ route('admin.peralatan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('admin.peralatan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z"></path></svg>
                    <span>Kelola Peralatan</span>
                </a>
                <a href="{{ route('admin.kalender.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('admin.kalender.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                    <span>Kalender</span>
                </a>

            @elseif(request()->is('pic*'))
                <!-- ==================== NAVIGASI KHUSUS PIC ==================== -->
                <a href="{{ route('pic.dashboard') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.dashboard') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                    <span>Dashboard</span>
                </a>
                <a href="{{ route('pic.peminjaman.ruangan') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.peminjaman.ruangan') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
                    <span>Peminjaman Ruangan</span>
                </a>
                <a href="{{ route('pic.peminjaman.alat') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.peminjaman.alat') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path></svg>
                    <span>Peminjaman Alat</span>
                </a>
                <a href="{{ route('pic.persetujuan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.persetujuan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>Prsetujuan</span>
                </a>
                <a href="{{ route('pic.riwayat.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.riwayat.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>Riwayat</span>
                </a>
                <a href="{{ route('pic.ruangan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.ruangan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path></svg>
                    <span>Kelola Ruangan</span>
                </a>
                <a href="{{ route('pic.peralatan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pic.peralatan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 3v2m6-2v2M9 19v2m6-2v2M5 9H3m2 6H3m18-6h-2m2 6h-2M7 19h10a2 2 0 002-2V7a2 2 0 00-2-2H7a2 2 0 00-2 2v10a2 2 0 002 2zM9 9h6v6H9V9z"></path></svg>
                    <span>Kelola Peralatan</span>
                </a>

            @else
                <!-- ==================== NAVIGASI KHUSUS PENANGGUNG JAWAB ==================== -->
                <a href="{{ route('pj.dashboard') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pj.dashboard') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path></svg>
                    <span>Dashboard</span>
                </a>
                <a href="{{ route('pj.peminjaman.ruangan') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pj.peminjaman.ruangan') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path></svg>
                    <span>Peminjaman Ruangan</span>
                </a>
                <a href="{{ route('pj.peminjaman.alat') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pj.peminjaman.alat') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path></svg>
                    <span>Peminjaman Alat</span>
                </a>
                <a href="{{ route('pj.persetujuan.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pj.persetujuan.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>Prsetujuan</span>
                </a>
                <a href="{{ route('pj.riwayat.index') }}" 
                   class="flex items-center space-x-3 px-4 py-3 rounded-xl transition {{ request()->routeIs('pj.riwayat.index') ? 'bg-[#056839] text-white shadow-sm' : 'text-slate-600 hover:bg-slate-50 hover:text-slate-900' }}">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
                    <span>Riwayat</span>
                </a>
            @endif
        </nav>
    </div>
</aside>