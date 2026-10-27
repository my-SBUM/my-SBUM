// Penjelasan edukatif: Model data aplikasi; class di sini membawa nilai yang dipakai layar dan repository.

/// Keterangan kelas: RequestRecord adalah model sederhana untuk membawa data antar lapisan aplikasi.
class RequestRecord {
  const RequestRecord({
    required this.id,
    required this.title,
    required this.date,
    required this.pic,
    required this.status,
    required this.isRoom,
    this.reason,
  });

  final String id;
  final String title;
  final String date;
  final String pic;
  final String status;
  final bool isRoom;
  final String? reason;

  RequestRecord copyWith({
    String? id,
    String? title,
    String? date,
    String? pic,
    String? status,
    bool? isRoom,
    String? reason,
  }) {
    return RequestRecord(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      pic: pic ?? this.pic,
      status: status ?? this.status,
      isRoom: isRoom ?? this.isRoom,
      reason: reason ?? this.reason,
    );
  }
}
