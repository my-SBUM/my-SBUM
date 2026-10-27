// Penjelasan edukatif: Model data aplikasi; class di sini membawa nilai yang dipakai layar dan repository.

/// Keterangan kelas: UserProfile adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class UserProfile {
  const UserProfile({
    required this.name,
    required this.role,
    required this.phone,
    required this.email,
    required this.avatarUrl,
  });

  final String name;
  final String role;
  final String phone;
  final String email;
  final String avatarUrl;
}
