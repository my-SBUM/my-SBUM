// Penjelasan edukatif: Model data aplikasi; class di sini membawa nilai yang dipakai layar dan repository.

/// Keterangan kelas: Equipment adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class Equipment {
  final String name;
  final String code;
  final int stock;
  final String unit;
  final String location;
  final List<String> completeness;
  final String notice;
  final String imageUrl;
  final bool available;

  const Equipment({
    required this.name,
    required this.code,
    required this.stock,
    required this.unit,
    required this.location,
    required this.completeness,
    required this.notice,
    required this.imageUrl,
    required this.available,
  });
}
