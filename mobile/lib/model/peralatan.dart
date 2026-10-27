// Penjelasan edukatif: Model data aplikasi; class di sini membawa nilai yang dipakai layar dan repository.

/// Keterangan kelas: Peralatan adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class Peralatan {
  final String nama;
  final int stok;
  final String lokasi;
  final String? gambar;
  final String kode;
  final String kategori;
  final bool dalamPerawatan;

  const Peralatan({
    required this.nama,
    required this.stok,
    required this.lokasi,
    this.gambar,
    this.kode = '',
    this.kategori = 'Lainnya',
    this.dalamPerawatan = false,
  });

  bool get tersedia => stok > 0;

  String get statusLabel => dalamPerawatan
      ? 'PERAWATAN'
      : tersedia
      ? 'TERSEDIA'
      : 'TIDAK TERSEDIA';
}
