import '../model/catatan_notifikasi.dart';

class LocalNotificationDataSource {
  const LocalNotificationDataSource();

  List<NotificationRecord> getAll() => const [
    NotificationRecord(
      title: 'Peminjaman Ruangan Diterima',
      message: 'Pengajuan peminjaman Ruang Lab Komputer A091 anda telah disetujui oleh PIC.\n2 jam yang lalu',
      kind: NotificationKind.success,
      isNew: true,
    ),
    NotificationRecord(
      title: 'Pengingat Pengembalian',
      message: 'Batas akhir peminjaman Proyektor Epson tinggal 2 jam lagi. Mohon segera dikembalikan.\n3 jam yang lalu',
      kind: NotificationKind.reminder,
      isNew: true,
    ),
    NotificationRecord(
      title: 'Peminjaman Peralatan Ditolak',
      message: 'Maaf, pengajuan peminjaman Kamera DSLR Canon ditolak karena kuota penuh.\nKemarin',
      kind: NotificationKind.rejected,
      isNew: false,
    ),
    NotificationRecord(
      title: 'Peminjaman Ruang Rapat Selesai',
      message: 'Terima kasih telah mengembalikan kunci Ruang Rapat Utama tepat waktu.\n20 Mar 2027',
      kind: NotificationKind.success,
      isNew: false,
    ),
  ];
}
