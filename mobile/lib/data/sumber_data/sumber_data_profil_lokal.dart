import '../../model/profil_pengguna.dart';

class LocalProfileDataSource {
  const LocalProfileDataSource();

  UserProfile getCurrentProfile() => const UserProfile(
    name: 'Raim Laode',
    role: 'Peminjam',
    phone: '123123123',
    email: 'laode.abdul.rahman@gmail.com',
    avatarUrl: 'https://img.freepik.com/premium-photo/cute-cartoon-boy-with-black-hair-smiling_949067-28056.jpg',
  );
}
