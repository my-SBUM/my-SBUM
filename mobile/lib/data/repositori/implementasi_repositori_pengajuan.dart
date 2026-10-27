// Penjelasan edukatif: Implementasi repository yang menjadi perantara layar dengan sumber data lokal; operasi baca/tulis dipusatkan di sini.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/detail_riwayat.dart';
import '../../model/catatan_pengajuan.dart';
import '../sumber_data/sumber_data_pengajuan_lokal.dart';

/// Keterangan kelas: RequestRepositoryImpl adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class RequestRepositoryImpl {
  const RequestRepositoryImpl({
    this.dataSource = const LocalRequestDataSource(),
  });

  final LocalRequestDataSource dataSource;

  List<RequestRecord> getAll() => dataSource.getAll();

  RequestRecord getDashboardFeatured() => dataSource.getDashboardFeatured();

  List<String> getStatuses() => dataSource.getStatuses();

  List<String> getRoomActivities() => dataSource.getRoomActivities();

  List<String> getEquipmentActivities() => dataSource.getEquipmentActivities();

  List<String> getResponsiblePeople() => dataSource.getResponsiblePeople();

  List<String> getEquipmentUnitOptions() =>
      dataSource.getEquipmentUnitOptions();

  HistoryDetail getSampleStatusDetail() => dataSource.getSampleStatusDetail();
}
