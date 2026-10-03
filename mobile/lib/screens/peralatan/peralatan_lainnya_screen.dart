import 'package:flutter/material.dart';

class PeralatanLainnyaScreen extends StatefulWidget {
  const PeralatanLainnyaScreen({super.key});

  @override
  State<PeralatanLainnyaScreen> createState() => _PeralatanLainnyaScreenState();
}

// ---------- Model ----------
class _Equipment {
  final String name;
  final String location;
  final int stock;
  final String code;
  final String category;
  final String status; // TERSEDIA | TIDAK TERSEDIA | PERAWATAN
  final String imageUrl;

  const _Equipment({
    required this.name,
    required this.location,
    required this.stock,
    required this.code,
    required this.category,
    required this.status,
    required this.imageUrl,
  });
}

class _PeralatanLainnyaScreenState extends State<PeralatanLainnyaScreen> {
  int _selectedCategoryIndex = 0;
  String _selectedSort = 'Stok Terbanyak';
  bool _isListView = true;
  String _query = '';

  // Warna Utama
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  static const String _img =
      'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=400';

  // Filter Kategori
  final List<String> _categories = const [
    'Semua Kategori',
    'Kamera',
    'Lensa',
    'Audio',
    'Lighting',
    'Aksesoris',
  ];

  final List<String> _sortOptions = const [
    'Stok Terbanyak',
    'Nama',
    'Kategori',
  ];

  // Dummy Data Peralatan (ganti dengan data dari API)
  final List<_Equipment> _equipment = const [
    _Equipment(
        name: 'Kamera Luminux A7',
        location: 'Gudang SBUM',
        stock: 2,
        code: 'CMR 104',
        category: 'Kamera',
        status: 'TERSEDIA',
        imageUrl: _img),
    _Equipment(
        name: 'Kamera Luminux A9',
        location: 'Gudang SBUM',
        stock: 3,
        code: 'CMR 105',
        category: 'Kamera',
        status: 'TERSEDIA',
        imageUrl: _img),
    _Equipment(
        name: 'Kamera Luminux FX3',
        location: 'Gudang SBUM',
        stock: 0,
        code: 'CMR 106',
        category: 'Kamera',
        status: 'TIDAK TERSEDIA',
        imageUrl: _img),
    _Equipment(
        name: 'Lensa Luminux 24-70',
        location: 'Gudang SBUM',
        stock: 0,
        code: 'LNS 201',
        category: 'Lensa',
        status: 'TIDAK TERSEDIA',
        imageUrl: _img),
    _Equipment(
        name: 'Lensa Luminux 50mm',
        location: 'Gudang SBUM',
        stock: 2,
        code: 'LNS 202',
        category: 'Lensa',
        status: 'TERSEDIA',
        imageUrl: _img),
    _Equipment(
        name: 'Mikrofon Shotgun',
        location: 'Gudang SBUM',
        stock: 2,
        code: 'AUD 301',
        category: 'Audio',
        status: 'PERAWATAN',
        imageUrl: _img),
    _Equipment(
        name: 'Lampu LED Panel',
        location: 'Gudang SBUM',
        stock: 4,
        code: 'LGT 401',
        category: 'Lighting',
        status: 'TERSEDIA',
        imageUrl: _img),
    _Equipment(
        name: 'Tripod Profesional',
        location: 'Gudang SBUM',
        stock: 5,
        code: 'ACC 501',
        category: 'Aksesoris',
        status: 'TERSEDIA',
        imageUrl: _img),
  ];

  // Hasil setelah filter kategori, pencarian, dan urutan
  List<_Equipment> get _filtered {
    final q = _query.trim().toLowerCase();
    final selectedCategory = _categories[_selectedCategoryIndex];

    final list = _equipment.where((e) {
      final matchCategory =
          _selectedCategoryIndex == 0 || e.category == selectedCategory;
      final matchQuery = q.isEmpty ||
          e.name.toLowerCase().contains(q) ||
          e.code.toLowerCase().contains(q) ||
          e.category.toLowerCase().contains(q);
      return matchCategory && matchQuery;
    }).toList();

    if (_selectedSort == 'Nama') {
      list.sort((a, b) => a.name.compareTo(b.name));
    } else if (_selectedSort == 'Kategori') {
      list.sort((a, b) => a.category.compareTo(b.category));
    } else {
      list.sort((a, b) => b.stock.compareTo(a.stock)); // Stok Terbanyak
    }
    return list;
  }

