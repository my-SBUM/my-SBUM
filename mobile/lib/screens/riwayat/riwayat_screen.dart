import 'package:flutter/material.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  int _selectedFilterIndex = 0; // 0: Semua, 1: Menunggu, 2: Diterima, 3: Ditolak

  // Warna Tema
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  final List<String> _filters = ['Semua', 'Menunggu', 'Diterima', 'Ditolak'];

  // Data Dummy Riwayat
  final List<Map<String, dynamic>> _riwayatList = [
    {
      'title': 'Ruang Kelas A101',
      'id': '#REQ-2026-089',
      'date': 'Senin, 21-09-2026 • 08:15 – 10:15 WIB',
      'pic': 'Informatika • Andi Wijaya',
      'status': 'Menunggu',
      'icon': Icons.meeting_room_outlined,
      'isRoom': true,
    },
    {
      'title': 'Proyektor Epson LCI',
      'id': '#EQP-2026-042',
      'date': 'Selasa, 22-09-2026 • 13:00 – 15:30 WIB',
      'pic': 'Sistem Informasi • Budi Santoso',
      'status': 'Diterima',
      'icon': Icons.videocam_outlined,
      'isRoom': false,
    },
    {
      'title': 'Ruang Lab Komputer',
      'id': '#REQ-2026-077',
      'date': 'Rabu, 23-09-2026 • 09:00 – 11:00 WIB',
      'pic': 'Informatika • Jadwal Bentrok Kuliah Reguler',
      'status': 'Ditolak',
      'icon': Icons.laptop_mac_outlined,
      'isRoom': true,
      'isError': true,
    },
  ];

  // LOGIKA FILTER: Mengambil daftar riwayat sesuai tab yang dipilih
  List<Map<String, dynamic>> get _filteredRiwayat {
    if (_selectedFilterIndex == 0) {
      return _riwayatList; // Tab "Semua"
    } else {
      final selectedStatus = _filters[_selectedFilterIndex];
      return _riwayatList.where((item) => item['status'] == selectedStatus).toList();
    }
  }

  // LOGIKA BADGE: Menghitung jumlah item berdasarkan tab tertentu
  int _getCountForFilter(int index) {
    if (index == 0) return _riwayatList.length;
    final status = _filters[index];
    return _riwayatList.where((item) => item['status'] == status).length;
  }

  @override
  Widget build(BuildContext context) {
    final displayedRiwayat = _filteredRiwayat; // Simpan ke variabel lokal untuk performa

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // 1. Background Header Image
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
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
                        child: Icon(Icons.person, color: primaryGreen, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- JUDUL HALAMAN ---
                  const Text(
                    'Riwayat Peminjaman',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Riwayat peminjaman ruang dan peralatan',
                    style: TextStyle(
                      fontSize: 13,
                      color: textGrey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- SEARCH BAR ---
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: textGrey),
                        hintText: 'Cari ruangan, peralatan, atau PIC...',
                        hintStyle: TextStyle(color: textGrey, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- FILTER CHIPS AKTIF ---
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedFilterIndex == index;
                        final itemCount = _getCountForFilter(index);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedFilterIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryGreen : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? primaryGreen : const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Row(
                              children: [
                                if (index == 0 && isSelected) ...[
                                  const Icon(Icons.library_books_outlined, size: 16, color: Colors.white),
                                  const SizedBox(width: 6),
                                ],
                                Text(
                                  _filters[index],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : textGrey,
                                  ),
                                ),
                                // Badge jumlah item yang dinamis
                                if (isSelected) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.25),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      itemCount.toString(),
                                      style: const TextStyle(color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- LIST RIWAYAT & EMPTY STATE ---
                  displayedRiwayat.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Column(
                              children: [
                                Icon(Icons.history_rounded, size: 64, color: Colors.grey.shade300),
                                const SizedBox(height: 12),
                                Text(
                                  'Belum ada riwayat untuk status ini.',
                                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: displayedRiwayat.length,
                          itemBuilder: (context, index) {
                            return _buildHistoryCard(displayedRiwayat[index]);
                          },
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: KARTU RIWAYAT ---
  Widget _buildHistoryCard(Map<String, dynamic> data) {
    Color statusColor;
    Color statusBgColor;
    Widget statusIcon;

    if (data['status'] == 'Menunggu') {
      statusColor = const Color(0xFFD97706);
      statusBgColor = const Color(0xFFFEF3C7);
      statusIcon = const Icon(Icons.circle, size: 8, color: Color(0xFFD97706));
    } else if (data['status'] == 'Diterima') {
      statusColor = const Color(0xFF059669);
      statusBgColor = const Color(0xFFD1FAE5);
      statusIcon = const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF059669));
    } else {
      statusColor = const Color(0xFFDC2626);
      statusBgColor = const Color(0xFFFEE2E2);
      statusIcon = const Icon(Icons.cancel_outlined, size: 14, color: Color(0xFFDC2626));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(data['icon'], color: primaryGreen, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ID: ${data['id']}',
                      style: const TextStyle(fontSize: 12, color: textGrey, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    statusIcon,
                    const SizedBox(width: 4),
                    Text(
                      data['status'],
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 16, color: textGrey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data['date'],
                        style: const TextStyle(fontSize: 13, color: textGrey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      data['isError'] == true ? Icons.error_outline : Icons.person_outline,
                      size: 16,
                      color: textGrey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        data['pic'],
                        style: const TextStyle(fontSize: 13, color: textGrey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (data['status'] == 'Menunggu')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEE2E2),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: const Icon(Icons.close_rounded, size: 18, color: Color(0xFFDC2626)),
                    label: const Text(
                      'Batalkan',
                      style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA7F3D0),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lihat Detail',
                          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.chevron_right_rounded, size: 18, color: primaryGreen),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else if (data['status'] == 'Diterima')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.remove_red_eye_outlined, size: 18, color: Colors.white),
                label: const Text(
                  'Lihat Detail Peminjaman',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          else if (data['status'] == 'Ditolak')
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEE2E2),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.info_outline_rounded, size: 18, color: Color(0xFFDC2626)),
                label: const Text(
                  'Lihat Detail Alasan',
                  style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}