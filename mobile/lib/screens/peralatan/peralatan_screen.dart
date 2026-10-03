import 'package:flutter/material.dart';

import 'peralatan_lainnya_screen.dart';

// ---------- Warna ----------
class _C {
  static const green = Color(0xFF2E9451);
  static const greenDark = Color(0xFF0A6332);
  static const greenSoft = Color(0xFFC9F0D6);
  static const red = Color(0xFFC62828);
  static const redSoft = Color(0xFFFFD6D6);
  static const blueSoft = Color(0xFFDDE8FA);
  static const blue = Color(0xFF1E3A8A);
  static const bg = Color(0xFFF8FAFC);
  static const text = Color(0xFF1E293B);
  static const muted = Color(0xFF64748B);
  static const border = Color(0xFFE2E8F0);
}

// ---------- Model ----------
class Peralatan {
  final String nama;
  final int stok;
  final String lokasi;
  final String? gambar;

  const Peralatan({
    required this.nama,
    required this.stok,
    required this.lokasi,
    this.gambar,
  });

  bool get tersedia => stok > 0;
}

enum _Filter { semua, tersedia, tidakTersedia }

// ---------- Screen ----------
class PeralatanScreen extends StatefulWidget {
  const PeralatanScreen({super.key});

  @override
  State<PeralatanScreen> createState() => _PeralatanScreenState();
}

class _PeralatanScreenState extends State<PeralatanScreen> {
  // Jumlah kartu yang ditampilkan di halaman ini.
  // Sisanya dilihat lewat tombol "Lihat Peralatan Lainnya".
  static const int _maxTampil = 4;

  static const String _img =
      'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?q=80&w=400';

