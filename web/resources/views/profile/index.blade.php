<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Akun Saya - mySBUM</title>
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

    <!-- SIDEBAR FIXED -->
    <aside class="w-64 bg-white border-r border-gray-100 flex flex-col justify-between hidden md:flex shrink-0 h-full">
        <div>
            <!-- Sidebar Header / Logo -->
            <div class="p-6 flex items-center justify-between border-b border-gray-50">
                <div class="flex items-center gap-3">
                    <img src="{{ asset('storage/images/logo.png') }}" alt="Logo mySBUM"
                        class="w-10 h-10 object-contain">
                    <div>
                        <h1 class="font-bold text-lg text-[#006A4E] leading-none">mySBUM</h1>
                        <span class="text-[10px] text-gray-400 font-semibold tracking-wider">POLIBATAM</span>
                    </div>
                </div>
            </div>

            <!-- Menu Navigation (Disesuaikan berdasarkan Role) -->
            <div class="p-4">
                <p class="text-[10px] font-bold text-gray-400 tracking-wider mb-3 px-3 uppercase">MENU UTAMA</p>
                <nav class="space-y-1">
                    @php
                        $userRole = Auth::user()->role ?? 'pj';
                        $dashboardRoute = match ($userRole) {
                            'kepala' => route('kepala.dashboard'),
                            'admin' => route('admin.dashboard'),
                            'pic' => route('pic.dashboard'),
                            default => route('dashboard'),
                        };
                    @endphp

                    <a href="{{ $dashboardRoute }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:bg-gray-50 hover:text-gray-700 font-medium text-sm transition-all">
                        <i class="fa-solid fa-arrow-left w-5"></i>
                        Kembali ke Dashboard
                    </a>

                    <a href="{{ route('profile.edit') }}"
                        class="flex items-center gap-3 px-4 py-3 rounded-xl bg-[#006A4E] text-white font-medium text-sm transition-all shadow-sm">
                        <i class="fa-regular fa-user w-5"></i>
                        Akun Saya
                    </a>
                </nav>
            </div>
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
                <h2 class="font-bold text-gray-800 text-base hidden sm:block">Pengaturan Akun</h2>
            </div>

            <!-- Profile User Dropdown Header -->
            @include('components.profile-dropdown')
        </header>

        <!-- MAIN CONTENT AREA -->
        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Breadcrumb & Header Title -->
            <div>
                <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                    <a href="{{ $dashboardRoute }}" class="hover:text-gray-600">Dashboard</a>
                    <span>&gt;</span>
                    <span class="text-[#006A4E] font-semibold">Akun Saya</span>
                </nav>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Profil Pengguna</h1>
                <p class="text-xs text-gray-500 mt-1">
                    Kelola informasi pribadi, kontak, dan keamanan kata sandi Anda.
                </p>
            </div>

            <!-- Flash Messages -->
            @if(session('success'))
                <div
                    class="bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs p-4 rounded-xl flex items-center gap-2">
                    <i class="fa-solid fa-circle-check text-emerald-600"></i>
                    <span>{{ session('success') }}</span>
                </div>
            @endif

            @if(session('error'))
                <div class="bg-red-50 border border-red-200 text-red-700 text-xs p-4 rounded-xl flex items-center gap-2">
                    <i class="fa-solid fa-circle-xmark text-red-600"></i>
                    <span>{{ session('error') }}</span>
                </div>
            @endif

            <!-- Layout Grid Dua Kolom (Profil Banner + Form) -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

                <!-- Left Column: User Summary Card -->
                <div
                    class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)] flex flex-col items-center text-center space-y-4 self-start">
                    <div class="relative">
                        @if (Auth::user()->profile_picture)
                            <img src="{{ Storage::disk('public')->url(Auth::user()->profile_picture) }}"
                                alt="Foto profil {{ Auth::user()->name }}"
                                class="w-24 h-24 rounded-full object-cover shadow-md border-4 border-white">
                        @else
                            <div
                                class="w-24 h-24 rounded-full bg-[#006A4E] text-white flex items-center justify-center font-bold text-3xl shadow-md border-4 border-white">
                                <i class="fa-regular fa-user"></i>
                            </div>
                        @endif
                    </div>

                    <div>
                        <h3 class="font-bold text-gray-800 text-base">{{ Auth::user()->name }}</h3>
                        <p class="text-xs text-gray-400 mt-0.5">NIP/NIM: {{ Auth::user()->id_number }}</p>
                    </div>

                    @php
                        $roleLabels = [
                            'pj' => 'Penanggung Jawab',
                            'lecturer' => 'Dosen / Penanggung Jawab',
                            'pic' => 'PIC Laboratorium',
                            'admin' => 'Admin Pengelola SBUM',
                            'kepala' => 'Kepala SBUM',
                        ];
                    @endphp
                    <span
                        class="px-4 py-1.5 bg-emerald-50 text-[#006A4E] text-xs font-bold rounded-full border border-emerald-200 uppercase tracking-wider">
                        {{ $roleLabels[Auth::user()->role] ?? Auth::user()->role }}
                    </span>

                    <div class="w-full border-t border-gray-100 pt-4 space-y-2 text-left text-xs">
                        <div class="flex items-center justify-between text-gray-500">
                            <span class="flex items-center gap-2"><i
                                    class="fa-regular fa-envelope text-gray-400 w-4"></i> Email:</span>
                            <span class="font-medium text-gray-800">{{ Auth::user()->email }}</span>
                        </div>
                        <div class="flex items-center justify-between text-gray-500">
                            <span class="flex items-center gap-2"><i class="fa-solid fa-phone text-gray-400 w-4"></i>
                                Telepon:</span>
                            <span class="font-medium text-gray-800">{{ Auth::user()->phone_number ?? '-' }}</span>
                        </div>
                    </div>
                </div>

                <!-- Right Column: Edit Forms (Informasi Pribadi & Ubah Password) -->
                <div class="lg:col-span-2 space-y-6">

                    <!-- Form 1: Informasi Pribadi -->
                    <div class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)]">
                        <h2
                            class="font-bold text-gray-800 text-base border-b border-gray-100 pb-3 mb-5 flex items-center gap-2">
                            <i class="fa-solid fa-id-card text-[#006A4E]"></i> Informasi Pribadi
                        </h2>

                        <form action="{{ route('profile.update') }}" method="POST" enctype="multipart/form-data"
                            class="space-y-4">
                            @csrf
                            @method('PUT')

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <!-- Nama Lengkap -->
                                <div>
                                    <label for="name" class="block text-xs font-bold text-gray-700 mb-1.5">
                                        Nama Lengkap <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="name" name="name"
                                        value="{{ old('name', Auth::user()->name) }}" required
                                        class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                    @error('name')
                                        <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                                    @enderror
                                </div>

                                <!-- NIP / NIM (Readonly) -->
                                <div>
                                    <label class="block text-xs font-bold text-gray-700 mb-1.5">
                                        NIM / NIP / Nomor Induk
                                    </label>
                                    <input type="text" value="{{ Auth::user()->id_number }}" readonly disabled
                                        class="w-full px-4 py-2.5 bg-gray-100 border border-gray-200 rounded-xl text-xs text-gray-500 cursor-not-allowed">
                                    <p class="text-[10px] text-gray-400 mt-1">NIM/NIP tidak dapat diubah secara mandiri.
                                    </p>
                                </div>

                                <!-- Email Institusi -->
                                <div>
                                    <label for="email" class="block text-xs font-bold text-gray-700 mb-1.5">
                                        Email Institusi <span class="text-red-500">*</span>
                                    </label>
                                    <input type="email" id="email" name="email"
                                        value="{{ old('email', Auth::user()->email) }}" required
                                        class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                    @error('email')
                                        <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                                    @enderror
                                </div>

                                <!-- Nomor Telepon -->
                                <div>
                                    <label for="phone_number" class="block text-xs font-bold text-gray-700 mb-1.5">
                                        Nomor Telepon / WhatsApp <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="phone_number" name="phone_number"
                                        value="{{ old('phone_number', Auth::user()->phone_number) }}" required
                                        class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                    @error('phone_number')
                                        <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                                    @enderror
                                </div>
                            </div>

                            <div>
                                <label for="profile_picture" class="block text-xs font-bold text-gray-700 mb-1.5">
                                    Foto Profil
                                </label>
                                <input type="file" id="profile_picture" name="profile_picture"
                                    accept="image/jpeg,image/png,image/webp"
                                    class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                <p class="text-[10px] text-gray-400 mt-1">Format JPG, PNG, atau WEBP. Maksimal 2 MB.</p>
                                @error('profile_picture')
                                    <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                                @enderror
                            </div>

                            <div class="text-right pt-2">
                                <button type="submit"
                                    class="px-5 py-2.5 bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold rounded-xl transition-all shadow-sm">
                                    Simpan Perubahan Profil
                                </button>
                            </div>
                        </form>
                    </div>

                    <!-- Form 2: Keamanan / Ubah Kata Sandi -->
                    <div class="bg-white rounded-2xl border border-gray-100 p-6 shadow-[0_2px_12px_rgba(0,0,0,0.02)]">
                        <h2
                            class="font-bold text-gray-800 text-base border-b border-gray-100 pb-3 mb-5 flex items-center gap-2">
                            <i class="fa-solid fa-lock text-[#006A4E]"></i> Keamanan Kata Sandi
                        </h2>

                        <form action="{{ route('profile.password') }}" method="POST" class="space-y-4">
                            @csrf
                            @method('PUT')

                            <div class="space-y-4 max-w-md">
                                <!-- Password Saat Ini -->
                                <div>
                                    <label for="current_password" class="block text-xs font-bold text-gray-700 mb-1.5">
                                        Password Saat Ini <span class="text-red-500">*</span>
                                    </label>
                                    <input type="password" id="current_password" name="current_password" required
                                        placeholder="Masukkan password lama Anda..."
                                        class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                    @error('current_password')
                                        <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                                    @enderror
                                </div>

                                <!-- Password Baru -->
                                <div>
                                    <label for="password" class="block text-xs font-bold text-gray-700 mb-1.5">
                                        Password Baru <span class="text-red-500">*</span>
                                    </label>
                                    <input type="password" id="password" name="password" required
                                        placeholder="Minimal 8 karakter..."
                                        class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                    @error('password')
                                        <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                                    @enderror
                                </div>

                                <!-- Konfirmasi Password Baru -->
                                <div>
                                    <label for="password_confirmation"
                                        class="block text-xs font-bold text-gray-700 mb-1.5">
                                        Konfirmasi Password Baru <span class="text-red-500">*</span>
                                    </label>
                                    <input type="password" id="password_confirmation" name="password_confirmation"
                                        required placeholder="Ulangi password baru..."
                                        class="w-full px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                                </div>
                            </div>

                            <div class="text-right pt-2">
                                <button type="submit"
                                    class="px-5 py-2.5 bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold rounded-xl transition-all shadow-sm">
                                    Ubah Kata Sandi
                                </button>
                            </div>
                        </form>
                    </div>

                </div>

            </div>

        </main>
    </div>

</body>

</html>