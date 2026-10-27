// Penjelasan edukatif: Model data aplikasi; class di sini membawa nilai yang dipakai layar dan repository.

/// Keterangan kelas: HistoryDetail adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class HistoryDetail {
  const HistoryDetail({
    required this.displayId,
    required this.requestId,
    required this.title,
    required this.building,
    required this.session,
    required this.date,
    required this.capacity,
    required this.location,
    required this.facilities,
    required this.borrower,
    required this.borrowerRole,
    required this.purpose,
    required this.imageUrl,
  });

  final String displayId;
  final String requestId;
  final String title;
  final String building;
  final String session;
  final String date;
  final String capacity;
  final String location;
  final List<String> facilities;
  final String borrower;
  final String borrowerRole;
  final String purpose;
  final String imageUrl;
}
