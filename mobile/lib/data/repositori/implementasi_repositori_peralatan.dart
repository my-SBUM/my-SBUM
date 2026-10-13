import '../../model/peralatan.dart';
import '../../model/alat.dart';
import '../sumber_data/sumber_data_peralatan_lokal.dart';

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
