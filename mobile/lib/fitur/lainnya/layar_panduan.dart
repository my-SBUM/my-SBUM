// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

/// Keterangan kelas: PanduanScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class PanduanScreen extends StatelessWidget {
  const PanduanScreen({super.key});

  static const Color _textDark = Color(0xFF0F172A);
  static const Color _textLabel = Color(0xFF475569);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _green = Color(0xFF16A34A);
  static const Color _greenSoft = Color(0xFFDCFCE7);
  static const Color _chevron = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    final items = <_GuideItem>[
      _GuideItem(
        icon: Icons.home_outlined,
        title: 'Cara Meminjam Ruangan',
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.panduanMeminjamRuangan),
      ),
      _GuideItem(
        icon: Icons.desktop_windows_outlined,
        title: 'Cara Meminjam Peralatan',
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.panduanMeminjamPeralatan),
      ),
      _GuideItem(
        icon: Icons.description_outlined,
        title: 'Cara Mengajukan Peminjaman',
        onTap: () => Navigator.pushNamed(context, AppRoutes.panduanMengajukan),
      ),
      _GuideItem(
        icon: Icons.access_time_rounded,
        title: 'Cara Melihat Riwayat',
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.panduanMelihatRiwayat),
      ),
      _GuideItem(
        icon: Icons.delete_outline_rounded,
        title: 'Cara Membatalkan Peminjaman',
        onTap: () => Navigator.pushNamed(context, AppRoutes.panduanMembatalkan),
      ),
    ];

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
                const AppPageHeader(title: 'Panduan'),

                // ---------------- ISI ----------------
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                    children: [
                      const Text(
                        'PANDUAN PENGGUNAAN',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: _textLabel,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (int i = 0; i < items.length; i++) ...[
                        _GuideCard(item: items[i]),
                        if (i != items.length - 1) const SizedBox(height: 12),
                      ],
                    ],
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

/// Keterangan kelas: _GuideItem adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _GuideItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _GuideItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

/// Keterangan kelas: _GuideCard adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _GuideCard extends StatelessWidget {
  final _GuideItem item;

  const _GuideCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: item.onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: PanduanScreen._border, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: PanduanScreen._greenSoft,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(item.icon, color: PanduanScreen._green, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: PanduanScreen._textDark,
                    height: 1.4,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: PanduanScreen._chevron,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
