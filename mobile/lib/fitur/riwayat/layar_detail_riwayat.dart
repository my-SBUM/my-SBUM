import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';
import 'package:my_sbum/fitur/aksi/layar_pembatalan_pengajuan.dart';

class HistoryDetailScreen extends StatelessWidget {
  const HistoryDetailScreen({super.key, required this.record});

  final RequestRecord record;

  @override
  Widget build(BuildContext context) {
    final isPending = record.status == 'Menunggu';
    final isRejected = record.status == 'Ditolak';
    return AppScaffold(
      showBackground: false,
      appBar: const AppPageHeader(title: 'Detail Pengajuan'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(record.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          _detail('Nomor pengajuan', record.id),
          _detail('Tanggal', record.date),
          _detail('PIC', record.pic),
          _detail('Status', record.status),
          if (record.reason != null) _detail('Alasan', record.reason!),
          if (isPending)
            FilledButton(
              onPressed: () =>
                  CancelRequestDialog.show(context, requestId: record.id),
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Batalkan Pengajuan'),
            ),
          if (isRejected)
            FilledButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
                arguments: 1,
              ),
              child: const Text('Cari Ruangan Lain'),
            ),
        ],
      ),
    );
  }

  Widget _detail(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 130, child: Text(label)),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
