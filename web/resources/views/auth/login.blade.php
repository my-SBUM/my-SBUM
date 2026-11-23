<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - mySBUM Polibatam</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }

        /* Pola garis/titik halus di sisi kanan */
        .bg-grid-pattern {
            background-image: radial-gradient(rgba(255, 255, 255, 0.14) 1.5px, transparent 1.5px);
            background-size: 28px 28px;
        }
    </style>
</head>

<body class="min-h-screen flex bg-white text-gray-800">

    <!-- SISI KIRI: FORM LOGIN (50% Lebar di Desktop) -->
    <div class="w-full lg:w-1/2 flex flex-col justify-between p-8 sm:p-12 lg:px-20 lg:py-12 bg-white">

        <!-- Kontainer Form Tengah -->
        <div class="w-full max-w-[380px] mx-auto my-auto py-8">
            <h1 class="text-3xl font-bold text-gray-900 tracking-tight">Selamat datang</h1>
            <p class="text-sm text-gray-500 mt-2 mb-7">Silakan masukkan NIP/NIM dan kata sandi Anda</p>

            <!-- Alert Sukses -->
            @if(session('success'))
                <div
                    class="bg-emerald-50 border border-emerald-200 text-emerald-700 px-4 py-3 rounded-xl mb-5 text-xs font-medium">
                    {{ session('success') }}
                </div>
            @endif

            <!-- Alert Error -->
            @if(session('error'))
                <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl mb-5 text-xs font-medium">
                    {{ session('error') }}
                </div>
            @endif

            @if($errors->any())
                <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl mb-5 text-xs">
                    <ul class="list-disc pl-4 space-y-1">
                        @foreach($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <!-- Form Login (Sudah diarahkan ke route('login.store')) -->
            <form action="{{ route('login.store') }}" method="POST" class="space-y-4">
                @csrf

                <!-- Input NIP / NIM / Email -->
                <div>
                    <label for="login_id" class="block text-xs font-semibold text-gray-700 mb-1.5">NIP / NIM /
                        Email</label>
                    <input type="text" name="login_id" id="login_id" value="{{ old('login_id') }}" required autofocus
                        class="w-full px-3.5 py-2.5 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                        placeholder="Masukkan NIP, NIM, atau Email">
                </div>

                <!-- Input Password -->
                <div>
                    <label for="password" class="block text-xs font-semibold text-gray-700 mb-1.5">Password</label>
                    <div class="relative">
                        <input type="password" name="password" id="password" required
                            class="w-full px-3.5 py-2.5 pr-10 bg-white border border-gray-300 rounded-lg text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#097b53] focus:ring-2 focus:ring-[#097b53]/20 transition-all"
                            placeholder="••••••••">

                        <!-- Tombol Lihat Password -->
                        <button type="button" onclick="togglePassword()"
                            class="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600 focus:outline-none">
                            <svg id="eye-icon" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor"
                                stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Tombol Masuk -->
                <button type="submit"
                    class="w-full bg-[#097b53] hover:bg-[#076040] text-white text-sm font-semibold py-2.5 px-4 rounded-lg shadow-sm transition-colors mt-2">
                    Masuk
                </button>
            </form>

            <!-- Link Registrasi -->
            <p class="text-center text-xs text-gray-500 mt-6">
                Belum memiliki akun?
                <a href="{{ route('register') }}" class="font-semibold text-[#097b53] hover:underline">Daftar
                    sekarang</a>
            </p>
        </div>
    </div>

    <!-- SISI KANAN: BACKGROUND GAMBAR & HIJAU TUA (50% Lebar di Desktop) -->
    <div
        class="hidden lg:flex lg:w-1/2 bg-[#064e35] bg-grid-pattern relative items-center justify-center p-12 overflow-hidden">

        <!-- Gambar Background (Bisa Anda ganti dengan foto gedung kampus Polibatam di public/images/...) -->
        <img src="{{ asset('storage/images/kampus.png') }}" alt="Fasilitas Kampus"
            class="absolute inset-0 w-full h-full object-cover opacity-35">

        <!-- Overlay Gradasi Hijau Tua -->
        <div class="absolute inset-0 bg-gradient-to-t from-[#032e1f]/90 via-[#064e35]/70 to-[#097b53]/60"></div>

        <!-- Konten Visual & Ilustrasi di Atas Background -->
        <div class="relative z-10 max-w-md text-center text-white">
            <!-- Kartu Ilustrasi Mengambang -->
            <div class="bg-white/10 backdrop-blur-md border border-white/20 rounded-3xl p-8 shadow-2xl mb-8">
                <div class="w-20 h-20 bg-[#31a364] rounded-2xl mx-auto flex items-center justify-center shadow-lg mb-6">
                    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.8"
                        stroke="currentColor" class="w-10 h-10 text-white">
                        <path stroke-linecap="round" stroke-linejoin="round"
                            d="M3.75 21h16.5M4.5 3h15M5.25 3v18m13.5-18v18M9 6.75h1.5m-1.5 3h1.5m-1.5 3h1.5m3-6H15m-1.5 3H15m-1.5 3H15M9 21v-3.375c0-.621.504-1.125 1.125-1.125h3.75c.621 0 1.125.504 1.125 1.125V21" />
                    </svg>
                </div>
                <h2 class="text-2xl font-bold tracking-tight mb-2">Sistem Peminjaman Sarana & Prasarana</h2>
                <p class="text-sm text-emerald-100/80 leading-relaxed">
                    Kelola peminjaman ruangan kelas, laboratorium, serta peralatan inventaris kampus secara terpadu dan
                    real-time.
                </p>

                <!-- Badge Status Kecil -->
                <div
                    class="mt-6 pt-6 border-t border-white/15 flex items-center justify-center gap-6 text-xs text-emerald-100">
                    <div class="flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-[#4ade80]"></span>
                        <span>Persetujuan Cepat</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="w-2 h-2 rounded-full bg-[#4ade80]"></span>
                        <span>Jadwal Terintegrasi</span>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Script Toggle Password -->
    <script>
        function togglePassword() {
            const input = document.getElementById('password');
            const icon = document.getElementById('eye-icon');
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