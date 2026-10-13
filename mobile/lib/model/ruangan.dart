class Ruangan {
  final String nama;
  final String lokasi;
  final int kapasitas;
  final bool tersedia;
  final String? gambar;
  final String? lantai;
  final List<String> fasilitas;
  final bool dalamPerawatan;
  final String? ringkasanFasilitas;

  const Ruangan({
    required this.nama,
    required this.lokasi,
    required this.kapasitas,
    required this.tersedia,
    this.gambar,
    this.lantai,
    this.fasilitas = const [],
    this.dalamPerawatan = false,
    this.ringkasanFasilitas,
  });

  String get statusLabel => dalamPerawatan
      ? 'PERAWATAN'
      : tersedia
      ? 'TERSEDIA'
      : 'TIDAK TERSEDIA';
}
