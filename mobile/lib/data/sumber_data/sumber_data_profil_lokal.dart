// Penjelasan edukatif: Sumber data lokal simulasi; class di sini menyediakan data contoh dan perubahan data tanpa server.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/profil_pengguna.dart';

/// Keterangan kelas: LocalProfileDataSource adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class LocalProfileDataSource {
  const LocalProfileDataSource();

  UserProfile getCurrentProfile() => const UserProfile(
    name: 'Raim Laode',
    role: 'Peminjam',
    phone: '123123123',
    email: 'laode.abdul.rahman@gmail.com',
    avatarUrl: 'assets/images/foto_lokal_04_5749c8d2a1.jpg',
  );
}
