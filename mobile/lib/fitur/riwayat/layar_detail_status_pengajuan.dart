import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';

class StatusRequestDetailScreen extends StatelessWidget {
  const StatusRequestDetailScreen({super.key, required this.record});

  final RequestRecord record;

  @override
  Widget build(BuildContext context) {
    final (color, background, icon) = switch (record.status) {
      'Menunggu' => (
        const Color(0xFFB45309),
        const Color(0xFFFEF3C7),
        Icons.hourglass_top_rounded,
      ),
      'Diterima' => (
        const Color(0xFF047857),
        const Color(0xFFD1FAE5),
        Icons.check_circle_outline_rounded,
      ),
      'Ditolak' => (
        const Color(0xFFB91C1C),
        const Color(0xFFFEE2E2),
        Icons.cancel_outlined,
      ),
      _ => (
        const Color(0xFF475569),
        const Color(0xFFE2E8F0),
        Icons.info_outline_rounded,
      ),
    };

    return AppScaffold(
      showBackground: false,
      appBar: AppPageHeader(title: 'Detail ${record.status}'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 26),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        record.status,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  record.title,
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 18),
                _DetailRow(label: 'Nomor pengajuan', value: record.id),
                _DetailRow(label: 'Jadwal', value: record.date),
                _DetailRow(label: 'PIC / Keterangan', value: record.pic),
                if (record.reason != null && record.reason!.trim().isNotEmpty)
                  _DetailRow(label: 'Alasan penolakan', value: record.reason!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
