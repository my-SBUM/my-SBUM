# my SBUM — Sistem Peminjaman Fasilitas

my SBUM adalah aplikasi untuk proses peminjaman ruangan dan peralatan Sub
Bagian Umum (SBUM). Repository ini disiapkan untuk aplikasi mobile Flutter dan
pengembangan backend/web.

## Status aplikasi saat ini

- **Login mobile:** Flutter mengirim NIM/NIP atau email dan kata sandi ke API Laravel di `web/`.
  Gunakan akun aktif dari database development. Token berlaku satu hari dan disimpan
  di penyimpanan aman perangkat. Logout mencabut token sesi tersebut.
- **Fitur mobile lainnya:** pendaftaran, perubahan kata sandi, dan pengajuan masih
  menggunakan simulasi. Profil dan katalog masih menggunakan data contoh.

---

## Teknologi

| Bagian | Teknologi |
| --- | --- |
| Mobile | Flutter dan Dart |
| Prototipe web | Laravel 13 |
| Backend/API | Laravel dan Sanctum |
| Database | MySQL |
| Komunikasi | HTTP API / JSON |

## Struktur repository

```text
my-SBUM/
├── backend/       # Placeholder untuk backend/API
├── mobile/        # Aplikasi Flutter
├── web/           # Prototipe web Laravel
├── .gitignore
└── README.md
```

Beberapa bagian utama aplikasi mobile:

- `mobile/lib/fitur/` — halaman dan antarmuka fitur aplikasi.
- `mobile/lib/data/` — data contoh, sumber data lokal, repository, dan layanan
  simulasi.
- `mobile/lib/model/` — model data aplikasi.
- `mobile/lib/komponen/` — widget yang digunakan bersama.
- `mobile/lib/inti/` — konfigurasi dan pengaturan rute aplikasi.

### Menjalankan prototipe web Laravel

Pasang PHP dan Composer, lalu jalankan dari PowerShell:

```powershell
Set-Location .\web
composer install
php artisan serve
```

Untuk login mobile, nyalakan MySQL Laragon dan arahkan `web/.env` ke database
hasil impor SQL revisi 2. Dump tersebut sudah menyediakan `users` dan
`personal_access_tokens`. Saat server Artisan berjalan pada port 8000, build
debug di emulator Android menggunakan `http://10.0.2.2:8000/api` secara otomatis.
Untuk HP Android melalui USB debugging, jalankan `adb reverse tcp:8000 tcp:8000`,
lalu dari folder mobile jalankan
`flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000/api`.
Untuk build rilis, isi `API_BASE_URL` dengan URL HTTPS.

---

## Cara menjalankan aplikasi mobile di Windows

### 1. Pasang kebutuhan

Sebelum mulai, pasang:

1. **Git** untuk mengambil kode dari GitHub.
2. **Flutter SDK** dan Dart. Versi Dart harus memenuhi ketentuan di
   `mobile/pubspec.yaml` (Dart `>=3.13.3 <4.0.0`).
3. **Android Studio**, termasuk Android SDK dan Android Emulator, jika ingin
   menjalankan aplikasi di emulator Android.

Setelah pemasangan, pastikan perintah `git`, `flutter`, dan `dart` dapat
dipanggil dari PowerShell. Periksa instalasi Flutter:

```powershell
flutter --version
flutter doctor
```

Ikuti petunjuk `flutter doctor` jika ada komponen Android yang belum siap.
Untuk menerima lisensi Android SDK, jalankan:

```powershell
flutter doctor --android-licenses
```

### 2. Ambil repository

Jalankan perintah berikut di PowerShell untuk mengunduh repository:

```powershell
git clone https://github.com/my-SBUM/my-SBUM.git
Set-Location .\my-SBUM
```

Jika alamat repository berubah atau Anda tidak memiliki akses, buka halaman
GitHub repository dan gunakan URL clone HTTPS dari tombol **Code**.

### 3. Siapkan dependensi Flutter

Jalankan dari folder utama repository:

```powershell
Set-Location .\mobile
flutter pub get
```

Perintah ini mengunduh paket yang dibutuhkan aplikasi. Ulangi `flutter pub get`
jika file `pubspec.yaml` berubah atau Flutter meminta dependensi diperbarui.

### 4. Jalankan di emulator Android

1. Buka Android Studio, lalu buat atau jalankan perangkat virtual melalui
   **Device Manager**. Alternatifnya, sambungkan ponsel Android dengan USB dan
   aktifkan **Developer options** serta **USB debugging**.
2. Pastikan perangkat terdeteksi:

   ```powershell
   flutter devices
   ```

3. Jalankan aplikasi dari folder `mobile`:

   ```powershell
   flutter run
   ```

   Jika ada lebih dari satu perangkat, pilih salah satunya dengan ID yang
   terlihat pada `flutter devices`:

   ```powershell
   flutter run -d <device-id>
   ```

Saat aplikasi sudah berjalan di terminal, tekan `r` untuk hot reload atau `R`
untuk hot restart. Tekan `q` untuk menghentikan aplikasi.

### Menjalankan di platform lain

- **Chrome:** pasang Google Chrome, kemudian jalankan
  `flutter run -d chrome` dari folder `mobile`.
- **Windows desktop:** membutuhkan Visual Studio dengan workload
  **Desktop development with C++**; jalankan `flutter run -d windows`.
- **iOS:** membutuhkan macOS dan Xcode; iOS tidak dapat dibangun langsung dari
  Windows.

---

## Pemeriksaan kode dan tes

Jalankan dari folder `mobile`:

```powershell
flutter analyze
flutter test
```

Build APK debug untuk dipasang atau dibagikan sebagai hasil pengembangan:

```powershell
flutter build apk --debug
```

File APK akan dibuat di:

```text
mobile/build/app/outputs/flutter-apk/app-debug.apk
```

---

## Pemecahan masalah

### `flutter` atau `dart` tidak dikenali

Pastikan folder `bin` Flutter SDK sudah ditambahkan ke `PATH`, lalu tutup dan
buka kembali PowerShell. Periksa dengan `flutter --version` dan `dart --version`.

### Perangkat tidak muncul di `flutter devices`

- Untuk emulator, pastikan perangkat virtual sudah dinyalakan di Android
  Studio.
- Untuk ponsel, pastikan USB debugging aktif dan izinkan komputer saat dialog
  otorisasi muncul di ponsel.
- Jalankan `flutter doctor` dan selesaikan masalah pada bagian Android toolchain.

### Gradle atau Android SDK gagal saat build

Pastikan koneksi internet tersedia untuk unduhan pertama, Android SDK terpasang,
dan lisensinya telah diterima menggunakan
`flutter doctor --android-licenses`. Setelah itu coba lagi dengan
`flutter run`.

### Ingin menghapus hasil build dan mencoba ulang

Dari folder `mobile`, jalankan:

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Panduan kontribusi

- Tarik perubahan terbaru dari `main` sebelum mulai mengerjakan fitur.
- Buat satu branch untuk satu pekerjaan, misalnya `feature/panduan-peminjaman`,
  `fix/navigasi-riwayat`, atau `docs/panduan-menjalankan`.
- Jangan melakukan pengembangan langsung di `main`.
- Jangan commit file `.env`, token, password, atau kredensial lainnya.
- Jalankan analisis dan tes yang relevan sebelum membuat Pull Request.
- Ajukan Pull Request agar perubahan dapat ditinjau sebelum digabung ke `main`.

---

<sub>PBL-TRPL-303 • my SBUM • Flutter</sub>
