import 'package:flutter/material.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/fitur/riwayat/layar_detail_status_pengajuan.dart';

class DitolakScreen extends StatelessWidget {
  const DitolakScreen({super.key, this.record});

  final RequestRecord? record;

  static const Color _ink = Color(0xFF1E293B);
  static const Color _muted = Color(0xFF64748B);
  static const Color _red = Color(0xFFB91C1C);
  static const Color _redSoft = Color(0xFFFEE2E2);
  static const Color _border = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    if (record != null) {
      return StatusRequestDetailScreen(record: record!);
    }
    final rejectedRequests = const RequestRepositoryImpl()
        .getAll()
        .where((request) => request.status == 'Ditolak')
        .toList();

    return AppScaffold(
      showBackground: false,
      appBar: AppBar(
        title: const Text('Riwayat Ditolak'),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: rejectedRequests.isEmpty
          ? const Center(child: Text('Belum ada pengajuan yang ditolak.'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                for (final request in rejectedRequests)
                  _RejectedRequestCard(request: request),
              ],
            ),
    );
  }
}

class _RejectedRequestCard extends StatelessWidget {
  const _RejectedRequestCard({required this.request});

  final RequestRecord request;

  @override
  Widget build(BuildContext context) {
    final reason = request.reason;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: DitolakScreen._border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  request.title,
                  style: const TextStyle(
                    color: DitolakScreen._ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: DitolakScreen._redSoft,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Ditolak',
                  style: TextStyle(
                    color: DitolakScreen._red,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            request.id,
            style: const TextStyle(color: DitolakScreen._muted, fontSize: 13),
          ),
          const SizedBox(height: 5),
          Text(
            request.date,
            style: const TextStyle(color: DitolakScreen._muted, fontSize: 13),
          ),
          if (reason != null && reason.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7F7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: DitolakScreen._redSoft),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Alasan penolakan: ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: reason),
                  ],
                ),
                style: const TextStyle(
                  color: DitolakScreen._red,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
