<header class="h-20 bg-white border-b border-slate-100 px-8 flex items-center justify-between">
    <div class="flex items-center space-x-4">
        <button @click="sidebarOpen = !sidebarOpen" class="md:hidden text-slate-500">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
        </button>
    </div>

    <!-- User Profile Header -->
    <div class="flex items-center space-x-3">
        <div class="w-9 h-9 rounded-full bg-[#056839] text-white flex items-center justify-center font-bold text-xs">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
        </div>
        <div class="text-left leading-tight">
            <p class="text-xs font-bold text-slate-800">Dr. Ir. Hendra W.</p>
            <p class="text-[10px] text-slate-400 font-medium">Koordinator Lab</p>
        </div>
    </div>
</header>