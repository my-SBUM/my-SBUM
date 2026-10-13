# my_sbum

Aplikasi Flutter untuk peminjaman ruangan dan peralatan SBUM.

## Struktur sumber

- `lib/inti/`: konfigurasi aplikasi dan routing bersama.
- `lib/komponen/`: widget yang digunakan lintas fitur.
- `lib/fitur/<fitur>/*.dart`: halaman dan UI fitur, langsung di folder fitur
  tanpa folder `presentation` atau `screens`.
- `lib/fitur/<fitur>/domain/`: entity dan kontrak repository.
- `lib/data/sumber_data/`: katalog ruangan/peralatan, riwayat, notifikasi,
  daftar pilihan formulir, dan data lokal untuk layar detail.
- `lib/data/repositori/`: implementasi repository yang membaca datasource lokal.
- `lib/data/layanan/`: layanan mock untuk aksi autentikasi dan pengajuan.
- `lib/data/model/`: model data transport yang tidak bergantung pada widget UI.

Fixture katalog, riwayat, notifikasi, profil, lookup formulir, dan data fallback
detail berada di `lib/data`, bukan di halaman yang menampilkannya. Nilai yang
merupakan copy UI atau placeholder formulir tetap berada pada widget. Repository
saat ini memakai datasource lokal; saat backend tersedia, tambahkan
datasource/repository yang memetakan baris SQL ke entity fitur. Entity dan
kontrak repository tetap berada di `lib/fitur/<fitur>/domain/`.

## Menjalankan aplikasi

```sh
flutter pub get
flutter run
```

## Validasi

```sh
flutter analyze
flutter test
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
