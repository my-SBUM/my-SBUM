<!-- Komponen Dropdown Profil & Pop-up Logout -->
<div class="relative group cursor-pointer py-2">
    <div class="flex items-center gap-3">
        <div class="text-right hidden sm:block">
            <h2 class="text-sm font-bold text-gray-800 leading-tight">
                {{ Auth::user()->name ?? 'Dr. Ir. Hendra W.' }}
            </h2>
            <p class="text-xs text-gray-400 capitalize">
                {{ Auth::user()->role == 'Penanggung Jawab' ? 'Penanggung Jawab' : (Auth::user()->role ?? 'Koordinator Lab') }}
            </p>
        </div>

        <!-- Avatar Profil -->
        @if(Auth::check() && Auth::user()->profile_picture)
            <img src="{{ asset('storage/' . Auth::user()->profile_picture) }}" alt="Foto Profil"
                class="w-10 h-10 rounded-full object-cover border-2 border-[#006A4E]/20">
        @else
            <div class="w-10 h-10 rounded-full bg-[#006A4E] text-white flex items-center justify-center font-bold text-sm">
                <i class="fa-regular fa-user"></i>
            </div>
        @endif

        <i class="fa-solid fa-chevron-down text-xs text-gray-400 group-hover:rotate-180 transition-transform"></i>
    </div>

    <!-- Dropdown Menu -->
    <div class="absolute right-0 top-full w-44 pt-2 hidden group-hover:block z-50">
        <div class="bg-white rounded-xl shadow-lg border border-gray-100 relative">
            <div class="absolute -top-1.5 right-4 w-3 h-3 bg-white border-t border-l border-gray-100 rotate-45"></div>
            <div class="py-2 relative z-10">
                <a href="{{ route('profile.edit') }}"
                    class="flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-gray-700 hover:bg-gray-50 hover:text-[#006A4E] transition-colors">
                    <i class="fa-regular fa-user text-gray-400 w-4"></i>
                    Akun Saya
                </a>
                <div class="border-t border-gray-100 my-1"></div>

                <form id="logout-form" action="{{ route('logout') }}" method="POST">
                    @csrf
                    <button type="button" onclick="confirmLogout()"
                        class="w-full flex items-center gap-2.5 px-4 py-2.5 text-xs font-semibold text-red-600 hover:bg-red-50 transition-colors text-left cursor-pointer">
                        <i class="fa-solid fa-right-from-bracket text-red-500 w-4"></i>
                        Log Out
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Script SweetAlert2 (Cukup dimuat sekali) -->
@once
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmLogout() {
            Swal.fire({
                title: 'Konfirmasi Log Out',
                text: "Apakah Anda yakin ingin keluar dari sistem?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#006A4E',
                cancelButtonColor: '#ef4444',
                confirmButtonText: 'Ya, Keluar',
                cancelButtonText: 'Batal',
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('logout-form').submit();
                }
            });
        }
    </script>
@endonce