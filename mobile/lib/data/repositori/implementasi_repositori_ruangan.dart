// Penjelasan edukatif: Implementasi repository yang menjadi perantara layar dengan sumber data lokal; operasi baca/tulis dipusatkan di sini.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/ruangan.dart';
import '../../model/ruang.dart';
import '../sumber_data/sumber_data_ruangan_lokal.dart';

/// Keterangan kelas: RuanganRepositoryImpl adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class RuanganRepositoryImpl {
  const RuanganRepositoryImpl({
    this.dataSource = const LocalRuanganDataSource(),
  });

  final LocalRuanganDataSource dataSource;

  List<Ruangan> getAll() => dataSource.getAll();

  List<Ruangan> getAdditional() => dataSource.getAdditional();

  List<String> getBuildings() => dataSource.getBuildings();

  Room getDefaultDetailRoom() => dataSource.getDefaultDetailRoom();

  List<SessionSlot> getSessions() => dataSource.getSessions();
}
