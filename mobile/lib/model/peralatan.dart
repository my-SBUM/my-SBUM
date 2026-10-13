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
