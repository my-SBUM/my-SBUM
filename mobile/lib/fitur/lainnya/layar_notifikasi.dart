import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/data/model/catatan_notifikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_notifikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

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
                        const SizedBox(height: 12),

                        // AKTIVITAS TERBARU
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'AKTIVITAS TERBARU',
                              style: TextStyle(
                                fontSize: 13,
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
                                '$newCount Baru',
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
                            separatorBuilder: (_, __) =>
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
    final cardColor = item.isNew
        ? switch (item.kind) {
            NotificationKind.success => const Color(0xFFE9F9EF),
            NotificationKind.reminder => const Color(0xFFF4FAFF),
            NotificationKind.rejected => Colors.white,
          }
        : Colors.white;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon status
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: iconColor.withOpacity(0.35),
                width: 1.4,
              ),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),

          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${item.title}\n',
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        height: 1.3,
                      ),
                    ),
                    TextSpan(
                      text: item.message,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // dot new
          if (item.isNew)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
