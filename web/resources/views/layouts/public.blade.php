<!DOCTYPE html>
<html lang="id" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'mySBUM - Politeknik Negeri Batam')</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
    </style>
</head>
<body class="bg-slate-50 text-slate-800 antialiased flex flex-col min-h-screen">

    <!-- Header / Navbar -->
    <header class="sticky top-0 z-50 bg-white/90 backdrop-blur-md border-b border-slate-200/80">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-16 flex items-center justify-between">
            <!-- Brand Logo -->
            <a href="/" class="flex items-center space-x-3">
                <div class="w-9 h-9 rounded-lg bg-[#056839] flex items-center justify-center text-white font-extrabold text-base shadow-sm">
                    SB
                </div>
                <div class="flex flex-col">
                    <span class="font-bold text-slate-900 text-base leading-none">mySBUM</span>
                    <span class="text-[10px] text-slate-500 font-semibold tracking-wider uppercase">POLIBATAM</span>
                </div>
            </a>

            <!-- Navigation Links -->
            <nav class="hidden md:flex items-center space-x-8 text-xs font-semibold text-slate-600">
                <a href="#fitur" class="hover:text-[#056839] transition">Fitur</a>
                <a href="#ruangan-alat" class="hover:text-[#056839] transition">Ruangan & Peralatan</a>
                <a href="#cara-kerja" class="hover:text-[#056839] transition">Cara Kerja</a>
                <a href="#tentang" class="hover:text-[#056839] transition">Tentang</a>
            </nav>

            <!-- Auth Button -->
            <div class="flex items-center space-x-3">
                <a href="{{ route('login') }}" class="bg-[#056839] hover:bg-emerald-900 text-white text-xs font-semibold px-5 py-2 rounded-lg transition shadow-sm">
                    Masuk
                </a>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="flex-grow">
        @yield('content')
    </main>

    <!-- Footer -->
    <footer class="bg-slate-900 text-white pt-12 pb-8 border-t border-slate-800">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-8 pb-8 border-b border-slate-800">
                
                <!-- Brand Info -->
                <div class="md:col-span-1 space-y-3">
                    <div class="flex items-center space-x-2">
                        <div class="w-8 h-8 rounded-lg bg-[#056839] flex items-center justify-center text-white font-bold text-sm">
                            SB
                        </div>
                        <span class="font-bold text-lg text-white">my SBUM</span>
                    </div>
                    <p class="text-xs text-slate-400 leading-relaxed">
                        Layanan peminjaman ruang dan peralatan Politeknik Negeri Batam yang mudah, transparan, dan terintegrasi.
                    </p>
                </div>

                <!-- Column 1: Layanan -->
                <div>
                    <h3 class="text-xs font-bold text-slate-300 uppercase tracking-wider mb-3">Layanan</h3>
                    <ul class="space-y-2 text-xs text-slate-400">
                        <li><a href="#" class="hover:text-white transition">Ruangan</a></li>
                        <li><a href="#" class="hover:text-white transition">Peralatan</a></li>
                        <li><a href="#" class="hover:text-white transition">Status pengajuan</a></li>
                    </ul>
                </div>

                <!-- Column 2: Bantuan -->
                <div>
                    <h3 class="text-xs font-bold text-slate-300 uppercase tracking-wider mb-3">Bantuan</h3>
                    <ul class="space-y-2 text-xs text-slate-400">
                        <li><a href="#cara-kerja" class="hover:text-white transition">Cara kerja</a></li>
                        <li><a href="#tentang" class="hover:text-white transition">Tentang SBUM</a></li>
                        <li><a href="#" class="hover:text-white transition">Kontak pengelola</a></li>
                    </ul>
                </div>

                <!-- Column 3: Kampus -->
                <div>
                    <h3 class="text-xs font-bold text-slate-300 uppercase tracking-wider mb-3">Kampus</h3>
                    <ul class="space-y-2 text-xs text-slate-400">
                        <li><a href="https://polibatam.ac.id" target="_blank" class="hover:text-white transition flex items-center">
                            polibatam.ac.id
                            <svg class="w-3 h-3 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>
                        </a></li>
                    </ul>
                </div>

            </div>

            <!-- Bottom Footer Bar -->
            <div class="pt-6 flex flex-col sm:flex-row items-center justify-between text-xs text-slate-400 space-y-3 sm:space-y-0">
                <p>&copy; 2026 mySBUM Politeknik Negeri Batam</p>
                <div class="flex items-center space-x-2">
                    <span class="text-slate-400">Bahasa Indonesia</span>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>