// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/fitur/aksi/layar_keluar.dart';
import 'package:my_sbum/komponen/bilah_atas_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

/// Keterangan kelas: LainnyaScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class LainnyaScreen extends StatelessWidget {
  const LainnyaScreen({super.key});

  // Warna Tema
  static const Color textDark = Color(0xFF0F172A);
  static const Color textGrey = Color(0xFF64748B);

  // Warna tiap menu
  static const Color panduanBg = Color(0xFFFEF9E7);
  static const Color panduanIcon = Color(0xFFEAB308);
  static const Color notifBg = Color(0xFFFDF1F1);
  static const Color notifIcon = Color(0xFFEF4444);
  static const Color keluarBg = Color(0xFFF3F5F8);
  static const Color keluarIcon = Color(0xFF64748B);
  static const Color keluarText = Color(0xFF475569);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackground: false,
      body: Stack(
        children: [
          const AppPageBackgroundLayer(),

          // Konten Utama
          SafeArea(
            bottom: false,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                // --- HEADER (Logo & Profil) sama seperti halaman Peralatan ---
                const AppHeader(),
                const SizedBox(height: 24),

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
                  icon: Icons.info_outline_rounded,
                  title: 'Panduan',
                  iconBg: panduanBg,
                  iconColor: panduanIcon,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.panduan),
                ),
                const SizedBox(height: 12),
                _MenuItem(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifikasi',
                  iconBg: notifBg,
                  iconColor: notifIcon,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.notifikasi),
                ),
                const SizedBox(height: 12),
                _MenuItem(
                  icon: Icons.logout_rounded,
                  title: 'Keluar',
                  iconBg: keluarBg,
                  iconColor: keluarIcon,
                  titleColor: keluarText,
                  onTap: () => LogoutDialogPage.showAndLogout(context),
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
/// Keterangan kelas: _MenuItem adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _MenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconBg;
  final Color iconColor;
  final Color titleColor;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.iconBg,
    required this.iconColor,
    required this.onTap,
    this.titleColor = const Color(0xFF0F172A),
  });

  @override
  State<_MenuItem> createState() => _MenuItemState();
}

/// Keterangan kelas: _MenuItemState adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _MenuItemState extends State<_MenuItem> {
  bool _hover = false;

  static const Color _border = Color(0xFFE2E8F0);
  static const Color _chevron = Color(0xFF94A3B8);
  static const Duration _durasi = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final Color accent = widget.iconColor;
    final Color borderColor = _hover ? accent : _border;
    final Color arrowColor = _hover ? accent : _chevron;

    return AnimatedContainer(
      duration: _durasi,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1),
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
                    color: widget.iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, color: widget.iconColor, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: widget.titleColor,
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
