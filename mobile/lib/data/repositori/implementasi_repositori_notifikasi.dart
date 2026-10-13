import '../sumber_data/sumber_data_notifikasi_lokal.dart';
import '../model/catatan_notifikasi.dart';

class NotificationRepositoryImpl {
  const NotificationRepositoryImpl({
    this.dataSource = const LocalNotificationDataSource(),
  });

  final LocalNotificationDataSource dataSource;

  List<NotificationRecord> getAll() => dataSource.getAll();
}
