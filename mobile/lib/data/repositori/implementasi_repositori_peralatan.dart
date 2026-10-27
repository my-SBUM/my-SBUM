// Penjelasan edukatif: Implementasi repository yang menjadi perantara layar dengan sumber data lokal; operasi baca/tulis dipusatkan di sini.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/peralatan.dart';
import '../../model/alat.dart';
import '../sumber_data/sumber_data_peralatan_lokal.dart';

/// Keterangan kelas: PeralatanRepositoryImpl adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class PeralatanRepositoryImpl {
  const PeralatanRepositoryImpl({
    this.dataSource = const LocalPeralatanDataSource(),
  });

  final LocalPeralatanDataSource dataSource;

  List<Peralatan> getAll() => dataSource.getAll();

  List<Peralatan> getAdditional() => dataSource.getAdditional();

  List<String> getCategories() => dataSource.getCategories();

  List<String> getSortOptions() => dataSource.getSortOptions();

  Equipment getDefaultDetailItem() => dataSource.getDefaultDetailItem();
}
