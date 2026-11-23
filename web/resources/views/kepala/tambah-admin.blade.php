<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Administrator Baru - mySBUM</title>
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

            <!-- Link Kembali & Title -->
            <div>
                <a href="{{ route('admin.kepala') }}"
                    class="inline-flex items-center gap-2 text-xs font-semibold text-gray-500 hover:text-[#006A4E] transition-colors mb-2">
                    <i class="fa-solid fa-arrow-left"></i> Kembali ke Daftar Admin
                </a>
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Tambah Administrator Baru</h1>
                <p class="text-xs text-gray-500 mt-1">
                    Masukkan detail informasi pengguna dan tentukan hak akses pada sistem.
                </p>
            </div>

            <!-- Alert Flash Message / Errors -->
            @if(session('error'))
                <div class="bg-red-50 border border-red-200 text-red-700 text-xs p-4 rounded-xl">
                    {{ session('error') }}
                </div>
            @endif

            <!-- Form Card -->
            <div
                class="bg-white rounded-2xl border border-gray-100 p-6 md:p-8 shadow-[0_2px_12px_rgba(0,0,0,0.02)] max-w-5xl">

                <form action="{{ route('admin.store.kepala') }}" method="POST" class="space-y-6">
                    @csrf

                    <div>
                        <h2 class="font-bold text-gray-800 text-base">Informasi Dasar</h2>
                        <p class="text-xs text-gray-400 mt-0.5">Data personal administrator yang akan didaftarkan.</p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                        <!-- Nama Lengkap -->
                        <div>
                            <label for="name" class="block text-xs font-bold text-gray-700 mb-2">
                                Nama Lengkap <span class="text-red-500">*</span>
                            </label>
                            <input type="text" id="name" name="name" value="{{ old('name') }}" required
                                placeholder="Masukkan nama lengkap beserta gelar..."
                                class="w-full px-4 py-3 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                            @error('name')
                                <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                            @enderror
                        </div>

                        <!-- NIP / Nomor Induk Karyawan -->
                        <div>
                            <label for="id_number" class="block text-xs font-bold text-gray-700 mb-2">
                                NIP / Nomor Induk Karyawan <span class="text-red-500">*</span>
                            </label>
                            <input type="text" id="id_number" name="id_number" value="{{ old('id_number') }}" required
                                placeholder="Contoh: 1985032204..."
                                class="w-full px-4 py-3 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                            @error('id_number')
                                <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                            @enderror
                        </div>

                        <!-- Alamat Email Institusi -->
                        <div>
                            <label for="email" class="block text-xs font-bold text-gray-700 mb-2">
                                Alamat Email Institusi <span class="text-red-500">*</span>
                            </label>
                            <input type="email" id="email" name="email" value="{{ old('email') }}" required
                                placeholder="nama@polibatam.ac.id"
                                class="w-full px-4 py-3 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                            @error('email')
                                <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                            @enderror
                        </div>

                        <!-- Nomor Telepon / WhatsApp -->
                        <div>
                            <label for="phone_number" class="block text-xs font-bold text-gray-700 mb-2">
                                Nomor Telepon / WhatsApp <span class="text-red-500">*</span>
                            </label>
                            <div class="relative flex items-center">
                                <span
                                    class="absolute left-3.5 text-xs font-semibold text-gray-500 pr-2 border-r border-gray-300">+62</span>
                                <input type="text" id="phone_number" name="phone_number"
                                    value="{{ old('phone_number') }}" required placeholder="812-3456-7890"
                                    class="w-full pl-16 pr-4 py-3 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                            </div>
                            @error('phone_number')
                                <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                            @enderror
                        </div>

                        <!-- Password (Menggantikan Departemen) -->
                        <div>
                            <label for="password" class="block text-xs font-bold text-gray-700 mb-2">
                                Password Akun <span class="text-red-500">*</span>
                            </label>
                            <input type="password" id="password" name="password" required
                                placeholder="Masukkan password untuk akun admin..."
                                class="w-full px-4 py-3 bg-[#F8FAFC] border border-gray-200 rounded-xl text-xs text-gray-800 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-[#006A4E] focus:bg-white transition-all">
                            @error('password')
                                <p class="text-red-500 text-[11px] mt-1">{{ $message }}</p>
                            @enderror
                        </div>

                        <!-- Status Akun (Toggle Switch) -->
                        <div>
                            <label class="block text-xs font-bold text-gray-700 mb-2">
                                Status Akun
                            </label>
                            <label
                                class="flex items-center gap-3 px-4 py-2.5 bg-[#F8FAFC] border border-gray-200 rounded-xl cursor-pointer hover:bg-gray-50 transition-all">
                                <input type="checkbox" name="is_active" value="1" class="sr-only peer" checked>
                                <div
                                    class="w-11 h-6 bg-gray-300 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-[#006A4E] relative">
                                </div>
                                <span class="text-xs font-semibold text-gray-700">
                                    Aktif <span class="text-gray-400 font-normal">(Dapat mengakses sistem)</span>
                                </span>
                            </label>
                        </div>

                    </div>

                    <!-- Divider & Action Buttons -->
                    <div class="border-t border-gray-100 pt-6 flex items-center justify-end gap-3">
                        <a href="{{ route('admin.kepala') }}"
                            class="px-6 py-2.5 border border-gray-300 text-gray-600 hover:bg-gray-50 font-bold text-xs rounded-xl transition-all">
                            Batal
                        </a>
                        <button type="submit"
                            class="px-6 py-2.5 bg-[#006A4E] hover:bg-[#004D39] text-white font-bold text-xs rounded-xl transition-all flex items-center gap-2 shadow-sm">
                            <i class="fa-solid fa-check text-xs"></i> Simpan Admin
                        </button>
                    </div>

                </form>

            </div>

        </main>
    </div>

</body>

</html>