  // Data contoh. Ganti dengan data dari API/repository.
  final List<Peralatan> _semua = const [
    Peralatan(
      nama: 'Kamera Luminux A7',
      stok: 4,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux A7 II',
      stok: 0,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux A7 III',
      stok: 4,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux A7 IV',
      stok: 4,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux A9',
      stok: 2,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux A9 II',
      stok: 0,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux FX3',
      stok: 3,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
    Peralatan(
      nama: 'Kamera Luminux FX6',
      stok: 1,
      lokasi: 'Gudang SBUM',
      gambar: _img,
    ),
  ];

  final TextEditingController _searchCtrl = TextEditingController();

  _Filter _filter = _Filter.semua;
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Peralatan> get _hasilFilter {
    final q = _query.trim().toLowerCase();

    return _semua.where((p) {
      bool cocokFilter;

      if (_filter == _Filter.tersedia) {
        cocokFilter = p.tersedia;
      } else if (_filter == _Filter.tidakTersedia) {
        cocokFilter = !p.tersedia;
      } else {
        cocokFilter = true;
      }

      final cocokCari =
          q.isEmpty || p.nama.toLowerCase().contains(q);

      return cocokFilter && cocokCari;
    }).toList();
  }

  void _aksi(Peralatan p, {required bool pilih}) {
    // TODO: arahkan ke detail peralatan / jadwal.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${pilih ? 'Pilih' : 'Jadwal'}: ${p.nama}',
        ),
      ),
    );
  }

  void _bukaHalamanLainnya() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const PeralatanLainnyaScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasil = _hasilFilter;
    final tampil = hasil.take(_maxTampil).toList();

    final jumlahTersedia =
        _semua.where((p) => p.tersedia).length;

    final jumlahTidak =
        _semua.length - jumlahTersedia;

    return Scaffold(
      backgroundColor: _C.bg,
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
                        _C.bg.withOpacity(0.10),
                        _C.bg,
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
                const _TopBar(),
                const SizedBox(height: 28),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar Peralatan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: _C.text,
                          letterSpacing: -0.4,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Memilih peralatan yang tersedia bila dibutuhkan',
                        style: TextStyle(
                          fontSize: 13,
                          color: _C.muted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                _SearchField(
                  controller: _searchCtrl,
                  onChanged: (v) {
                    setState(() {
                      _query = v;
                    });
                  },
                ),

                const SizedBox(height: 14),

                _FilterRow(
                  selected: _filter,
                  jumlahSemua: _semua.length,
                  jumlahTersedia: jumlahTersedia,
                  jumlahTidak: jumlahTidak,
                  onSelect: (f) {
                    setState(() {
                      _filter = f;
                    });
                  },
                ),

                const SizedBox(height: 18),

                if (tampil.isEmpty)
                  const _EmptyState()
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: tampil.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      mainAxisExtent: 272,
                    ),
                    itemBuilder: (_, i) => _PeralatanCard(
                      item: tampil[i],
                      onPilih: () =>
                          _aksi(tampil[i], pilih: true),
                      onJadwal: () =>
                          _aksi(tampil[i], pilih: false),
                    ),
                  ),

                if (hasil.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  _ProgressInfo(
                    tampil: tampil.length,
                    total: hasil.length,
                  ),
                  const SizedBox(height: 14),
                  _LihatLainnya(
                    onTap: _bukaHalamanLainnya,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Komponen
// ============================================================

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    color: _C.greenDark.withOpacity(0.20),
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
                    color: _C.greenDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    height: 1,
                  ),
                ),
                Text(
                  'SBUM',
                  style: TextStyle(
                    color: _C.greenDark,
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
              color: _C.greenDark,
              size: 26,
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _C.border.withOpacity(0.9),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 14,
          color: _C.text,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Cari peralatan...',
          hintStyle: const TextStyle(
            color: _C.muted,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.search_rounded,
              color: _C.greenDark,
              size: 20,
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: _C.muted,
                    size: 19,
                  ),
                )
              : null,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final _Filter selected;
  final int jumlahSemua;
  final int jumlahTersedia;
  final int jumlahTidak;
  final ValueChanged<_Filter> onSelect;

  const _FilterRow({
    required this.selected,
    required this.jumlahSemua,
    required this.jumlahTersedia,
    required this.jumlahTidak,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _chip(
            label: 'Semua ($jumlahSemua)',
            active: selected == _Filter.semua,
            leading: Icons.grid_view_rounded,
            onTap: () => onSelect(_Filter.semua),
          ),
          const SizedBox(width: 8),
          _chip(
            label: 'Tersedia ($jumlahTersedia)',
            active: selected == _Filter.tersedia,
            dot: _C.green,
            onTap: () => onSelect(_Filter.tersedia),
          ),
          const SizedBox(width: 8),
          _chip(
            label: 'Tidak Tersedia ($jumlahTidak)',
            active: selected == _Filter.tidakTersedia,
            dot: _C.red,
            textColor: _C.red,
            onTap: () =>
                onSelect(_Filter.tidakTersedia),
          ),
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool active,
    required VoidCallback onTap,
    IconData? leading,
    Color? dot,
    Color? textColor,
  }) {
    final Color foregroundColor = active
        ? Colors.white
        : (textColor ?? _C.greenDark);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            gradient: active
                ? const LinearGradient(
                    colors: [
                      _C.greenDark,
                      Color(0xFF1B7F45),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: active ? null : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: active
                  ? _C.greenDark
                  : _C.border,
            ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: _C.greenDark.withOpacity(0.18),
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                Icon(
                  leading,
                  size: 16,
                  color: foregroundColor,
                ),
                const SizedBox(width: 6),
              ],
              if (dot != null) ...[
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: active ? Colors.white : dot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mulai dari kartu hingga bagian bawah tidak diubah.

class _PeralatanCard extends StatelessWidget {
  final Peralatan item;
  final VoidCallback onPilih;
  final VoidCallback onJadwal;

  const _PeralatanCard({
    required this.item,
    required this.onPilih,
    required this.onJadwal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 132,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _Foto(url: item.gambar),
                Positioned(
                  top: 8,
                  left: 8,
                  child: _StatusBadge(
                    tersedia: item.tersedia,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _C.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Stok: ${item.stok} Unit',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _C.greenDark,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: _C.muted,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        item.lokasi,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _C.muted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: item.tersedia
                ? _ActionButton(
                    label: 'Pilih',
                    trailing: Icons.arrow_forward,
                    filled: true,
                    onTap: onPilih,
                  )
                : _ActionButton(
                    label: 'Jadwal',
                    leading: Icons.visibility_outlined,
                    filled: false,
                    onTap: onJadwal,
                  ),
          ),
        ],
      ),
    );
  }
}

class _Foto extends StatelessWidget {
  final String? url;

  const _Foto({this.url});

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      color: const Color(0xFFE5E7EB),
      child: const Center(
        child: Icon(
          Icons.photo_camera_outlined,
          size: 40,
          color: Color(0xFF9CA3AF),
        ),
      ),
    );

    if (url == null) {
      return placeholder;
    }

    return Image.network(
      url!,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) =>
          progress == null ? child : placeholder,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool tersedia;

  const _StatusBadge({
    required this.tersedia,
  });

  @override
  Widget build(BuildContext context) {
    final color = tersedia ? _C.greenDark : _C.red;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: tersedia ? _C.greenSoft : _C.redSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            tersedia ? 'Tersedia' : 'Tidak Tersedia',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData? leading;
  final IconData? trailing;
  final bool filled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.filled,
    required this.onTap,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final fg = filled ? Colors.white : _C.blue;

    return SizedBox(
      width: double.infinity,
      height: 38,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: filled ? null : _C.blueSoft,
              gradient: filled
                  ? const LinearGradient(
                      colors: [
                        _C.greenDark,
                        Color(0xFF1B7F45),
                      ],
                    )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leading != null) ...[
                  Icon(
                    leading,
                    size: 16,
                    color: fg,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: TextStyle(
                    color: fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 6),
                  Icon(
                    trailing,
                    size: 16,
                    color: fg,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressInfo extends StatelessWidget {
  final int tampil;
  final int total;

  const _ProgressInfo({
    required this.tampil,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Menampilkan $tampil dari $total Peralatan',
          style: const TextStyle(
            fontSize: 12.5,
            color: _C.muted,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: total == 0 ? 0 : tampil / total,
            minHeight: 6,
            backgroundColor: const Color(0xFFDCE6F7),
            valueColor: const AlwaysStoppedAnimation(
              _C.greenDark,
            ),
          ),
        ),
      ],
    );
  }
}

class _LihatLainnya extends StatelessWidget {
  final VoidCallback onTap;

  const _LihatLainnya({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF3F8FF),
          foregroundColor: _C.greenDark,
          side: const BorderSide(
            color: _C.greenDark,
            width: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lihat Peralatan Lainnya',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 6),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 48,
            color: _C.muted,
          ),
          SizedBox(height: 8),
          Text(
            'Peralatan tidak ditemukan',
            style: TextStyle(
              color: _C.muted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}