// Penjelasan edukatif: Bagian aplikasi mobile yang mendukung alur peminjaman.

enum NotificationKind { success, reminder, rejected }

/// Keterangan kelas: NotificationRecord adalah model sederhana untuk membawa data antar lapisan aplikasi.
class NotificationRecord {
  const NotificationRecord({
    required this.actor,
    required this.action,
    required this.object,
    required this.message,
    required this.timestamp,
    required this.kind,
    required this.isNew,
  });

  final String actor;
  final String action;
  final String object;
  final String message;
  final String timestamp;
  final NotificationKind kind;
  final bool isNew;
}
