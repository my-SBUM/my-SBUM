@extends('layouts.public')

@section('title', 'mySBUM - Sistem Peminjaman Alat & Fasilitas Polibatam')

@section('content')

<!-- Hero Section -->
<section class="py-12 md:py-20 bg-gradient-to-b from-emerald-50/50 to-slate-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">

            <!-- Left Hero Text -->
            <div class="lg:col-span-7 space-y-6">
                <div class="inline-flex items-center space-x-2 bg-emerald-100/80 text-[#056839] text-xs font-semibold px-3 py-1.5 rounded-full border border-emerald-200">
                    <span class="w-2 h-2 rounded-full bg-[#056839] animate-pulse"></span>
                    <span>Layanan kampus kini lebih praktis</span>
                </div>

                <h1 class="text-3xl sm:text-5xl font-extrabold text-slate-900 leading-tight">
                    Pinjam ruang <br class="hidden sm:inline">
                    dan peralatan <br class="hidden sm:inline">
                    kampus, tanpa ribet.
                </h1>

                <p class="text-slate-600 text-sm sm:text-base max-w-xl leading-relaxed">
                    my SBUM membantu civitas Politeknik Negeri Batam menemukan jadwal, mengajukan peminjaman, dan memantau persetujuan dalam satu tempat.
                </p>

                <div class="flex flex-wrap items-center gap-4 pt-2">
                    <a href="{{ route('login') }}" class="bg-[#056839] hover:bg-emerald-900 text-white font-semibold text-xs sm:text-sm px-6 py-3 rounded-xl transition shadow-sm flex items-center space-x-2">
                        <span>Mulai pengajuan</span>
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path>
                        </svg>
                    </a>
                    <a href="#cara-kerja" class="bg-white hover:bg-slate-100 text-slate-700 font-semibold text-xs sm:text-sm px-6 py-3 rounded-xl border border-slate-200 transition">
                        Lihat cara kerja
                    </a>
                </div>
            </div>

            <!-- Right Visual Mockup -->
            <div class="lg:col-span-5 relative">
                <div class="bg-white rounded-2xl p-6 shadow-xl border border-slate-200 relative overflow-hidden">
                    <div class="flex items-center justify-between pb-4 border-b border-slate-100 mb-4">
                        <div class="flex items-center space-x-2">
                            <span class="w-3 h-3 bg-rose-400 rounded-full"></span>
                            <span class="w-3 h-3 bg-amber-400 rounded-full"></span>
                            <span class="w-3 h-3 bg-emerald-400 rounded-full"></span>
                        </div>
                        <span class="text-[10px] font-bold text-slate-400 uppercase">Preview System</span>
                    </div>

                    <!-- Floating Card Sample -->
                    <div class="space-y-3">
                        <div class="bg-emerald-50 border border-emerald-100 rounded-xl p-4 flex items-center justify-between">
                            <div>
                                <span class="inline-block bg-emerald-100 text-emerald-800 text-[10px] font-bold px-2 py-0.5 rounded mb-1">Disetujui!</span>
                                <h4 class="text-xs font-bold text-slate-800">Ruang Kelas A101</h4>
                                <p class="text-[11px] text-slate-500">Jumat, 09:00 - 12:00 WIB</p>
                            </div>
                            <div class="w-8 h-8 rounded-full bg-emerald-700 text-white flex items-center justify-center font-bold text-xs">
                                &#10003;
                            </div>
                        </div>

                        <div class="bg-slate-50 border border-slate-100 rounded-xl p-4 flex items-center justify-between">
                            <div>
                                <span class="inline-block bg-amber-100 text-amber-800 text-[10px] font-bold px-2 py-0.5 rounded mb-1">Menunggu PIC</span>
                                <h4 class="text-xs font-bold text-slate-800">Proyektor Epson EB-X400</h4>
                                <p class="text-[11px] text-slate-500">Sabtu, 13:00 - 16:00 WIB</p>
                            </div>
                            <div class="w-8 h-8 rounded-full bg-slate-200 text-slate-500 flex items-center justify-center font-bold text-xs">
                                &hellip;
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- Features Section -->
<section id="fitur" class="py-16 bg-white border-y border-slate-200/80">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="text-center max-w-2xl mx-auto mb-12">
            <span class="text-xs font-extrabold text-[#056839] uppercase tracking-wider">SEMUA JADI LEBIH SEDERHANA</span>
            <h2 class="text-2xl sm:text-3xl font-bold text-slate-900 mt-1">Satu layanan untuk kebutuhan kegiatan kampus</h2>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Feature 1 -->
            <div class="p-6 bg-slate-50 rounded-2xl border border-slate-200/80 transition hover:shadow-md">
                <div class="w-10 h-10 bg-emerald-100 text-[#056839] rounded-xl flex items-center justify-center mb-4">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                </div>
                <h3 class="text-base font-bold text-slate-900 mb-2">Jadwal real-time</h3>
                <p class="text-xs text-slate-600 leading-relaxed">Lihat ketersediaan ruang dan alat sebelum mengajukan untuk menghindari bentrok jadwal.</p>
            </div>

            <!-- Feature 2 -->
            <div class="p-6 bg-slate-50 rounded-2xl border border-slate-200/80 transition hover:shadow-md">
                <div class="w-10 h-10 bg-emerald-100 text-[#056839] rounded-xl flex items-center justify-center mb-4">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                </div>
                <h3 class="text-base font-bold text-slate-900 mb-2">Pengajuan terarah</h3>
                <p class="text-xs text-slate-600 leading-relaxed">Form ringkas dengan alur persetujuan yang transparan dari Penanggung Jawab hingga PIC.</p>
            </div>

            <!-- Feature 3 -->
            <div class="p-6 bg-slate-50 rounded-2xl border border-slate-200/80 transition hover:shadow-md">
                <div class="w-10 h-10 bg-emerald-100 text-[#056839] rounded-xl flex items-center justify-center mb-4">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"></path>
                    </svg>
                </div>
                <h3 class="text-base font-bold text-slate-900 mb-2">Status selalu jelas</h3>
                <p class="text-xs text-slate-600 leading-relaxed">Pantau persetujuan, jadwal aktif, hingga riwayat peminjaman fasilitas secara rinci.</p>
            </div>
        </div>

    </div>
