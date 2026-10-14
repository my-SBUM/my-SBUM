import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

enum GuideArticleType { roomBooking, cancellation }

class GuideArticleScreen extends StatelessWidget {
  const GuideArticleScreen({super.key, required this.type});

  final GuideArticleType type;

  static const Color _dark = Color(0xFF1E293B);
  static const Color _muted = Color(0xFF64748B);
  static const Color _border = Color(0xFFE2E8F0);
  static const Color _green = Color(0xFF0A6332);
  static const Color _greenSoft = Color(0xFFDCFCE7);
  static const Color _card = Color(0xFFF2F5F3);

  @override
  Widget build(BuildContext context) {
    final guide = switch (type) {
      GuideArticleType.roomBooking => _GuideContent(
        title: 'Cara Meminjam Ruangan',
        subtitle: 'Ikuti langkah berikut untuk memilih ruangan dan mengirim pengajuan peminjaman.',
        icon: Icons.meeting_room_outlined,
        steps: const [
          _GuideStep(
            title: 'Pilih ruangan',
            description: 'Buka menu Ruangan dan pilih ruangan yang dibutuhkan.',
          ),
          _GuideStep(
            title: 'Ajukan peminjaman',
            description: 'Ketuk Ajukan Peminjaman pada halaman detail ruangan.',
          ),
          _GuideStep(
            title: 'Pilih tanggal dan waktu',
            description: 'Pada tahap pertama pengajuan, tentukan tanggal, jam mulai, dan jam selesai. Jam selesai harus setelah jam mulai.',
          ),
          _GuideStep(
            title: 'Lengkapi dan kirim formulir',
            description: 'Isi kegiatan dan penanggung jawab, periksa kembali data, lalu kirim pengajuan.',
          ),
        ],
        note: 'Pantau status pengajuan melalui menu Riwayat setelah formulir dikirim.',
      ),
      GuideArticleType.cancellation => _GuideContent(
        title: 'Cara Membatalkan Peminjaman',
        subtitle: 'Batalkan pengajuan yang tidak jadi digunakan melalui halaman Riwayat.',
        icon: Icons.event_busy_outlined,
        steps: const [
          _GuideStep(
            title: 'Buka menu Riwayat',
            description: 'Pilih Riwayat pada navigasi utama untuk melihat pengajuan Anda.',
          ),
          _GuideStep(
            title: 'Pilih pengajuan yang menunggu',
            description: 'Cari pengajuan dengan status Menunggu, lalu buka detail pengajuannya.',
          ),
          _GuideStep(
            title: 'Pilih Batalkan Pengajuan',
            description:
                'Pada halaman detail, ketuk tombol Batalkan Pengajuan.',
          ),
          _GuideStep(
            title: 'Konfirmasi pembatalan',
            description: 'Periksa kembali pengajuan yang dipilih, lalu konfirmasi pembatalan.',
          ),
        ],
        note: 'Pembatalan tidak dapat dibatalkan kembali. Pastikan pengajuan yang dipilih sudah benar sebelum mengonfirmasi.',
        isWarning: true,
      ),
    };

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
                AppPageHeader(title: guide.title),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                    children: [
                      _buildIntroCard(guide),
                      const SizedBox(height: 26),
                      const Text(
                        'LANGKAH-LANGKAH',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _dark,
                        ),
                      ),
                      const SizedBox(height: 14),
                      for (var i = 0; i < guide.steps.length; i++) ...[
                        _buildStepCard(i + 1, guide.steps[i]),
                        if (i != guide.steps.length - 1)
                          const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 18),
                      _buildNote(guide),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroCard(_GuideContent guide) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border, width: 1.2),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: _greenSoft,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF8CD0A8), width: 1.2),
            ),
            child: Icon(guide.icon, color: _green, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guide.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _dark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  guide.subtitle,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _muted,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(int number, _GuideStep step) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _greenSoft,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _dark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  step.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _muted,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNote(_GuideContent guide) {
    final background = guide.isWarning ? const Color(0xFFFFF7ED) : _greenSoft;
    final foreground = guide.isWarning ? const Color(0xFF9A3412) : _green;
    final iconBackground = guide.isWarning
        ? const Color(0xFFFFEDD5)
        : const Color(0xFFBEE7C9);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              guide.isWarning
                  ? Icons.info_outline_rounded
                  : Icons.check_rounded,
              size: 18,
              color: foreground,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              guide.note,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: foreground,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideContent {
  const _GuideContent({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.steps,
    required this.note,
    this.isWarning = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<_GuideStep> steps;
  final String note;
  final bool isWarning;
}

class _GuideStep {
  const _GuideStep({required this.title, required this.description});

  final String title;
  final String description;
}
