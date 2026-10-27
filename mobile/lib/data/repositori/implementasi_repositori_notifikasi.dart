// Penjelasan edukatif: Implementasi repository yang menjadi perantara layar dengan sumber data lokal; operasi baca/tulis dipusatkan di sini.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../sumber_data/sumber_data_notifikasi_lokal.dart';
import '../model/catatan_notifikasi.dart';

/// Keterangan kelas: NotificationRepositoryImpl adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class NotificationRepositoryImpl {
  const NotificationRepositoryImpl({
    this.dataSource = const LocalNotificationDataSource(),
  });

  final LocalNotificationDataSource dataSource;

  List<NotificationRecord> getAll() => dataSource.getAll();
}
