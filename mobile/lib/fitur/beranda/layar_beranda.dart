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
                      iconBgColor: const Color(0xFF3B82F6),
                      borderColor: const Color(0xFFBFDBFE),
                      bgColor: Colors.white,
                      title: 'Total peralatan',
                      count: '4',
                      onTap: () => _goToTab(_tabPeralatan),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.home_rounded,
                      iconBgColor: const Color(0xFF10B981),
                      borderColor: const Color(0xFFA7F3D0),
                      bgColor: Colors.white,
                      title: 'Total ruangan',
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
                      icon: Icons.check_circle_rounded,
                      iconBgColor: const Color(0xFF10B981),
                      borderColor: const Color(0xFFA7F3D0),
                      bgColor: Colors.white,
                      title: 'Proses selesai',
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
                      icon: Icons.cancel_rounded,
                      iconBgColor: const Color(0xFFEF4444),
                      borderColor: const Color(0xFFFECACA),
                      bgColor: Colors.white,
                      title: 'Proses ditolak',
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
                    AppRoutes.riwayatDetail,
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
    required Color iconBgColor,
    required Color borderColor,
    required Color bgColor,
    required String title,
    required String count,
    required VoidCallback onTap,
  }) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x05000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: textDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    count,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const Icon(Icons.chevron_right, size: 18, color: textGrey),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
