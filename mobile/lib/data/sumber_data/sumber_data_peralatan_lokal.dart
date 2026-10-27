// Penjelasan edukatif: Sumber data lokal simulasi; class di sini menyediakan data contoh dan perubahan data tanpa server.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/peralatan.dart';
import '../../model/alat.dart';

/// Keterangan kelas: LocalPeralatanDataSource adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class LocalPeralatanDataSource {
  const LocalPeralatanDataSource();

  List<Peralatan> getAll() => const [
    Peralatan(
      nama: 'Kamera Luminux A7',
      stok: 4,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux A7 II',
      stok: 0,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux A7 III',
      stok: 4,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux A7 IV',
      stok: 4,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux A9',
      stok: 2,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux A9 II',
      stok: 0,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux FX3',
      stok: 3,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux FX6',
      stok: 1,
      lokasi: 'Gudang SBUM',
      gambar: _image,
    ),
  ];

  List<Peralatan> getAdditional() => const [
    Peralatan(
      nama: 'Kamera Luminux A7',
      lokasi: 'Gudang SBUM',
      stok: 2,
      kode: 'CMR 104',
      kategori: 'Kamera',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux A9',
      lokasi: 'Gudang SBUM',
      stok: 3,
      kode: 'CMR 105',
      kategori: 'Kamera',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Kamera Luminux FX3',
      lokasi: 'Gudang SBUM',
      stok: 0,
      kode: 'CMR 106',
      kategori: 'Kamera',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Lensa Luminux 24-70',
      lokasi: 'Gudang SBUM',
      stok: 0,
      kode: 'LNS 201',
      kategori: 'Lensa',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Lensa Luminux 50mm',
      lokasi: 'Gudang SBUM',
      stok: 2,
      kode: 'LNS 202',
      kategori: 'Lensa',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Mikrofon Shotgun',
      lokasi: 'Gudang SBUM',
      stok: 2,
      kode: 'AUD 301',
      kategori: 'Audio',
      gambar: _image,
      dalamPerawatan: true,
    ),
    Peralatan(
      nama: 'Lampu LED Panel',
      lokasi: 'Gudang SBUM',
      stok: 4,
      kode: 'LGT 401',
      kategori: 'Lighting',
      gambar: _image,
    ),
    Peralatan(
      nama: 'Tripod Profesional',
      lokasi: 'Gudang SBUM',
      stok: 5,
      kode: 'ACC 501',
      kategori: 'Aksesoris',
      gambar: _image,
    ),
  ];

  List<String> getCategories() => const [
    'Semua Kategori',
    'Kamera',
    'Lensa',
    'Audio',
    'Lighting',
    'Aksesoris',
  ];

  List<String> getSortOptions() => const ['Stok Terbanyak', 'Nama', 'Kategori'];

  Equipment getDefaultDetailItem() => const Equipment(
    name: 'Kamera Luminux',
    code: 'MMX - 208',
    stock: 2,
    unit: 'Kamera',
    location: 'Lab Multimedia, Lt. 2',
    completeness: [
      '1x Bodi Kamera Luminux MMX-208.',
      '1x Lensa Kit.',
      '2x Baterai + 1x Dual Charger & Kabel.',
    ],
    notice:
        'Kerusakan atau kehilangan aksesori menjadi tanggung jawab '
        'peminjam penuh',
    imageUrl: 'assets/images/foto_lokal_03_10b5f5d2c6.jpg',
    available: true,
  );

  static const String _image = 'assets/images/foto_lokal_03_10b5f5d2c6.jpg';
}
