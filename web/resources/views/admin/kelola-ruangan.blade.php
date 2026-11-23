<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kelola Ruangan - Admin SBUM</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

    @include('layouts.sidebar')

    <div class="flex-grow flex flex-col min-w-0 h-full overflow-hidden">

        <header class="h-20 bg-white border-b border-gray-100 flex items-center justify-between px-6 md:px-10 shrink-0">
            <div class="flex items-center gap-4">
                <button class="md:hidden text-gray-500 hover:text-gray-700">
                    <i class="fa-solid fa-bars text-xl"></i>
                </button>
            </div>
            @include('components.profile-dropdown')
        </header>

        <main class="p-6 md:p-10 space-y-6 flex-grow overflow-y-auto">

            <!-- Header Title & Tombol Tambah -->
            <div class="flex flex-col sm:flex-row sm:items-end justify-between gap-4">
                <div>
                    <nav class="flex text-xs text-gray-400 gap-1.5 mb-2">
                        <a href="{{ route('admin.dashboard') }}" class="hover:text-gray-600">Dashboard</a>
                        <span>&gt;</span>
                        <span class="text-[#006A4E] font-semibold">Ruangan</span>
                    </nav>
                    <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Kelola Ruangan</h1>
                    <p class="text-xs text-gray-500 mt-1">
                        Daftar, atur ketersediaan, kapasitas, dan status operasional seluruh ruangan kampus.
                    </p>
                </div>

                <button type="button" onclick="openModalTambah()"
                    class="inline-flex items-center justify-center gap-2 bg-[#006A4E] hover:bg-[#004D39] active:scale-[0.99] text-white text-xs font-bold px-5 py-3 rounded-xl shadow-sm transition-all cursor-pointer shrink-0">
                    <i class="fa-solid fa-plus"></i>
                    <span>Tambah Ruangan</span>
                </button>
            </div>

            <!-- Alert Sukses / Error -->
            @if(session('success'))
                <div
                    class="bg-emerald-50 border border-emerald-200 text-emerald-700 px-4 py-3 rounded-xl text-xs font-medium flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <i class="fa-solid fa-circle-check text-emerald-600"></i>
                        <span>{{ session('success') }}</span>
                    </div>
                    <button type="button" onclick="this.parentElement.remove()"
                        class="text-emerald-500 hover:text-emerald-700">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            @endif

            @if($errors->any())
                <div class="bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-xl text-xs">
                    <ul class="list-disc pl-4 space-y-1">
                        @foreach($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <!-- Overview Status Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">SIAP DIGUNAKAN</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">
                                {{ isset($ruangans) ? $ruangans->where('status_ruangan', 'tersedia')->count() : 0 }}
                            </span>
                            <span class="text-xs text-gray-400 font-medium">Unit</span>
                            <span
                                class="px-2.5 py-0.5 bg-emerald-100 text-emerald-700 text-[10px] font-bold rounded-full">Siap
                                Pakai</span>
                        </div>
                    </div>
                    <div
                        class="w-10 h-10 rounded-xl bg-emerald-100 text-emerald-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-check text-sm"></i>
                    </div>
                </div>

                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">TOTAL RUANGAN</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">
                                {{ isset($ruangans) ? $ruangans->count() : 0 }}
                            </span>
                            <span class="text-xs text-gray-400 font-medium">Unit</span>
                            <span
                                class="px-2.5 py-0.5 bg-indigo-100 text-indigo-700 text-[10px] font-bold rounded-full">Terdaftar</span>
                        </div>
                    </div>
                    <div
                        class="w-10 h-10 rounded-xl bg-indigo-100 text-indigo-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-building text-sm"></i>
                    </div>
                </div>

                <div
                    class="bg-white p-5 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)] flex items-center justify-between">
                    <div>
                        <span class="text-[10px] font-bold text-gray-400 tracking-wider uppercase">TIDAK TERSEDIA</span>
                        <div class="flex items-baseline gap-2 mt-2">
                            <span class="text-3xl font-bold text-gray-800">
                                {{ isset($ruangans) ? $ruangans->where('status_ruangan', '!=', 'tersedia')->count() : 0 }}
                            </span>
                            <span class="text-xs text-gray-400 font-medium">Unit</span>
                            <span
                                class="px-2.5 py-0.5 bg-rose-100 text-rose-700 text-[10px] font-bold rounded-full">Maintenance</span>
                        </div>
                    </div>
                    <div
                        class="w-10 h-10 rounded-xl bg-rose-100 text-rose-600 flex items-center justify-center shrink-0">
                        <i class="fa-solid fa-wrench text-sm"></i>
                    </div>
                </div>
            </div>

            <!-- Search Bar & Filter -->
            <div
                class="flex flex-col sm:flex-row items-center justify-between gap-3 bg-white p-2 rounded-2xl border border-gray-100 shadow-[0_2px_10px_rgba(0,0,0,0.02)]">
                <div class="relative w-full sm:flex-grow">
                    <span class="absolute inset-y-0 left-0 pl-3.5 flex items-center text-gray-400">
                        <i class="fa-solid fa-magnifying-glass text-xs"></i>
                    </span>
                    <input type="text" id="searchRuangan" onkeyup="filterCards()"
                        placeholder="Cari nama ruangan, gedung, kode, PIC, atau fasilitas..."
                        class="w-full pl-9 pr-4 py-2 bg-transparent text-xs text-gray-700 placeholder-gray-400 focus:outline-none">
                </div>

                <div class="relative w-full sm:w-48 shrink-0">
                    <select id="filterStatus" onchange="filterCards()"
                        class="w-full appearance-none bg-[#F8FAFC] border border-gray-100 text-gray-600 text-xs font-semibold py-2 pl-3 pr-8 rounded-xl focus:outline-none cursor-pointer">
                        <option value="all">Semua Status</option>
                        <option value="tersedia">Tersedia</option>
                        <option value="tidak_tersedia">Tidak Tersedia</option>
                    </select>
                    <i class="fa-solid fa-chevron-down absolute right-3 top-2.5 text-gray-400 text-[10px]"></i>
                </div>
            </div>

            <!-- KATALOG CARD RUANGAN OTOMATIS -->
            <div id="ruanganGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                @forelse($ruangans ?? [] as $ruangan)
                    <div data-status="{{ $ruangan->status_ruangan }}"
                        class="ruangan-card bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-[0_2px_12px_rgba(0,0,0,0.02)] hover:shadow-md transition-shadow flex flex-col justify-between">
                        <div>
                            <div class="relative h-44 w-full bg-gray-100">
                                @if(!empty($ruangan->path_foto))
                                    <img src="data:image/jpeg;base64,{{ base64_encode($ruangan->path_foto) }}"
                                        alt="{{ $ruangan->name_ruangan }}" class="w-full h-full object-cover">
                                @else
                                    <div
                                        class="w-full h-full flex flex-col items-center justify-center bg-emerald-50/60 text-[#006A4E]/40">
                                        <i class="fa-regular fa-building text-4xl mb-1"></i>
                                        <span class="text-[10px] font-medium">Tidak ada foto</span>
                                    </div>
                                @endif

                                @if($ruangan->status_ruangan === 'tersedia')
                                    <span
                                        class="absolute top-3 right-3 px-2.5 py-1 bg-emerald-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                        <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tersedia
                                    </span>
                                @else
                                    <span
                                        class="absolute top-3 right-3 px-2.5 py-1 bg-rose-500 text-white text-[10px] font-bold rounded-full shadow-sm flex items-center gap-1">
                                        <span class="w-1.5 h-1.5 rounded-full bg-white"></span> Tidak Tersedia
                                    </span>
                                @endif

                                <span
                                    class="absolute bottom-3 left-3 bg-black/60 backdrop-blur-sm text-white text-[10px] font-medium px-2.5 py-1 rounded-lg flex items-center gap-1.5">
                                    <i class="fa-solid fa-building text-[9px]"></i> {{ $ruangan->lokasi_teks }}
                                </span>

                                <span
                                    class="absolute bottom-3 right-3 bg-white/90 text-gray-800 text-[10px] font-bold px-2 py-0.5 rounded shadow-sm">
                                    {{ $ruangan->kode_ruangan }}
                                </span>
                            </div>

                            <div class="p-5 space-y-3">
                                <div>
                                    <h3 class="font-bold text-gray-800 text-sm">{{ $ruangan->name_ruangan }}</h3>
                                    <p class="text-[11px] text-gray-400 mt-0.5 line-clamp-2">
                                        {{ !empty($ruangan->deskripsi_teks) ? $ruangan->deskripsi_teks : 'Tidak ada deskripsi ruangan.' }}
                                    </p>
                                </div>

                                <div class="space-y-1 text-[11px] text-gray-500">
                                    <p class="flex items-center gap-2">
                                        <i class="fa-regular fa-user text-gray-400 w-3.5"></i>
                                        PIC: <strong class="text-gray-700">{{ $ruangan->pic_name }}</strong>
                                    </p>
                                    <p class="flex items-center gap-2">
                                        <i class="fa-solid fa-users text-gray-400 w-3.5"></i>
                                        Kapasitas: <strong class="text-gray-700">{{ $ruangan->kapasitas }} orang</strong>
                                    </p>
                                </div>

                                @php
                                    $daftarFasilitas = is_array($ruangan->fasilitas) ? $ruangan->fasilitas : [];
                                @endphp
                                @if(count($daftarFasilitas) > 0)
                                    <div class="flex flex-wrap gap-1.5 pt-1">
                                        @foreach($daftarFasilitas as $item)
                                            <span
                                                class="px-2 py-0.5 bg-emerald-50 text-emerald-700 text-[10px] font-semibold rounded">
                                                {{ $item }}
                                            </span>
                                        @endforeach
                                    </div>
                                @endif
                            </div>
                        </div>

                        <!-- Tombol Aksi Edit & Hapus -->
                        <div class="p-5 pt-0 flex items-center gap-2">
                            <button type="button"
                                class="flex-grow bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold py-2.5 rounded-xl transition-all shadow-sm cursor-pointer">
                                Edit Ruangan
                            </button>

                            <form action="{{ route('kelola.ruangan.destroy', $ruangan->id_ruangan) }}" method="POST"
                                onsubmit="return confirm('Apakah Anda yakin ingin menghapus ruangan {{ $ruangan->name_ruangan }} ({{ $ruangan->kode_ruangan }})?');"
                                class="shrink-0">
                                @csrf
                                @method('DELETE')
                                <button type="submit" title="Hapus Ruangan"
                                    class="px-3.5 py-2.5 bg-rose-50 hover:bg-rose-600 text-rose-600 hover:text-white border border-rose-200 hover:border-rose-600 text-xs font-bold rounded-xl transition-all cursor-pointer flex items-center justify-center gap-1.5">
                                    <i class="fa-regular fa-trash-can"></i>
                                    <span>Hapus</span>
                                </button>
                            </form>
                        </div>
                    </div>
                @empty
                    <div class="col-span-full bg-white rounded-2xl border border-dashed border-gray-200 p-12 text-center">
                        <div
                            class="w-14 h-14 rounded-2xl bg-[#006A4E]/10 text-[#006A4E] flex items-center justify-center mx-auto mb-3">
                            <i class="fa-regular fa-building text-2xl"></i>
                        </div>
                        <h3 class="text-sm font-bold text-gray-800">Belum Ada Data Ruangan</h3>
                        <p class="text-xs text-gray-400 max-w-sm mx-auto mt-1 mb-5">
                            Data ruangan masih kosong. Klik tombol "Tambah Ruangan" untuk menambahkan ruangan pertama ke
                            dalam sistem.
                        </p>
                    </div>
                @endforelse
            </div>

        </main>
    </div>

    <!-- MODAL FORM TAMBAH RUANGAN -->
    <div id="modalTambahRuangan"
        class="fixed inset-0 z-50 hidden items-center justify-center bg-gray-900/50 backdrop-blur-xs p-4">
        <div class="bg-white rounded-2xl max-w-3xl w-full shadow-2xl border border-gray-100 overflow-hidden">

            <div class="px-6 py-3.5 bg-gray-50/80 border-b border-gray-100 flex items-center justify-between">
                <div class="flex items-center gap-2.5">
                    <div class="w-8 h-8 rounded-lg bg-[#006A4E]/10 text-[#006A4E] flex items-center justify-center">
                        <i class="fa-solid fa-building text-sm"></i>
                    </div>
                    <div>
                        <h3 class="text-sm font-bold text-gray-800">Tambah Data Ruangan</h3>
                        <p class="text-[11px] text-gray-400">Lengkapi detail fasilitas ruangan kampus</p>
                    </div>
                </div>
                <button type="button" onclick="closeModalTambah()"
                    class="text-gray-400 hover:text-gray-600 p-1 cursor-pointer">
                    <i class="fa-solid fa-xmark text-base"></i>
                </button>
            </div>

            <form action="{{ route('kelola.ruangan.store') }}" method="POST" enctype="multipart/form-data"
                class="p-5 space-y-3.5">
                @csrf

                <!-- Baris 1: Kode + Nama Ruangan + Gedung & Lantai -->
                <div class="grid grid-cols-1 sm:grid-cols-6 gap-3">
                    <div>
                        <label for="kode_ruangan" class="block text-xs font-bold text-gray-700 mb-1">Kode <span
                                class="text-red-500">*</span></label>
                        <input type="text" name="kode_ruangan" id="kode_ruangan" value="{{ old('kode_ruangan') }}"
                            required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="A-104">
                    </div>
                    <div class="sm:col-span-2">
                        <label for="name_ruangan" class="block text-xs font-bold text-gray-700 mb-1">Nama Ruangan <span
                                class="text-red-500">*</span></label>
                        <input type="text" name="name_ruangan" id="name_ruangan" value="{{ old('name_ruangan') }}"
                            required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="Cth: Auditorium Graha Widya">
                    </div>
                    <div class="sm:col-span-2">
                        <label for="nama_gedung" class="block text-xs font-bold text-gray-700 mb-1">Gedung <span
                                class="text-red-500">*</span></label>
                        <input type="text" name="nama_gedung" id="nama_gedung" value="{{ old('nama_gedung') }}" required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="Cth: Gedung Utama">
                    </div>
                    <div>
                        <label for="nomor_lantai" class="block text-xs font-bold text-gray-700 mb-1">Lantai <span
                                class="text-red-500">*</span></label>
                        <input type="number" name="nomor_lantai" id="nomor_lantai" min="1"
                            value="{{ old('nomor_lantai') }}" required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="2">
                    </div>
                </div>

                <!-- Baris 2: Nama PIC + Kapasitas + Status -->
                <div class="grid grid-cols-1 sm:grid-cols-4 gap-3">
                    <div class="sm:col-span-2">
                        <label for="id_number" class="block text-xs font-bold text-gray-700 mb-1">Nama PIC <span
                                class="text-red-500">*</span></label>
                        <select name="id_number" id="id_number" required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]">
                            <option value="" disabled {{ old('id_number') ? '' : 'selected' }}>-- Pilih Nama PIC --
                            </option>
                            @forelse($pics ?? [] as $pic)
                                <option value="{{ $pic->id_number }}" {{ old('id_number') == $pic->id_number ? 'selected' : '' }}>
                                    {{ $pic->nama_pic }} ({{ $pic->id_number }})
                                </option>
                            @empty
                                <option value="" disabled>Belum ada user dengan posisi PIC</option>
                            @endforelse
                        </select>
                    </div>
                    <div>
                        <label for="kapasitas" class="block text-xs font-bold text-gray-700 mb-1">Kapasitas (Org) <span
                                class="text-red-500">*</span></label>
                        <input type="number" name="kapasitas" id="kapasitas" min="1" value="{{ old('kapasitas') }}"
                            required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="40">
                    </div>
                    <div>
                        <label for="status_ruangan" class="block text-xs font-bold text-gray-700 mb-1">Status <span
                                class="text-red-500">*</span></label>
                        <select name="status_ruangan" id="status_ruangan" required
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]">
                            <option value="" disabled {{ old('status_ruangan') ? '' : 'selected' }}>-- Pilih Status --</option>
                            <option value="tersedia" {{ old('status_ruangan') == 'tersedia' ? 'selected' : '' }}>Tersedia
                                (Siap Pakai)</option>
                            <option value="tidak_tersedia" {{ old('status_ruangan') == 'tidak_tersedia' ? 'selected' : '' }}>Tidak Tersedia</option>
                        </select>
                    </div>
                </div>

                <!-- Baris 3: Fasilitas Tersedia -->
                <div>
                    <label class="block text-xs font-bold text-gray-700 mb-1.5">Fasilitas Tersedia</label>
                    <div class="flex flex-wrap items-center gap-2">
                        @foreach(['AC', 'Proyektor', 'Papan Tulis', 'Meja Kursi', 'Sound System', 'Wi-Fi'] as $fasilitas)
                            <label
                                class="inline-flex items-center gap-1.5 px-2.5 py-1.5 bg-gray-50 border border-gray-200 rounded-lg text-xs text-gray-700 cursor-pointer hover:bg-emerald-50">
                                <input type="checkbox" name="fasilitas[]" value="{{ $fasilitas }}"
                                    class="rounded text-[#006A4E]">
                                <span>{{ $fasilitas }}</span>
                            </label>
                        @endforeach

                        <label
                            class="inline-flex items-center gap-1.5 px-2.5 py-1.5 bg-emerald-50/70 border border-emerald-200 rounded-lg text-xs font-semibold text-[#006A4E] cursor-pointer">
                            <input type="checkbox" id="checkFasilitasLainnya" onchange="toggleFasilitasLainnya()"
                                class="rounded text-[#006A4E]">
                            <span>+ Lainnya</span>
                        </label>
                    </div>

                    <div id="boxFasilitasLainnya" class="hidden mt-2">
                        <input type="text" name="fasilitas_lainnya" id="inputFasilitasLainnya"
                            class="w-full px-3.5 py-2 bg-emerald-50/30 border border-[#006A4E]/40 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="Ketik fasilitas tambahan (pisahkan dengan koma, cth: Smart TV, Mic Wireless)">
                    </div>
                </div>

                <!-- Baris 4: Deskripsi & Foto Ruangan -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                    <div>
                        <label for="deskripsi_ruangan" class="block text-xs font-bold text-gray-700 mb-1">Deskripsi
                            Ruangan</label>
                        <textarea name="deskripsi_ruangan" id="deskripsi_ruangan" rows="2"
                            class="w-full px-3 py-2 bg-white border border-gray-200 rounded-xl text-xs text-gray-800 focus:outline-none focus:border-[#006A4E]"
                            placeholder="Deskripsi singkat fungsi atau spesifikasi ruangan...">{{ old('deskripsi_ruangan') }}</textarea>
                    </div>

                    <div>
                        <label for="foto_ruangan" class="block text-xs font-bold text-gray-700 mb-1">Foto
                            Ruangan</label>
                        <div class="flex items-center gap-2.5">
                            <img id="preview-foto" src="" alt="Preview"
                                class="hidden w-14 h-12 rounded-lg object-cover border border-gray-200 shrink-0">
                            <div class="w-full">
                                <input type="file" name="foto_ruangan" id="foto_ruangan"
                                    accept="image/png, image/jpeg, image/jpg" onchange="previewRuangan(event)"
                                    class="w-full text-xs text-gray-500 file:mr-3 file:py-2 file:px-3.5 file:rounded-lg file:border-0 file:text-xs file:font-semibold file:bg-[#006A4E]/10 file:text-[#006A4E] cursor-pointer border border-gray-200 rounded-xl">
                                <p class="text-[10px] text-gray-400 mt-1">Format JPG/PNG, maks. 5MB</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tombol Aksi -->
                <div class="pt-3 border-t border-gray-100 flex items-center justify-end gap-2.5">
                    <button type="button" onclick="closeModalTambah()"
                        class="px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-xs font-bold rounded-xl cursor-pointer">
                        Batal
                    </button>
                    <button type="submit"
                        class="px-5 py-2 bg-[#006A4E] hover:bg-[#004D39] text-white text-xs font-bold rounded-xl shadow-sm cursor-pointer">
                        Simpan Ruangan
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openModalTambah() {
            const modal = document.getElementById('modalTambahRuangan');
            modal.classList.remove('hidden');
            modal.classList.add('flex');
        }

        function closeModalTambah() {
            const modal = document.getElementById('modalTambahRuangan');
            modal.classList.add('hidden');
            modal.classList.remove('flex');
        }

        function toggleFasilitasLainnya() {
            const checkbox = document.getElementById('checkFasilitasLainnya');
            const box = document.getElementById('boxFasilitasLainnya');
            const input = document.getElementById('inputFasilitasLainnya');
            if (checkbox.checked) {
                box.classList.remove('hidden');
                input.focus();
            } else {
                box.classList.add('hidden');
                input.value = '';
            }
        }

        function previewRuangan(event) {
            const img = document.getElementById('preview-foto');
            if (event.target.files && event.target.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    img.src = e.target.result;
                    img.classList.remove('hidden');
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        }

        function filterCards() {
            const search = document.getElementById('searchRuangan').value.toLowerCase();
            const status = document.getElementById('filterStatus').value;
            const cards = document.querySelectorAll('.ruangan-card');
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                const cardStatus = card.getAttribute('data-status');
                card.style.display = (text.includes(search) && (status === 'all' || cardStatus === status)) ? '' : 'none';
            });
        }

        @if($errors->any())
            openModalTambah();
        @endif
    </script>

</body>

</html>