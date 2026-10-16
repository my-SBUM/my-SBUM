# mySBUM Web (folder `web`) - Frontend UI Laravel Blade + Tailwind

Frontend mySBUM (Sistem Peminjaman Alat & Fasilitas Politeknik Negeri Batam):
**Laravel Blade** (frontend-only, dummy data) + **Tailwind CSS v4** via Vite.

## Menjalankan

```bash
cd web
npm install
npm run dev        # Vite dev (CSS/JS)
php artisan serve  # http://127.0.0.1:8000
```

Build produksi: `npm run build`.

## Route & Halaman (routes/web.php)

| Route | View | Keterangan |
|---|---|---|
| `/` | `landing` | Landing: hero, fitur, cara kerja, statistik, CTA NIM, footer |
| `/login` | `auth.login` | Login: toggle password, Ingat saya, Lupa sandi, Portal Resmi |
| `/register` | `auth.register` | Register lengkap |
| `/pengajuan/ruangan` | `pengajuan.ruangan` | Wizard 3 langkah ruangan (stepper, modal sukses) |
| `/pengajuan/peralatan` | `pengajuan.peralatan` | Wizard 3 langkah peralatan |
| `/dashboard/pj` | `dashboard.pj` | Dashboard Penanggung Jawab: stat, antrean approval, riwayat |
| `/dashboard/pic` | `dashboard.pic` | Dashboard PIC: tab Kelola Ruangan/Peralatan, antrean |
| `/dashboard/admin` | `dashboard.admin` | Admin Pengelola: stat, bar chart SVG, antrean, kalender |
| `/dashboard/kepala` | `dashboard.kepala` | Kepala SBUM: overview, kalender, Kelola Admin (modal tambah/edit) |

## Struktur Komponen

- `components/layouts/public` - landing (header + footer)
- `components/layouts/auth` - login/register (kartu tengah)
- `components/layouts/app` - dashboard (sidebar + topbar + konten)
- `<x-sidebar>`, `<x-navbar>`, `<x-stat-card>`, `<x-badge>`, `<x-button>`, `<x-stepper>`

Interaksi ringan (wizard stepper, tab, modal) di `resources/js/app.js` (vanilla JS).

## Tema

Emerald/forest green (emerald-700/800), kartu putih `rounded-2xl border-gray-100 shadow-sm`,
canvas `bg-slate-50`. Ikon SVG inline stroke 2px (tanpa dependensi berat).

Semua data adalah dummy di dalam Blade (`@foreach` atas array statis). Ketika backend siap,
ganti `Route::view(...)` dengan controller yang melempar data Eloquent ke view yang sama.

## Akun demo (login asli, tersimpan di database SQLite)

Password semua akun: `demo123`. Bisa login pakai NIP atau email.

| Aktor | NIP | Email | Dashboard |
|---|---|---|---|
| Penanggung Jawab (Dosen) | 19850512 | hendra@polibatam.ac.id | /dashboard/pj |
| PIC Fasilitas | 19900515 | siti@polibatam.ac.id | /dashboard/pic |
| Admin Pengelola SBUM | 19880323 | admin@polibatam.ac.id | /dashboard/admin |
| Kepala SBUM | 19920218 | kepala@polibatam.ac.id | /dashboard/kepala |

Setelah login, pengguna otomatis diarahkan ke dashboard sesuai kolom `role` di tabel `users`.
Halaman `/login` juga menyediakan tombol "Akun demo" untuk mengisi kredensial sekali klik.