</section>

<!-- How It Works Section -->
<section id="cara-kerja" class="py-16 bg-slate-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">

        <div class="text-center max-w-2xl mx-auto mb-12">
            <span class="text-xs font-extrabold text-[#056839] uppercase tracking-wider">CARA KERJA</span>
            <h2 class="text-2xl sm:text-3xl font-bold text-slate-900 mt-1">Dari pencarian hingga siap digunakan</h2>
            <p class="text-xs text-slate-500 mt-2">Alur sederhana yang membuat pengajuan mudah dipahami oleh mahasiswa, dosen, dan pengelola fasilitas.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Step 1 -->
            <div class="bg-white p-6 rounded-2xl border border-slate-200/80 relative">
                <span class="text-3xl font-black text-emerald-200 absolute top-4 right-4">01</span>
                <h3 class="text-base font-bold text-slate-900 mb-2">Pilih kebutuhan</h3>
                <p class="text-xs text-slate-600 leading-relaxed">Cari ruangan atau peralatan sesuai jadwal kegiatanmu.</p>
            </div>

            <!-- Step 2 -->
            <div class="bg-white p-6 rounded-2xl border border-slate-200/80 relative">
                <span class="text-3xl font-black text-emerald-200 absolute top-4 right-4">02</span>
                <h3 class="text-base font-bold text-slate-900 mb-2">Isi pengajuan</h3>
                <p class="text-xs text-slate-600 leading-relaxed">Lengkapi tujuan, waktu, dan penanggung jawab kegiatan.</p>
            </div>

            <!-- Step 3 -->
            <div class="bg-white p-6 rounded-2xl border border-slate-200/80 relative">
                <span class="text-3xl font-black text-emerald-200 absolute top-4 right-4">03</span>
                <h3 class="text-base font-bold text-slate-900 mb-2">Pantau persetujuan</h3>
                <p class="text-xs text-slate-600 leading-relaxed">Dapatkan notifikasi dan gunakan fasilitas saat disetujui.</p>
            </div>
        </div>

        <!-- Stats Counter -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 mt-16 pt-12 border-t border-slate-200 text-center">
            <div>
                <div class="text-2xl sm:text-3xl font-extrabold text-[#056839]">1.200+</div>
                <div class="text-xs text-slate-500 font-medium mt-1">Pengguna aktif</div>
            </div>
            <div>
                <div class="text-2xl sm:text-3xl font-extrabold text-[#056839]">28</div>
                <div class="text-xs text-slate-500 font-medium mt-1">Ruang terdaftar</div>
            </div>
            <div>
                <div class="text-2xl sm:text-3xl font-extrabold text-[#056839]">96</div>
                <div class="text-xs text-slate-500 font-medium mt-1">Peralatan siap pinjam</div>
            </div>
            <div>
                <div class="text-2xl sm:text-3xl font-extrabold text-[#056839]">4,8/5</div>
                <div class="text-xs text-slate-500 font-medium mt-1">Kepuasan pengguna</div>
            </div>
        </div>

    </div>
</section>

<!-- Quick Action / CTA Section -->
<section id="tentang" class="py-16 bg-white">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-[#056839] text-white rounded-3xl p-8 sm:p-12 text-center shadow-xl relative overflow-hidden">
            <span class="text-xs font-bold text-emerald-200 uppercase tracking-widest">SIAP MEMULAI?</span>
            <h2 class="text-2xl sm:text-3xl font-bold mt-2">Wujudkan kegiatan kampusmu hari ini.</h2>
            <p class="text-emerald-100 text-xs sm:text-sm mt-2 max-w-xl mx-auto">
                Masukkan NIM untuk memulai pengajuan. Tim SBUM akan membantu memastikan kebutuhanmu tersedia.
            </p>

            <form action="{{ route('login') }}" method="GET" class="mt-8 mx-auto flex max-w-md flex-col gap-3 sm:flex-row">
                <input type="text" name="nim" placeholder="Masukkan NIM" required class="w-full rounded-xl border border-white bg-gray-200 px-4 py-3 text-xs text-[#056839] placeholder-text-[#056839] outline-none transition focus:border-white focus:ring-2 focus:ring-white/30">
                <button type="submit" class="whitespace-nowrap rounded-xl bg-slate-900 px-6 py-3 text-xs font-semibold text-white transition hover:bg-slate-800">
                    Lanjutkan pengajuan
                </button>
            </form>
        </div>
    </div>
</section>

@endsection