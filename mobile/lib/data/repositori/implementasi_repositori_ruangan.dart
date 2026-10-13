import '../../model/ruangan.dart';
import '../../model/ruang.dart';
import '../sumber_data/sumber_data_ruangan_lokal.dart';

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
