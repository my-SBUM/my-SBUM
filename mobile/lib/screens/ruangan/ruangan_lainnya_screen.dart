import 'package:flutter/material.dart';

class RuanganLainnyaScreen extends StatefulWidget {
  const RuanganLainnyaScreen({super.key});

  @override
  State<RuanganLainnyaScreen> createState() => _RuanganLainnyaScreenState();
}

class _RuanganLainnyaScreenState extends State<RuanganLainnyaScreen> {
  int _selectedBuildingIndex = 0; // 0: Semua Gedung, 1: Gedung A, 2: Gedung B, dst.
  String _selectedSort = 'Terdekat';
  bool _isListView = true;

  // Warna Utama
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  // Filter Gedung
  final List<String> _buildings = [
    'Semua Gedung',
    'Gedung A',
    'Gedung B',
    'Gedung C',
    'Gedung D',
    'Gedung E',
  ];

  // Dummy Data Ruangan
  final List<Map<String, dynamic>> _rooms = [
    {
      'name': 'Ruang Kelas A102',
      'location': 'Gedung A • Lt. 1',
      'facilities': '40 Kursi • Proyektor',
      'status': 'TERSEDIA',
      'floor': 'Lt. 1',
      'imageUrl': 'https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=400',
    },
    {
      'name': 'Ruang Kelas A103',
      'location': 'Gedung A • Lt. 1',
      'facilities': '36 Kursi • Smart TV',
      'status': 'TERSEDIA',
      'floor': 'Lt. 1',
      'imageUrl': 'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?q=80&w=400',
    },
    {
      'name': 'Lab Komputer',
      'location': 'Gedung C • Lt. 1',
      'facilities': '35 PC • LAN High Speed',
      'status': 'TIDAK TERSEDIA',
      'floor': 'Lt. 1',
      'imageUrl': 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=400',
    },
    {
      'name': 'Ruang Seminar B201',
      'location': 'Gedung B • Lt. 2',
      'facilities': '90 Orang • Sound System',
      'status': 'TIDAK TERSEDIA',
      'floor': 'Lt. 2',
      'imageUrl': 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=400',
    },
    {
      'name': 'Ruang Diskusi A301',
      'location': 'Gedung A • Lt. 3',
      'facilities': '15 Orang • Whiteboard',
      'status': 'TERSEDIA',
      'floor': 'Lt. 3',
      'imageUrl': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=400',
    },
    {
      'name': 'Auditorium E101',
      'location': 'Gedung E • Lt. 1',
      'facilities': '250 Kursi • Panggung Utama',
      'status': 'PERAWATAN',
      'floor': 'Lt. 1',
      'imageUrl': 'https://images.unsplash.com/photo-1511578314322-379afb476865?q=80&w=400',
    },
    {
      'name': 'Studio Musik E102',
      'location': 'Gedung E • Lt. 1',
      'facilities': 'Soundproof • Instrumen',
      'status': 'TERSEDIA',
      'floor': 'Lt. 1',
      'imageUrl': 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?q=80&w=400',
    },
    {
      'name': 'Ruang Rapat B301',
      'location': 'Gedung B • Lt. 3',
      'facilities': '25 Kursi • Video Conf',
      'status': 'TERSEDIA',
      'floor': 'Lt. 3',
      'imageUrl': 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=400',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: textDark),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Ruangan',
          style: TextStyle(
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE2E8F0),
              child: Icon(Icons.person, color: primaryGreen, size: 26),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  hintText: 'Cari ruangan atau gedung...',
                  hintStyle: TextStyle(color: textGrey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FILTER GEDUNG CHIPS ---
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _buildings.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedBuildingIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBuildingIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? primaryGreen : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        _buildings[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : textDark,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // --- SUB-HEADER: TOTAL RUANGAN & SORT/LAYOUT TOGGLE ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${_rooms.length} ',
                        style: const TextStyle(
                          color: textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: 'ruangan ditemukan',
                        style: TextStyle(
                          color: textGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // Dropdown Urutkan
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSort,
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: textGrey),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: textDark,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedSort = newValue;
                              });
                            }
                          },
                          items: <String>['Terdekat', 'Kapasitas', 'Nama']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text('Urutkan: $value'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Toggle View Buttons (List / Grid)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                            icon: Icon(
                              Icons.format_list_bulleted_rounded,
                              size: 18,
                              color: _isListView ? primaryGreen : textGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isListView = true;
                              });
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                            icon: Icon(
                              Icons.grid_view_rounded,
                              size: 18,
                              color: !_isListView ? primaryGreen : textGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isListView = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- LIST RUANGAN HORIZONAL CARD ---
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _rooms.length,
              itemBuilder: (context, index) {
                final room = _rooms[index];
                return _buildHorizontalRoomCard(
                  name: room['name'],
                  location: room['location'],
                  facilities: room['facilities'],
                  status: room['status'],
                  floor: room['floor'],
                  imageUrl: room['imageUrl'],
                );
              },
            ),
            const SizedBox(height: 20),

            // --- FOOTER BUTTON & PROGRESS BAR ---
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.autorenew_rounded, color: primaryGreen, size: 20),
                    label: const Text(
                      'Muat Lebih Banyak',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Menampilkan 8 dari 24 ruangan',
                  style: TextStyle(
                    fontSize: 13,
                    color: textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const SizedBox(
                    width: 160,
                    child: LinearProgressIndicator(
                      value: 8 / 24,
                      minHeight: 4,
                      backgroundColor: Color(0xFFE2E8F0),
                      valueColor: AlwaysStoppedAnimation<Color>(primaryGreen),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: KARTU RUANGAN HORIZONTAL ---
  Widget _buildHorizontalRoomCard({
    required String name,
    required String location,
    required String facilities,
    required String status,
    required String floor,
    required String imageUrl,
  }) {
    bool isAvailable = status == 'TERSEDIA';
    bool isMaintenance = status == 'PERAWATAN';

    // Warna Badge
    Color badgeBgColor = isAvailable
        ? const Color(0xFFDCFCE7)
        : (isMaintenance ? const Color(0xFFFFEDD5) : const Color(0xFFFEE2E2));
    Color badgeTextColor = isAvailable
        ? const Color(0xFF15803D)
        : (isMaintenance ? const Color(0xFFC2410C) : const Color(0xFFB91C1C));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Ruangan + Badge Lantai
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 95,
                  height: 95,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 95,
                      height: 95,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.meeting_room, color: Colors.grey),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    floor,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Detail Konten Kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul & Badge Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: badgeTextColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: badgeTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Lokasi
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 13, color: textGrey),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: textGrey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // Fasilitas / Kapasitas
                Row(
                  children: [
                    const Icon(Icons.chair_outlined, size: 13, color: textGrey),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        facilities,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: textGrey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Tombol Pilih / Jadwal
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 32,
                    child: isAvailable
                        ? ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryGreen,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Pilih',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.arrow_forward_rounded, size: 14, color: Colors.white),
                              ],
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE0EDFF),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                            ),
                            icon: const Icon(
                              Icons.visibility_outlined,
                              size: 14,
                              color: Color(0xFF2563EB),
                            ),
                            label: const Text(
                              'Jadwal',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}