  void _onAction(_Equipment item) {
    // TODO: arahkan ke detail peralatan / jadwal.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${item.status == 'TERSEDIA' ? 'Pilih' : 'Jadwal'}: ${item.name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    final canPop = Navigator.of(context).canPop();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leading: canPop
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        size: 18, color: textDark),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              )
            : null,
        title: const Text(
          'Peralatan',
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
                  hintText: 'Cari peralatan atau kategori...',
                  hintStyle: TextStyle(color: textGrey, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FILTER KATEGORI CHIPS ---
            SizedBox(
              height: 38,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryGreen : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? primaryGreen
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        _categories[index],
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

            // --- SUB-HEADER: TOTAL PERALATAN & SORT/LAYOUT TOGGLE ---
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
                          text: 'peralatan ditemukan',
                          style: TextStyle(color: textGrey, fontSize: 13),
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
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSort,
                          isDense: true,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              size: 18, color: textGrey),
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
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
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
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32),
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
                            constraints: const BoxConstraints(
                                minWidth: 32, minHeight: 32),
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

            // --- DAFTAR PERALATAN (LIST / GRID) ---
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 48, color: textGrey),
                      SizedBox(height: 8),
                      Text('Peralatan tidak ditemukan',
                          style: TextStyle(color: textGrey, fontSize: 14)),
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
                    _buildHorizontalEquipmentCard(items[index]),
              )
            else
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 268,
                ),
                itemBuilder: (context, index) =>
                    _buildGridEquipmentCard(items[index]),
              ),
            const SizedBox(height: 20),

            // --- FOOTER PROGRESS BAR ---
            if (items.isNotEmpty)
              Center(
                child: Column(
                  children: [
                    Text(
                      'Menampilkan ${items.length} dari ${_equipment.length} peralatan',
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
                          value: items.length / _equipment.length,
                          minHeight: 4,
                          backgroundColor: const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              primaryGreen),
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

  // --- HELPER: GAMBAR + LABEL KODE ---
  Widget _buildImage(_Equipment item,
      {required double width, required double height, double radius = 12}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            item.imageUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: width,
                height: height,
                color: Colors.grey.shade300,
                child: const Icon(Icons.camera_alt, color: Colors.grey),
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
              color: const Color(0xA6000000),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              item.code,
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
  Widget _buildActionButton(_Equipment item) {
    final isAvailable = item.status == 'TERSEDIA';
    return SizedBox(
      height: 32,
      child: isAvailable
          ? ElevatedButton(
              onPressed: () => _onAction(item),
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
                  Icon(Icons.arrow_forward_rounded,
                      size: 14, color: Colors.white),
                ],
              ),
            )
          : ElevatedButton.icon(
              onPressed: () => _onAction(item),
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
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      );

  // --- KARTU PERALATAN HORIZONTAL (MODE LIST) ---
  Widget _buildHorizontalEquipmentCard(_Equipment item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: _cardDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(item, width: 95, height: 95),
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
                        item.name,
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
                    _buildStatusBadge(item.status),
                  ],
                ),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.location_on_outlined, item.location),
                const SizedBox(height: 2),
                _buildInfoRow(
                    Icons.inventory_2_outlined, 'Stok: ${item.stock} Unit'),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildActionButton(item),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- KARTU PERALATAN VERTIKAL (MODE GRID) ---
  Widget _buildGridEquipmentCard(_Equipment item) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: _cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(item,
                width: constraints.maxWidth - 20, height: 110),
            const SizedBox(height: 8),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            _buildInfoRow(Icons.location_on_outlined, item.location),
            const SizedBox(height: 2),
            _buildInfoRow(
                Icons.inventory_2_outlined, 'Stok: ${item.stock} Unit'),
            const Spacer(),
            Row(
              children: [
                Expanded(child: _buildStatusBadge(item.status)),
                const SizedBox(width: 4),
                _buildActionButton(item),
              ],
            ),
          ],
        ),
      );
    });
  }
}