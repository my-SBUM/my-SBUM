import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/navigasi_bawah_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/fitur/peralatan/layar_peralatan.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat.dart';
import 'package:my_sbum/fitur/lainnya/layar_lainnya.dart';
import 'package:my_sbum/fitur/ruangan/layar_ruangan.dart';
import 'package:my_sbum/komponen/bilah_atas_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  // Warna Utama
  static const Color primaryGreen = Color(0xFF2E9451);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  // Indeks tab (supaya mudah dipakai untuk navigasi dari dashboard)
  static const int _tabRuangan = 1;
  static const int _tabPeralatan = 2;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab.clamp(0, 4);
  }

  void _goToTab(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackground: true,

      // IndexedStack: semua halaman tetap hidup, state (pencarian, filter,
      // posisi scroll) tidak hilang saat pindah tab.
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardContent(),
          const RuanganScreen(),
          const PeralatanScreen(),
          const RiwayatScreen(),
          const LainnyaScreen(),
        ],
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _goToTab,
      ),
    );
  }

  // --- CONTENT DASHBOARD UTAMA (INDEX 0) ---
  Widget _buildDashboardContent() {
    return AppPageBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(),
              const SizedBox(height: 24),

              // Greeting
              const Text(
                'Halo,',
                style: TextStyle(fontSize: 16, color: textDark),
              ),
              const Text(
                'Selamat datang di mySBUM',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Ajuan ruangan dan peralatan dengan mudah',
                style: TextStyle(fontSize: 13, color: textGrey),
              ),
              const SizedBox(height: 20),

              // Grid Statistik Card
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.desktop_windows_rounded,
                      borderColor: const Color(0xFFBFDBFE),
                      title: 'Total peralatan',
                      iconGradient: const [
                        Color(0xFF60A5FA),
                        Color(0xFF3B82F6),
                      ],
                      waveColor: const Color(0xFFDBEAFE),
                      waveStyle: 0,
                      count: '4',
                      onTap: () => _goToTab(_tabPeralatan),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.home_rounded,
                      borderColor: const Color(0xFF86DDB8),
                      title: 'Total ruangan',
                      iconGradient: const [
                        Color(0xFF3FCB8E),
                        Color(0xFF1E9A5C),
                      ],
                      waveColor: const Color(0xFFD5F3E6),
                      waveStyle: 1,
                      count: '24',
                      onTap: () => _goToTab(_tabRuangan),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.verified_rounded,
                      borderColor: const Color(0xFF86DDB8),
                      title: 'Proses selesai',
                      iconGradient: const [
                        Color(0xFF3FCB8E),
                        Color(0xFF1E9A5C),
                      ],
                      waveColor: const Color(0xFFD5F3E6),
                      waveStyle: 2,
                      count: '1',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.riwayatDiterima,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.close_rounded,
                      borderColor: const Color(0xFFF8B4B4),
                      title: 'Proses ditolak',
                      iconGradient: const [
                        Color(0xFFFF6B81),
                        Color(0xFFEF4444),
                      ],
                      waveColor: const Color(0xFFFCE4E4),
                      waveStyle: 3,
                      count: '1',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.riwayatDitolak,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Peminjaman yang dilakukan
              const Text(
                'Peminjaman yang dilakukan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),
              Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                elevation: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.riwayatDiterima,
                    arguments: const RequestRepositoryImpl()
                        .getDashboardFeatured(),
                  ),
                  child: Ink(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.laptop_chromebook,
                            color: primaryGreen,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ruang lab Komputer A091',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'PIC : Laode Abdul Rahman',
                                style: TextStyle(fontSize: 12, color: textGrey),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 12,
                                      color: primaryGreen,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Sedang Dipinjam',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: primaryGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: primaryGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Aktivitas
              const Text(
                'Aktivitas',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFFDCFCE7),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Icon(
                          Icons.assignment_outlined,
                          size: 56,
                          color: primaryGreen,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Belum ada aktivitas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Aktivitas peminjaman, pengembalian dan\npengelolaan akan muncul di sini.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: textGrey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget Kartu Statistik
  Widget _buildStatCard({
    required IconData icon,
    required List<Color> iconGradient,
    required Color borderColor,
    required Color waveColor,
    required int waveStyle,
    required String title,
    required String count,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.5),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 88),
              child: Stack(
                children: [
                  // Hiasan gelombang di bagian bawah kartu
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _WavePainter(color: waveColor, style: waveStyle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: iconGradient,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Icon(icon, color: Colors.white, size: 21),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Text(
                                        count,
                                        style: const TextStyle(
                                          fontSize: 28,
                                          height: 1.1,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right_rounded,
                                    size: 20,
                                    color: textDark,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Gambar gelombang lembut di dasar kartu statistik
class _WavePainter extends CustomPainter {
  const _WavePainter({required this.color, required this.style});

  final Color color;
  final int style;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = color;

    switch (style) {
      case 0: // bukit di kiri
        canvas.drawPath(
          Path()
            ..moveTo(0, h * 0.62)
            ..cubicTo(w * 0.2, h * 0.5, w * 0.4, h * 0.62, w * 0.58, h * 0.9)
            ..lineTo(w * 0.62, h)
            ..lineTo(0, h)
            ..close(),
          paint,
        );
        break;
      case 1: // bukit kiri kecil + gelombang kanan
        canvas.drawPath(
          Path()
            ..moveTo(0, h * 0.72)
            ..cubicTo(w * 0.15, h * 0.6, w * 0.35, h * 0.68, w * 0.5, h * 0.92)
            ..lineTo(w * 0.54, h)
            ..lineTo(0, h)
            ..close(),
          paint,
        );
        canvas.drawPath(
          Path()
            ..moveTo(w * 0.62, h)
            ..cubicTo(w * 0.72, h * 0.78, w * 0.86, h * 0.7, w, h * 0.76)
            ..lineTo(w, h)
            ..close(),
          paint,
        );
        break;
      case 2: // gelombang kiri rendah + bukit kanan
        canvas.drawPath(
          Path()
            ..moveTo(0, h * 0.8)
            ..cubicTo(w * 0.15, h * 0.74, w * 0.3, h * 0.84, w * 0.45, h)
            ..lineTo(0, h)
            ..close(),
          paint,
        );
        canvas.drawPath(
          Path()
            ..moveTo(w * 0.55, h)
            ..cubicTo(w * 0.7, h * 0.7, w * 0.86, h * 0.6, w, h * 0.68)
            ..lineTo(w, h)
            ..close(),
          paint,
        );
        break;
      default: // gelombang kiri rendah + bukit kanan besar
        canvas.drawPath(
          Path()
            ..moveTo(0, h * 0.86)
            ..cubicTo(w * 0.25, h * 0.8, w * 0.45, h * 0.9, w * 0.6, h)
            ..lineTo(0, h)
            ..close(),
          paint,
        );
        canvas.drawPath(
          Path()
            ..moveTo(w * 0.5, h)
            ..cubicTo(w * 0.68, h * 0.62, w * 0.86, h * 0.5, w, h * 0.55)
            ..lineTo(w, h)
            ..close(),
          paint,
        );
    }
  }

  @override
  bool shouldRepaint(_WavePainter old) =>
      old.color != color || old.style != style;
}
