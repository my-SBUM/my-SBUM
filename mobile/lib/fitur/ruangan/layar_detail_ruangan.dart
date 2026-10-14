import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/navigasi_bawah_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_ruangan.dart';
import 'package:my_sbum/model/ruangan.dart';
import 'package:my_sbum/model/ruang.dart';

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
  static const background = Color(0xFFF8FAFC);
  static const chip = Color(0xFFF1F3F5);
  static const danger = Color(0xFFDC2626);
}

/// ---------------------------------------------------------------------------
/// ---------------------------------------------------------------------------
/// ---------------------------------------------------------------------------
/// Halaman Detail Ruangan
/// ---------------------------------------------------------------------------
class RuanganDetailScreen extends StatelessWidget {
  const RuanganDetailScreen({super.key, this.ruangan});

  final Ruangan? ruangan;

  final _repository = const RuanganRepositoryImpl();

  Room get _room {
    final selected = ruangan;
    if (selected == null) return _repository.getDefaultDetailRoom();
    return Room(
      name: selected.nama,
      building: selected.lokasi,
      floor: 0,
      capacity: selected.kapasitas,
      location: selected.lokasi,
      facilities: const ['AC', 'WiFi'],
      imageUrl: selected.gambar ?? _repository.getDefaultDetailRoom().imageUrl,
      available: selected.tersedia,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                const AppPageHeader(title: 'Detail Ruangan'),
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
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroImage(url: _room.imageUrl),
                            const SizedBox(height: 18),
                            _TitleRow(room: _room),
                            const SizedBox(height: 18),
                            _InfoCard(room: _room),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: !_room.available
                          ? null
                          : () => Navigator.pushNamed(
                              context,
                              AppRoutes.pengajuanRuangTahap1,
                              arguments: {'ruangan': ruangan},
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
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: 1,
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
/// Foto ruangan
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
              Icons.meeting_room_outlined,
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
/// Nama ruangan + badge status
/// ---------------------------------------------------------------------------
class _TitleRow extends StatelessWidget {
  final Room room;

  const _TitleRow({required this.room});

  @override
  Widget build(BuildContext context) {
    final statusColor = room.available ? AppColors.green : AppColors.danger;
    final statusBg = room.available
        ? AppColors.greenSoft
        : const Color(0xFFFEE2E2);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.name,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${room.building} • Lantai ${room.floor}',
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
                room.available ? 'Tersedia' : 'Terpakai',
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
/// Kartu info: kapasitas, lokasi, fasilitas
/// ---------------------------------------------------------------------------
class _InfoCard extends StatelessWidget {
  final Room room;

  const _InfoCard({required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDCEBF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRow(
            icon: Icons.people_outline_rounded,
            label: 'Kapasitas',
            value: '${room.capacity} Orang',
          ),
          const _InfoDivider(),
          _InfoRow(
            icon: Icons.apartment_outlined,
            label: 'Lokasi',
            value: room.location,
          ),
          const _InfoDivider(),
          Row(
            children: [
              const Icon(
                Icons.checklist_rounded,
                size: 22,
                color: AppColors.green,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Fasilitas Ruangan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.muted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: room.facilities
                .map((f) => _FacilityChip(label: f))
                .toList(),
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

class _FacilityChip extends StatelessWidget {
  final String label;

  const _FacilityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.chip,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
        ),
      ),
    );
  }
}
