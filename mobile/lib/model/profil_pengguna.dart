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
