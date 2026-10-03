import 'panduan_screen.dart';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart'; // Import untuk fungsi Keluar/Logout

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  // Warna Tema (Disamakan dengan halaman lain)
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // 1. Background Header Image (Konsisten dengan tab lain)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE8F5E9).withOpacity(0.5),
                );
              },
            ),
          ),

          // 2. Konten Utama
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER (Logo & Avatar) ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF62D283), Color(0xFF237641)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.meeting_room_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 8),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'my\n',
                                  style: TextStyle(
                                    color: primaryGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'SBUM',
                                  style: TextStyle(
                                    color: primaryGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: Color(0xFFE2E8F0),
                        child: Icon(
                          Icons.person,
                          color: primaryGreen,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- JUDUL HALAMAN ---
                  const Text(
                    'Lainnya',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- DAFTAR MENU ---
                  _buildMenuItem(
                    icon: Icons.menu_book_outlined,
                    title: 'Panduan',
                    onTap: () {
                      // TODO: Navigasi ke halaman Panduan
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PanduanScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifikasi',
                    onTap: () {
                      // TODO: Navigasi ke halaman Notifikasi
                    },
                  ),
                  const SizedBox(height: 12),

                  // Menu Keluar (Warna Merah agar menonjol)
                  _buildMenuItem(
                    icon: Icons.logout_rounded,
                    title: 'Keluar',
                    isLogout: true,
                    onTap: () {
                      // Fungsi Logout: Kembali ke Halaman Login dan hapus riwayat rute
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: KARTU MENU ---
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    // Jika itu tombol keluar, warnanya jadi merah. Jika bukan, pakai warna utama
    final Color itemColor = isLogout ? const Color(0xFFDC2626) : textDark;
    final Color iconColor = isLogout ? const Color(0xFFDC2626) : primaryGreen;
    final Color arrowColor = isLogout ? const Color(0xFFFCA5A5) : textGrey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isLogout
                    ? const Color(0xFFFEE2E2)
                    : const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: itemColor,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: arrowColor, size: 22),
          ],
        ),
      ),
    );
  }
}
