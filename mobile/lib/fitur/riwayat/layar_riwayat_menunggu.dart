import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/fitur/aksi/layar_pembatalan_pengajuan.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';
import 'package:my_sbum/fitur/riwayat/layar_detail_status_pengajuan.dart';

class _C {
  static const green = Color(0xFF1F8A4C);
  static const greenSoft = Color(0xFFE3F8EC);
  static const ink = Color(0xFF0F2D44);
  static const muted = Color(0xFF64748B);
  static const label = Color(0xFF94A3B8);
  static const chip = Color(0xFFF1F3F5);
  static const divider = Color(0xFFEDEFF2);
  static const background = Color(0xFFF8FAFC);
  static const amber = Color(0xFFE08A00);
  static const amberSoft = Color(0xFFFEF6DC);
  static const red = Color(0xFFE53935);
  static const redSoft = Color(0xFFFDECEC);
}

class MenungguScreen extends StatelessWidget {
  const MenungguScreen({super.key, this.record});

  final RequestRecord? record;

  @override
  Widget build(BuildContext context) {
    if (record != null) {
      return StatusRequestDetailScreen(record: record!);
    }
    final detail = const RequestRepositoryImpl().getSampleStatusDetail();

    return AppScaffold(
      showBackground: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: Container(
                color: _C.background,
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
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Foto ruangan
                          ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: Image.network(
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
                                  horizontal: 14,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: _C.amberSoft,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Color(0xFFF4A300),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Menunggu',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: _C.amber,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

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
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: _C.divider,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: _C.greenSoft,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.calendar_today_outlined,
                                        color: _C.green,
                                        size: 22,
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
                          const SizedBox(height: 16),

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
                                const SizedBox(height: 12),
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
                          const SizedBox(height: 16),

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
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Color(0xFFE9EDF2),
                                      child: Icon(
                                        Icons.person_outline_rounded,
                                        color: _C.muted,
                                        size: 24,
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
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: _C.ink,
                                            ),
                                          ),
                                          const SizedBox(height: 1),
                                          Text(
                                            detail.borrowerRole,
                                            style: const TextStyle(
                                              fontSize: 13.5,
                                              color: _C.muted,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text.rich(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol batal (tetap di bawah)
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () => CancelRequestDialog.show(
                      context,
                      requestId: detail.requestId,
                      ruangan: detail.title,
                      tanggal: detail.date,
                      waktu: detail.session,
                      pic: detail.borrower,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _C.redSoft,
                      foregroundColor: _C.red,
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Batalkan Pengajuan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header atas (tombol kembali, judul, avatar)
// ---------------------------------------------------------------------------
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F6F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 17,
                color: _C.ink,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Detail Ruangan',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: _C.ink,
              ),
            ),
          ),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE2E8F0),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
                ),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
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
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CardDivider extends StatelessWidget {
  const _CardDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14),
      child: Divider(height: 1, thickness: 1, color: _C.divider),
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

class _FacilityChip extends StatelessWidget {
  final String label;

  const _FacilityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _C.chip,
        borderRadius: BorderRadius.circular(12),
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
