<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrasi - mySBUM Polibatam</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }

        /* Pola titik-titik halus di sisi kanan */
        .bg-grid-pattern {
            background-image: radial-gradient(rgba(255, 255, 255, 0.14) 1.5px, transparent 1.5px);
            background-size: 28px 28px;
        }
    </style>
</head>

<body class="min-h-screen flex bg-white text-gray-800">

    <!-- SISI KIRI: FORM REGISTRASI (50% Lebar di Desktop) -->
    <div class="w-full lg:w-1/2 flex flex-col justify-between p-8 sm:p-12 lg:px-16 lg:py-10 bg-white overflow-y-auto">

        <!-- Kontainer Form Tengah -->
        <div class="w-full max-w-[420px] mx-auto my-auto py-4">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 tracking-tight">Buat Akun Baru</h1>
            <p class="text-xs sm:text-sm text-gray-500 mt-1.5 mb-6">Lengkapi data diri Anda untuk mengakses sistem
                pengelola fasilitas</p>

            <!-- Alert Error Sistem -->
            @if(session('error'))
                <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl mb-5 text-xs font-medium">
                    {{ session('error') }}
                </div>
            @endif

            <!-- Alert Error Validasi -->
            @if($errors->any())
                <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl mb-5 text-xs">
                    <ul class="list-disc pl-4 space-y-1">
                        @foreach($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <!-- Form Registrasi (Mengarah ke route('register.store')) -->
            <form action="{{ route('register.store') }}" method="POST" class="space-y-4">
                @csrf

                <!-- Nama Lengkap -->
                <div>
                    <label for="name" class="block text-xs font-semibold text-gray-700 mb-1">Nama Lengkap <span
                            class="text-red-500">*</span></label>
                    <input type="text" name="name" id="name" value="{{ old('name') }}" required autofocus
                        class="w-full px-3.5 py-2.5 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                        placeholder="Contoh: Ahmad Rizky Pratama">
                </div>

                <!-- Grid NIP/NIM & Jabatan -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                    <!-- NIP / NIM -->
                    <div>
                        <label for="id_number" class="block text-xs font-semibold text-gray-700 mb-1">NIP / NIM <span
                                class="text-red-500">*</span></label>
                        <input type="number" name="id_number" id="id_number" value="{{ old('id_number') }}" required
                            class="w-full px-3.5 py-2.5 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                            placeholder="Contoh: 19850101">
                    </div>

                    <!-- Mendaftar Sebagai (3 Aktor Web) -->
                    <div>
                        <label for="role" class="block text-xs font-semibold text-gray-700 mb-1">Mendaftar Sebagai <span
                                class="text-red-500">*</span></label>
                        <div class="relative">
                            <select name="role" id="role" required
                                class="w-full px-3.5 py-2.5 pr-8 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all appearance-none cursor-pointer">
                                <option value="" disabled selected>Pilih Jabatan</option>
                                <option value="lecturer" {{ old('role') == 'lecturer' ? 'selected' : '' }}>Penanggung
                                    Jawab</option>
                                <option value="pic" {{ old('role') == 'pic' ? 'selected' : '' }}>PIC</option>
                                <option value="kepala" {{ old('role') == 'kepala' ? 'selected' : '' }}>Kepala SBUM
                                </option>
                            </select>
                            <div class="absolute inset-y-0 right-0 pr-2.5 flex items-center pointer-events-none">
                                <svg class="w-4 h-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                    stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Grid Email & Nomor HP -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                    <!-- Email -->
                    <div>
                        <label for="email" class="block text-xs font-semibold text-gray-700 mb-1">Email Institusi <span
                                class="text-red-500">*</span></label>
                        <input type="email" name="email" id="email" value="{{ old('email') }}" required
                            class="w-full px-3.5 py-2.5 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                            placeholder="nama@polibatam.ac.id">
                    </div>

                    <!-- Nomor Handphone -->
                    <div>
                        <label for="phone_number" class="block text-xs font-semibold text-gray-700 mb-1">Nomor HP (WA)
                            <span class="text-red-500">*</span></label>
                        <input type="text" name="phone_number" id="phone_number" value="{{ old('phone_number') }}"
                            required
                            class="w-full px-3.5 py-2.5 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                            placeholder="081234567890">
                    </div>
                </div>

                <!-- Grid Password & Konfirmasi Password -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3.5">
                    <!-- Password -->
                    <div>
                        <label for="password" class="block text-xs font-semibold text-gray-700 mb-1">Password <span
                                class="text-red-500">*</span></label>
                        <div class="relative">
                            <input type="password" name="password" id="password" required
                                class="w-full px-3.5 py-2.5 pr-9 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                                placeholder="Min. 8 karakter">
                            <button type="button" onclick="toggleInput('password', 'eye-1')"
                                class="absolute inset-y-0 right-0 pr-2.5 flex items-center text-gray-400 hover:text-gray-600 focus:outline-none">
                                <svg id="eye-1" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                    stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                </svg>
                            </button>
                        </div>
                    </div>

                    <!-- Konfirmasi Password -->
                    <div>
                        <label for="password_confirmation"
                            class="block text-xs font-semibold text-gray-700 mb-1">Konfirmasi Password <span
                                class="text-red-500">*</span></label>
                        <div class="relative">
                            <input type="password" name="password_confirmation" id="password_confirmation" required
                                class="w-full px-3.5 py-2.5 pr-9 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                                placeholder="Ulangi password">
                            <button type="button" onclick="toggleInput('password_confirmation', 'eye-2')"
                                class="absolute inset-y-0 right-0 pr-2.5 flex items-center text-gray-400 hover:text-gray-600 focus:outline-none">
                                <svg id="eye-2" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                    stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Tombol Submit -->
                <button type="submit"
                    class="w-full bg-[#097b53] hover:bg-[#076040] text-white text-sm font-semibold py-2.5 px-4 rounded-lg shadow-sm transition-colors mt-3">
                    Daftar Akun
                </button>
            </form>

            <!-- Link ke Halaman Login -->
            <p class="text-center text-xs text-gray-500 mt-6">
                Sudah memiliki akun?
                <a href="{{ route('login') }}" class="font-semibold text-[#097b53] hover:underline">Masuk di sini</a>
            </p>
        </div>
    </div>

    <!-- SISI KANAN: BACKGROUND GAMBAR & HIJAU TUA (50% Lebar di Desktop) -->
    <div
        class="hidden lg:flex lg:w-1/2 bg-[#064e35] bg-grid-pattern relative items-center justify-center p-12 overflow-hidden">

        <!-- Gambar Background dari public/storage/images/kampus.png -->
        <img src="{{ asset('storage/images/kampus.png') }}" alt="Fasilitas Kampus"
            class="absolute inset-0 w-full h-full object-cover opacity-35">

        <!-- Overlay Gradasi Hijau Tua -->
        <div class="absolute inset-0 bg-gradient-to-t from-[#032e1f]/90 via-[#064e35]/70 to-[#097b53]/60"></div>

        <!-- Konten Visual di Atas Background -->
        <div class="relative z-10 max-w-md text-center text-white">
            <div class="bg-white/10 backdrop-blur-md border border-white/20 rounded-3xl p-8 shadow-2xl">
                <div class="w-20 h-20 bg-[#31a364] rounded-2xl mx-auto flex items-center justify-center shadow-lg mb-6">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor" class="w-10 h-10 text-white">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-1.043 3.296 3.745 3.745 0 01-3.296 1.043A3.745 3.745 0 0112 21c-1.268 0-2.39-.63-3.068-1.593a3.746 3.746 0 01-3.296-1.043 3.745 3.745 0 01-1.043-3.296A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 011.043-3.296 3.746 3.746 0 013.296-1.043A3.746 3.746 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.746 3.746 0 013.296 1.043 3.746 3.746 0 011.043 3.296A3.745 3.745 0 0121 12z" />
                    </svg>
                </div>
                <h2 class="text-2xl font-bold tracking-tight mb-2">Bergabung dengan Pengelola Fasilitas</h2>
                <p class="text-sm text-emerald-100/80 leading-relaxed">
                    Daftarkan akun Anda sebagai Penanggung Jawab, PIC, atau Kepala SBUM untuk mengelola jadwal dan
                    persetujuan peminjaman kampus.
                </p>

                <div
                    class="mt-6 pt-6 border-t border-white/15 flex items-center justify-center gap-6 text-xs text-emerald-100">
                    <div class="flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-[#4ade80]"></span>
                        <span>Akses Multi-Peran</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-[#4ade80]"></span>
                        <span>Terintegrasi Mobile</span>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Script Toggle Password -->
    <script>
        function toggleInput(inputId, iconId) {
            const input = document.getElementById(inputId);
            const icon = document.getElementById(iconId);
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.add('text-[#097b53]');
            } else {
                input.type = 'password';
                icon.classList.remove('text-[#097b53]');
            }
        }
    </script>

</body>

</html>