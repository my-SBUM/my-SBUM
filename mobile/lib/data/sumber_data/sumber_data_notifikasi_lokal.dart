// Penjelasan edukatif: Sumber data lokal simulasi; class di sini menyediakan data contoh dan perubahan data tanpa server.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../model/catatan_notifikasi.dart';

/// Keterangan kelas: LocalNotificationDataSource adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class LocalNotificationDataSource {
  const LocalNotificationDataSource();

  List<NotificationRecord> getAll() => const [
    NotificationRecord(
      actor: '4342511014',
      action: 'peminjaman_baru',
      object: 'Pengajuan Peminjaman Alat',
      message: 'Peminjaman Seminar PBL telah diajukan.',
      timestamp: '25 Okt 2026, 22:57',
      kind: NotificationKind.success,
      isNew: true,
    ),
    NotificationRecord(
      actor: '4342511014',
      action: 'peminjaman_disetujui',
      object: 'Peminjaman Ruangan',
      message: 'Pengajuan Ruang Lab Komputer A091 telah disetujui.',
      timestamp: '25 Okt 2026, 19:42',
      kind: NotificationKind.reminder,
      isNew: true,
    ),
    NotificationRecord(
      actor: '4342511014',
      action: 'peminjaman_ditolak',
      object: 'Peminjaman Kamera DSLR Canon',
      message: 'Pengajuan ditolak karena kuota peminjaman penuh.',
      timestamp: '24 Okt 2026, 14:10',
      kind: NotificationKind.rejected,
      isNew: false,
    ),
    NotificationRecord(
      actor: '4342511014',
      action: 'peminjaman_selesai',
      object: 'Ruang Rapat Utama',
      message:
          'Peminjaman telah selesai. Terima kasih telah mengembalikan kunci.',
      timestamp: '20 Okt 2026, 09:30',
      kind: NotificationKind.success,
      isNew: false,
    ),
  ];
}
