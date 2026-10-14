import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_ruangan.dart';
import 'package:my_sbum/model/ruangan.dart';

class RuanganLainnyaScreen extends StatefulWidget {
  const RuanganLainnyaScreen({super.key});

  @override
  State<RuanganLainnyaScreen> createState() => _RuanganLainnyaScreenState();
}

class _RuanganLainnyaScreenState extends State<RuanganLainnyaScreen> {
  int _selectedBuildingIndex = 0; // 0: Semua Gedung, 1: Gedung A, dst.
  String _selectedSort = 'Terdekat';
  bool _isListView = true;
  String _query = '';

  // Warna Utama
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  static const List<String> _sortOptions = ['Terdekat', 'Kapasitas', 'Nama'];

  final _repository = const RuanganRepositoryImpl();
  late final List<Ruangan> _rooms = _repository.getAdditional();
  late final List<String> _buildings = _repository.getBuildings();

  // Hasil setelah filter gedung, pencarian, dan urutan
  List<Ruangan> get _filtered {
    final selectedBuilding = _buildings[_selectedBuildingIndex];
    final q = _query.trim().toLowerCase();

    final list = _rooms.where((room) {
      final matchBuilding =
          _selectedBuildingIndex == 0 ||
          room.lokasi.toLowerCase().contains(selectedBuilding.toLowerCase());
      final searchableText = [
        room.nama,
        room.lokasi,
        room.lantai ?? '',
        room.ringkasanFasilitas ?? '',
        ...room.fasilitas,
      ].join(' ').toLowerCase();
      return matchBuilding && (q.isEmpty || searchableText.contains(q));
    }).toList();

    if (_selectedSort == 'Kapasitas') {
      list.sort((a, b) => b.kapasitas.compareTo(a.kapasitas));
    } else if (_selectedSort == 'Nama') {
      list.sort((a, b) => a.nama.compareTo(b.nama));
    }
    return list;
  }

  void _onAction(Ruangan room) {
    Navigator.pushNamed(context, AppRoutes.ruanganDetail, arguments: room);
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return AppScaffold(
      showBackground: true,
      body: Stack(
        children: [
          const AppPageBackgroundLayer(),
          SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: [
                const AppPageHeader(title: 'Ruangan'),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- SEARCH BAR ---
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x05000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (v) => setState(() => _query = v),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.search, color: textGrey),
                              hintText: 'Cari ruangan atau gedung...',
                              hintStyle: TextStyle(
                                color: textGrey,
                                fontSize: 14,
                              ),
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
                              final isSelected =
                                  _selectedBuildingIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedBuildingIndex = index;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? primaryGreen
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? primaryGreen
                                          : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Text(
                                    _buildings[index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : textDark,
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
                            Flexible(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${items.length} ',
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
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Dropdown Urutkan
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedSort,
                                      isDense: true,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        size: 18,
                                        color: textGrey,
                                      ),
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
                                      items: _sortOptions
                                          .map<DropdownMenuItem<String>>((
                                            String value,
                                          ) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          })
                                          .toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Toggle View Buttons (List / Grid)
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(
                                          minWidth: 32,
                                          minHeight: 32,
                                        ),
                                        icon: Icon(
                                          Icons.format_list_bulleted_rounded,
                                          size: 18,
                                          color: _isListView
                                              ? primaryGreen
                                              : textGrey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isListView = true;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(
                                          minWidth: 32,
                                          minHeight: 32,
                                        ),
                                        icon: Icon(
                                          Icons.grid_view_rounded,
                                          size: 18,
                                          color: !_isListView
                                              ? primaryGreen
                                              : textGrey,
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

                        // --- DAFTAR RUANGAN (LIST / GRID) ---
                        if (items.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 60),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 48,
                                    color: textGrey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Ruangan tidak ditemukan',
                                    style: TextStyle(
                                      color: textGrey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (_isListView)
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) =>
                                _buildHorizontalRoomCard(items[index]),
                          )
                        else
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  mainAxisExtent: 268,
                                ),
                            itemBuilder: (context, index) =>
                                _buildGridRoomCard(items[index]),
                          ),
                        const SizedBox(height: 20),

                        // --- FOOTER PROGRESS BAR ---
                        if (items.isNotEmpty)
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Menampilkan ${items.length} dari ${_rooms.length} ruangan',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: textGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: SizedBox(
                                    width: 160,
                                    child: LinearProgressIndicator(
                                      value: items.length / _rooms.length,
                                      minHeight: 4,
                                      backgroundColor: const Color(0xFFE2E8F0),
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            primaryGreen,
                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                      ],
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

  // --- HELPER: WARNA BADGE ---
  Color _badgeBg(String status) {
    if (status == 'TERSEDIA') return const Color(0xFFDCFCE7);
    if (status == 'PERAWATAN') return const Color(0xFFFFEDD5);
    return const Color(0xFFFEE2E2);
  }

  Color _badgeFg(String status) {
    if (status == 'TERSEDIA') return const Color(0xFF15803D);
    if (status == 'PERAWATAN') return const Color(0xFFC2410C);
    return const Color(0xFFB91C1C);
  }

  // --- HELPER: BADGE STATUS ---
  Widget _buildStatusBadge(String status) {
    final bg = _badgeBg(status);
    final fg = _badgeFg(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER: GAMBAR + LABEL LANTAI ---
  Widget _buildImage(
    Ruangan room, {
    required double width,
    required double height,
    double radius = 12,
  }) {
    final floor = room.lantai ?? '';
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            room.gambar ?? '',
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey.shade300,
                child: const Icon(Icons.meeting_room, color: Colors.grey),
              );
            },
          ),
        ),
        if (floor.isNotEmpty)
          Positioned(
            bottom: 6,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xA6000000),
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
    );
  }

  // --- HELPER: BARIS INFO KECIL ---
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: textGrey),
        const SizedBox(width: 3),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: textGrey),
          ),
        ),
      ],
    );
  }

  // --- HELPER: TOMBOL PILIH / JADWAL ---
  Widget _buildActionButton(Ruangan room) {
    final isAvailable = room.statusLabel == 'TERSEDIA';
    return SizedBox(
      height: 32,
      child: isAvailable
          ? ElevatedButton(
              onPressed: () => _onAction(room),
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
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          : ElevatedButton.icon(
              onPressed: () => _onAction(room),
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
    );
  }

  BoxDecoration get _cardDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2)),
    ],
  );

  // --- KARTU RUANGAN HORIZONTAL (MODE LIST) ---
  Widget _buildHorizontalRoomCard(Ruangan room) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: _cardDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(room, width: 95, height: 95),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        room.nama,
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
                    _buildStatusBadge(room.statusLabel),
                  ],
                ),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.location_on_outlined, room.lokasi),
                const SizedBox(height: 2),
                _buildInfoRow(
                  Icons.chair_outlined,
                  room.ringkasanFasilitas ?? '',
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildActionButton(room),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU RUANGAN VERTIKAL (MODE GRID) ---
  Widget _buildGridRoomCard(Ruangan room) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: _cardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(room, width: constraints.maxWidth - 20, height: 110),
              const SizedBox(height: 8),
              Text(
                room.nama,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 4),
              _buildInfoRow(Icons.location_on_outlined, room.lokasi),
              const SizedBox(height: 2),
              _buildInfoRow(
                Icons.people_outline,
                'Kapasitas: ${room.kapasitas} orang',
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(child: _buildStatusBadge(room.statusLabel)),
                  const SizedBox(width: 4),
                  _buildActionButton(room),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
