import '../../model/profil_pengguna.dart';

class LocalProfileDataSource {
  const LocalProfileDataSource();

  UserProfile getCurrentProfile() => const UserProfile(
    name: 'Raim Laode',
    role: 'Peminjam',
    phone: '123123123',
    email: 'laode.abdul.rahman@gmail.com',
    avatarUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=900&q=80',
  );
}
