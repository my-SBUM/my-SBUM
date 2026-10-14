import 'package:flutter/material.dart';
import 'package:my_sbum/data/layanan/layanan_aplikasi_simulasi.dart';

class CancelRequestDialog {
  const CancelRequestDialog._();

  static const Color _red = Color(0xFFD60812);
  static const Color _redSoft = Color(0xFFFCE8E8);
  static const Color _textDark = Color(0xFF1F1F1F);
  static const Color _textGrey = Color(0xFF757575);
  static const Color _border = Color(0xFFE5E7EB);
  static const Color _detailBg = Color(0xFFF9FAFC);

  /// Menampilkan dialog konfirmasi pembatalan.
  ///
  /// [ruangan], [tanggal], [waktu], dan [pic] bersifat opsional.
  /// Kartu detail hanya tampil untuk data yang diisi.
  static Future<bool> show(
    BuildContext context, {
    required String requestId,
    String? ruangan,
    String? tanggal,
    String? waktu,
    String? pic,
  }) async {
    final details = <MapEntry<String, String>>[
      if (ruangan != null) MapEntry('Ruangan', ruangan),
      if (tanggal != null) MapEntry('Tanggal', tanggal),
      if (waktu != null) MapEntry('Waktu', waktu),
      if (pic != null) MapEntry('PIC', pic),
    ];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: _border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1F000000),
                blurRadius: 32,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ikon peringatan
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: _redSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.warning_amber_rounded,
                    color: _red,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 18),

                // Judul
                const Text(
                  'Batalkan peminjaman?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _textDark,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),

                // Deskripsi
                const Text(
                  'Pastikan Anda ingin membatalkan peminjaman ini sebelum '
                  'melanjutkan. Aksi ini tidak dapat dibatalkan.',
                  style: TextStyle(fontSize: 15, height: 1.5, color: _textGrey),
                ),

                // Kartu detail peminjaman
                if (details.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: _detailBg,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _border),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < details.length; i++) ...[
                          if (i > 0) const SizedBox(height: 14),
                          _DetailRow(
                            label: details[i].key,
                            value: details[i].value,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 22),

                // Tombol aksi
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SizedBox(
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext, false),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF555555),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: _border, width: 1.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: const Text(
                            'Tidak',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 13,
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _red,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                          child: const Text(
                            'Batalkan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (confirmed != true) return false;

    try {
      await const MockAppService().cancelRequest(requestId);
      if (!context.mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengajuan berhasil dibatalkan.')),
      );
      return true;
    } catch (error) {
      if (!context.mounted) return false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pembatalan gagal: $error')));
      return false;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            color: CancelRequestDialog._textGrey,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: CancelRequestDialog._textDark,
            ),
          ),
        ),
      ],
    );
  }
}
