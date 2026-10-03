import 'panduan_screen.dart';
import 'notifikasi_screen.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart'; // Import untuk fungsi Keluar/Logout

class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  // Warna Tema (Disamakan dengan halaman lain)
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Background header image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 225,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE8F5E9)
                          .withOpacity(0.5),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.02),
                        const Color(0xFFF8FAFC).withOpacity(0.10),
                        const Color(0xFFF8FAFC),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dekorasi lengkung hijau di pojok kanan atas
          Positioned(
            top: -90,
            right: -80,
            child: Container(
              width: 300,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFD7F2E0),
                    Color(0x00D7F2E0),
                  ],
                ),
              ),
            ),
          ),

          // Konten Utama
          SafeArea(
            bottom: false,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                24,
              ),
              children: [
                // --- HEADER (Logo & Avatar) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF62D283),
                                Color(0xFF237641),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: primaryGreen.withOpacity(0.20),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.meeting_room_outlined,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'my',
                              style: TextStyle(
                                color: primaryGreen,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                height: 1,
                              ),
                            ),
                            Text(
                              'SBUM',
                              style: TextStyle(
                                color: primaryGreen,
                                fontWeight: FontWeight.w900,
                                fontSize: 21,
                                height: 1.05,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFE2E8F0),
                        child: Icon(
                          Icons.person,
                          color: primaryGreen,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // --- JUDUL HALAMAN ---
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lainnya',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: textDark,
                          letterSpacing: -0.4,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pengaturan, panduan, dan informasi lainnya',
                        style: TextStyle(
                          fontSize: 13,
                          color: textGrey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- DAFTAR MENU ---
                _MenuItem(
                  icon: Icons.menu_book_outlined,
                  title: 'Panduan',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PanduanScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifikasi',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotifikasiScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Menu Keluar (Warna Merah agar menonjol)
                _MenuItem(
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
        ],
      ),
    );
  }
}

// ============================================================
// KARTU MENU DENGAN ANIMASI HOVER
// ============================================================
class _MenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<_MenuItem> {
  bool _hover = false;

  static const Color _green = Color(0xFF0A6332);
  static const Color _red = Color(0xFFC62828);
  static const Color _redSoft = Color(0xFFFFD6D6);
  static const Color _greenSoft = Color(0xFFC9F0D6);
  static const Color _textDark = Color(0xFF1E293B);
  static const Color _textGrey = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);

  static const Duration _durasi = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final bool logout = widget.isLogout;
    final Color accent = logout ? _red : _green;

    // Warna saat normal vs hover
    final Color cardBg = Colors.white;
    final Color borderColor = _hover
        ? accent
        : _border;
    final Color titleColor = logout ? _red : (_hover ? _green : _textDark);
    final Color iconBoxBg = logout ? _redSoft : _greenSoft;
    final Color iconColor = logout ? _red : _green;
    final Color arrowColor = _hover ? accent : _textGrey;

    return AnimatedContainer(
      duration: _durasi,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: _hover
            ? [
                BoxShadow(
                  color: accent.withOpacity(0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.025),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: widget.onTap,
          onHover: (isHovering) => setState(() => _hover = isHovering),
          hoverColor: Colors.transparent,
          splashColor: accent.withAlpha(25),
          highlightColor: accent.withAlpha(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBoxBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(widget.icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                ),
                // Panah bergeser ke kanan saat hover
                AnimatedSlide(
                  duration: _durasi,
                  curve: Curves.easeOutCubic,
                  offset: Offset(_hover ? 0.2 : 0, 0),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: arrowColor,
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
