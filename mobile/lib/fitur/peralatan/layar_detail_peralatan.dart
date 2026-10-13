import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/navigasi_bawah_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_peralatan.dart';
import 'package:my_sbum/model/alat.dart';
import 'package:my_sbum/model/peralatan.dart';

/// ---------------------------------------------------------------------------
/// Warna
/// ---------------------------------------------------------------------------
class AppColors {
  static const green = Color(0xFF1F8A4C);
  static const greenSoft = Color(0xFFDDF7E6);
  static const ink = Color(0xFF0F2D44);
  static const muted = Color(0xFF64748B);
  static const mutedLight = Color(0xFF8A94A0);
  static const border = Color(0xFFE5E7EB);
  static const cardBorder = Color(0xFFDCEBF2);
  static const background = Color(0xFFF8FAFC);
  static const chip = Color(0xFFF1F3F5);
  static const danger = Color(0xFFDC2626);
  static const warning = Color(0xFFEA580C);
  static const bodyText = Color(0xFF4A4A24);
}

/// ---------------------------------------------------------------------------
/// ---------------------------------------------------------------------------
/// ---------------------------------------------------------------------------
/// Halaman Detail Peralatan
/// ---------------------------------------------------------------------------
class PeralatanDetailScreen extends StatefulWidget {
  const PeralatanDetailScreen({super.key, this.peralatan});

  final Peralatan? peralatan;

  @override
  State<PeralatanDetailScreen> createState() => _PeralatanDetailScreenState();
}

class _PeralatanDetailScreenState extends State<PeralatanDetailScreen> {
  final _repository = const PeralatanRepositoryImpl();

  Equipment get _equipment {
    final selected = widget.peralatan;
    if (selected == null) return _repository.getDefaultDetailItem();
    return Equipment(
      name: selected.nama,
      code: 'SBUM',
      stock: selected.stok,
      unit: 'Unit',
      location: selected.lokasi,
      completeness: const ['Periksa kelengkapan saat pengambilan.'],
      notice: _repository.getDefaultDetailItem().notice,
      imageUrl: selected.gambar ?? _repository.getDefaultDetailItem().imageUrl,
      available: selected.tersedia,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackground: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AppPageHeader(title: 'Detail Peralatan'),
            Expanded(
              child: Stack(
                children: [
                  // Blob hijau lembut di kanan atas
                  Positioned(
                    top: -50,
                    right: -70,
                    child: IgnorePointer(
                      child: Container(
                        width: 280,
                        height: 280,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [Color(0x4022C55E), Color(0x0022C55E)],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroImage(url: _equipment.imageUrl),
                        const SizedBox(height: 18),
                        _TitleRow(
                          title: _equipment.name,
                          subtitle: 'Kode Peralatan : ${_equipment.code}',
                          available: _equipment.available,
                        ),
                        const SizedBox(height: 18),
                        _InfoCard(equipment: _equipment),
                        const SizedBox(height: 16),
                        _ListCard(
                          icon: Icons.checklist_rounded,
                          iconColor: AppColors.green,
                          title: 'Kelengkapan',
                          items: _equipment.completeness,
                        ),
                        const SizedBox(height: 16),
                        _NoticeCard(
                          icon: Icons.warning_rounded,
                          iconColor: AppColors.warning,
                          title: 'Himbauan',
                          message: _equipment.notice,
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: !_equipment.available
                                ? null
                                : () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.pengajuanAlatTahap1,
                                    arguments: widget.peralatan,
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.green,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Ajukan Peminjaman',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
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
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 2,
        onTap: (index) => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (route) => false,
          arguments: index,
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Foto
/// ---------------------------------------------------------------------------
class _HeroImage extends StatelessWidget {
  final String url;

  const _HeroImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              color: AppColors.chip,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.green,
              ),
            );
          },
          errorBuilder: (context, error, stack) => Container(
            color: AppColors.chip,
            alignment: Alignment.center,
            child: const Icon(
              Icons.photo_camera_outlined,
              size: 48,
              color: AppColors.mutedLight,
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Nama + kode + badge status
/// ---------------------------------------------------------------------------
class _TitleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool available;

  const _TitleRow({
    required this.title,
    required this.subtitle,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = available ? AppColors.green : AppColors.danger;
    final statusBg = available ? AppColors.greenSoft : const Color(0xFFFEE2E2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: statusBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                available ? 'Tersedia' : 'Terpakai',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// Kartu info: stok + lokasi
/// ---------------------------------------------------------------------------
class _InfoCard extends StatelessWidget {
  final Equipment equipment;

  const _InfoCard({required this.equipment});

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            icon: Icons.people_outline_rounded,
            label: 'Stok Peralatan',
            value: '${equipment.stock} ${equipment.unit}',
          ),
          const _InfoDivider(),
          _InfoRow(
            icon: Icons.apartment_outlined,
            label: 'Lokasi',
            value: equipment.location,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: AppColors.green),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoDivider extends StatelessWidget {
  const _InfoDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, thickness: 1, color: Color(0xFFEDEFF2)),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Kartu daftar (Kelengkapan)
/// ---------------------------------------------------------------------------
class _ListCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<String> items;

  const _ListCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: icon, iconColor: iconColor, title: title),
          const SizedBox(height: 8),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(left: 34, top: 2, bottom: 2),
              child: Text(
                '• $item',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  color: AppColors.bodyText,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Kartu himbauan
/// ---------------------------------------------------------------------------
class _NoticeCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;

  const _NoticeCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(icon: icon, iconColor: iconColor, title: title),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.45,
                color: AppColors.bodyText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;

  const _CardTitle({
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 22, color: iconColor),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
        ),
      ],
    );
  }
}

/// Cangkang kartu putih bergaris tipis yang dipakai ulang.
class _CardShell extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _CardShell({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: child,
    );
  }
}
