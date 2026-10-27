// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/gambar_aplikasi.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';

/// Keterangan kelas: _C adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _C {
  static const green = Color(0xFF1F8A4C);
  static const greenDark = Color(0xFF0A6332);
  static const greenSoft = Color(0xFFE3F8EC);
  static const ink = Color(0xFF0F2D44);
  static const muted = Color(0xFF64748B);
  static const label = Color(0xFF94A3B8);
  static const chip = Color(0xFFF1F5F9);
  static const divider = Color(0xFFEDEFF2);
  static const badgeBg = Color(0xFFE6F8EC);
}

/// Keterangan kelas: DiterimaScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class DiterimaScreen extends StatelessWidget {
  const DiterimaScreen({super.key, this.record});

  final RequestRecord? record;

  @override
  Widget build(BuildContext context) {
    final detail = const RequestRepositoryImpl().getSampleStatusDetail();

    return AppScaffold(
      showBackground: true,
      body: Stack(
        children: [
          // Latar halaman
          const AppPageBackgroundLayer(),
          SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: [
                // Header aplikasi
                const AppPageHeader(title: 'Detail Ruangan'),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Foto ruangan
                        ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: AppImage(
                            detail.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                width: double.infinity,
                                color: _C.chip,
                                child: const Icon(
                                  Icons.meeting_room_outlined,
                                  size: 48,
                                  color: _C.label,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Judul + badge status
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    detail.title,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w800,
                                      color: _C.ink,
                                      height: 1.2,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    detail.building,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: _C.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: _C.badgeBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: _C.greenDark,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Diterima',
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: _C.greenDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),

                        // Kartu ID pengajuan + sesi
                        _Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID PENGAJUAN: ${detail.displayId}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: _C.label,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: _C.divider,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: _C.greenSoft,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.calendar_today_outlined,
                                      color: _C.green,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detail.session,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: _C.ink,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          detail.date,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: _C.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Kartu kapasitas, lokasi, fasilitas
                        _Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _InfoRow(
                                icon: Icons.people_outline_rounded,
                                label: 'Kapasitas',
                                value: detail.capacity,
                              ),
                              const _CardDivider(),
                              _InfoRow(
                                icon: Icons.apartment_outlined,
                                label: 'Lokasi',
                                value: detail.location,
                              ),
                              const _CardDivider(),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.checklist_rounded,
                                    size: 24,
                                    color: _C.green,
                                  ),
                                  SizedBox(width: 14),
                                  Text(
                                    'Fasilitas Ruangan',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: _C.muted,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 38),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (final facility in detail.facilities)
                                      _FacilityChip(label: facility),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Kartu informasi peminjam
                        _Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Informasi Peminjam',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: _C.ink,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Color(0xFFEEF1F5),
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      color: _C.muted,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detail.borrower,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: _C.ink,
                                          ),
                                        ),
                                        const SizedBox(height: 1),
                                        Text(
                                          detail.borrowerRole,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: _C.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Keperluan: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: _C.muted,
                                        ),
                                      ),
                                      TextSpan(
                                        text: detail.purpose,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: _C.ink,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: const TextStyle(fontSize: 14.5),
                                ),
                              ),
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
}

// ---------------------------------------------------------------------------
// Komponen bersama
// ---------------------------------------------------------------------------
/// Keterangan kelas: _Card adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }
}

/// Keterangan kelas: _CardDivider adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Divider(height: 1, thickness: 1, color: _C.divider),
    );
  }
}

/// Keterangan kelas: _InfoRow adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
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
        Icon(icon, size: 24, color: _C.green),
        const SizedBox(width: 14),
        Text(label, style: const TextStyle(fontSize: 15, color: _C.muted)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: _C.ink,
            ),
          ),
        ),
      ],
    );
  }
}

/// Keterangan kelas: _FacilityChip adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _FacilityChip extends StatelessWidget {
  final String label;

  const _FacilityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: _C.chip,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: _C.ink,
        ),
      ),
    );
  }
}
