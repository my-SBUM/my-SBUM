import '../../model/profil_pengguna.dart';
import '../sumber_data/sumber_data_profil_lokal.dart';

class ProfileRepositoryImpl {
  const ProfileRepositoryImpl({
    this.dataSource = const LocalProfileDataSource(),
  });

  final LocalProfileDataSource dataSource;

  UserProfile getCurrentProfile() => dataSource.getCurrentProfile();
}
