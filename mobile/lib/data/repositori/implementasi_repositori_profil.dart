// Penjelasan edukatif: Implementasi repository yang menjadi perantara layar dengan sumber data lokal; operasi baca/tulis dipusatkan di sini.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/profil_pengguna.dart';
import '../sumber_data/sumber_data_profil_lokal.dart';

/// Keterangan kelas: ProfileRepositoryImpl adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class ProfileRepositoryImpl {
  const ProfileRepositoryImpl({
    this.dataSource = const LocalProfileDataSource(),
  });

  final LocalProfileDataSource dataSource;

  UserProfile getCurrentProfile() => dataSource.getCurrentProfile();
}
