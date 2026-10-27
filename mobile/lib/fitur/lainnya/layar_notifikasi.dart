// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/data/model/catatan_notifikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_notifikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

/// Keterangan kelas: NotifikasiScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const NotificationRepositoryImpl().getAll();

    int newCount = items.where((item) => item.isNew).length;

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
                const AppPageHeader(title: 'Notifikasi'),

                // CONTENT
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 18),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'AKTIVITAS NOTIFIKASI',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDBF7E5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$newCount belum dibaca',
                                style: const TextStyle(
                                  color: Color(0xFF0A6332),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Expanded(
                          child: ListView.separated(
                            itemCount: items.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = items[index];

                              return NotificationTile(item: item);
                            },
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

/// Keterangan kelas: NotificationTile adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class NotificationTile extends StatelessWidget {
  final NotificationRecord item;

  const NotificationTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final icon = switch (item.kind) {
      NotificationKind.success => Icons.check_circle_rounded,
      NotificationKind.reminder => Icons.notifications_active_rounded,
      NotificationKind.rejected => Icons.close_rounded,
    };
    final iconColor = switch (item.kind) {
      NotificationKind.success => const Color(0xFF2E9451),
      NotificationKind.reminder => const Color(0xFF3B82F6),
      NotificationKind.rejected => const Color(0xFFE53935),
    };
    final iconBackground = switch (item.kind) {
      NotificationKind.success => const Color(0xFFDCFCE7),
      NotificationKind.reminder => const Color(0xFFE0F2FE),
      NotificationKind.rejected => const Color(0xFFFFE2E2),
    };
    final borderColor = item.isNew
        ? switch (item.kind) {
            NotificationKind.success => const Color(0xFF9DE2B2),
            NotificationKind.reminder => const Color(0xFF9CCBFF),
            NotificationKind.rejected => const Color(0xFFE2E8F0),
          }
        : const Color(0xFFE2E8F0);
    final cardColor = item.isNew ? const Color(0xFFF7FCF9) : Colors.white;
    final actionLabel = item.action.replaceAll('_', ' ').toUpperCase();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item.isNew ? borderColor : const Color(0xFFE2E8F0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0F2D44),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
              border: Border.all(color: iconColor.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: iconColor, size: 23),
          ),
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
                        item.object,
                        style: const TextStyle(
                          color: Color(0xFF0F2D44),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          height: 1.25,
                        ),
                      ),
                    ),
                    if (item.isNew)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 8, top: 5),
                        decoration: BoxDecoration(
                          color: iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _NotificationBadge(
                      icon: Icons.bolt_rounded,
                      label: actionLabel,
                      color: iconColor,
                      background: iconBackground,
                    ),
                    _NotificationBadge(
                      icon: Icons.badge_outlined,
                      label: item.actor,
                      color: const Color(0xFF64748B),
                      background: const Color(0xFFF1F5F9),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  item.message,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 13,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.timestamp,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  const _NotificationBadge({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
