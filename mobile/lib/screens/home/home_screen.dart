import 'package:flutter/material.dart';
import '../ruangan/ruangan_screen.dart'; // Import Halaman Ruangan
import '../peralatan/peralatan_screen.dart'; // Import Halaman Peralatan
import '../riwayat/riwayat_screen.dart'; // Import Halaman Riwayat
import '../lainnya/lainnya_screen.dart'; // Import Halaman Lainnya

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Warna Utama
  static const Color primaryGreen = Color(0xFF2E9451);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  // Indeks tab (supaya mudah dipakai untuk navigasi dari dashboard)
  static const int _tabDashboard = 0;
  static const int _tabRuangan = 1;
  static const int _tabPeralatan = 2;
  static const int _tabRiwayat = 3;
  static const int _tabLainnya = 4;

  void _goToTab(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      // IndexedStack: semua halaman tetap hidup, state (pencarian, filter,
      // posisi scroll) tidak hilang saat pindah tab.
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardContent(), // Index 0: Dashboard Utama
          const RuanganScreen(), // Index 1: Halaman Ruangan
          const PeralatanScreen(), // Index 2: Halaman Peralatan
          const RiwayatScreen(), // Index 3: Halaman Riwayat
          const LainnyaScreen(), // Index 4: Halaman Lainnya
        ],
      ),

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- BOTTOM NAV (dengan garis hijau di atas tab aktif) ---
  Widget _buildBottomNav() {
    const items = [
      (Icons.grid_view_outlined, Icons.grid_view_rounded, 'Dashboard'),
      (Icons.meeting_room_outlined, Icons.meeting_room, 'Ruangan'),
      (Icons.devices_outlined, Icons.devices, 'Peralatan'),
      (Icons.history, Icons.history, 'Riwayat'),
      (Icons.more_horiz, Icons.more_horiz, 'Lainnya'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(items.length, (i) {
              final active = i == _selectedIndex;
              final color = active ? primaryGreen : textGrey;
              final item = items[i];
              return Expanded(
                child: InkWell(
                  onTap: () => _goToTab(i),
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        width: 44,
                        decoration: BoxDecoration(
                          color: active ? primaryGreen : Colors.transparent,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(4),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(active ? item.$2 : item.$1, color: color, size: 24),
                      const SizedBox(height: 2),
                      Text(
                        item.$3,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight:
                              active ? FontWeight.w700 : FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // --- CONTENT DASHBOARD UTAMA (INDEX 0) ---
  Widget _buildDashboardContent() {
    return Stack(
      children: [
        // Background Image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 280,
          child: Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0x80E8F5E9));
            },
          ),
        ),

        // Konten Scroll Dashboard
        SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Logo & Avatar
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
                      child:
                          Icon(Icons.person, color: primaryGreen, size: 28),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Greeting
                const Text('Halo,',
                    style: TextStyle(fontSize: 16, color: textDark)),
                const Text(
                  'Selamat datang di mySBUM',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark),
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
                        onTap: () => _goToTab(_tabRiwayat),
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
                        onTap: () => _goToTab(_tabRiwayat),
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
                      color: textDark),
                ),
                const SizedBox(height: 12),
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  elevation: 0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => _goToTab(_tabRiwayat),
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
                            child: const Icon(Icons.laptop_chromebook,
                                color: primaryGreen, size: 26),
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
                                      color: textDark),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'PIC : Laode Abdul Rahman',
                                  style: TextStyle(
                                      fontSize: 12, color: textGrey),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle,
                                          size: 12, color: primaryGreen),
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
                            child: const Icon(Icons.chevron_right,
                                color: Colors.white, size: 22),
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
                      color: textDark),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 32, horizontal: 20),
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
                          const Icon(Icons.assignment_outlined,
                              size: 56, color: primaryGreen),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Belum ada aktivitas',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textDark),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Aktivitas peminjaman, pengembalian dan\npengelolaan akan muncul di sini.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, color: textGrey, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
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
                        color: iconBgColor, shape: BoxShape.circle),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: textDark),
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
                        color: textDark),
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