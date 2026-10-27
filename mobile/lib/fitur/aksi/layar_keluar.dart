// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';

/// Keterangan kelas: _C adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _C {
  static const red = Color(0xFFEF4444);
  static const redSoft = Color(0xFFFEE2E2);
  static const ink = Color(0xFF0F172A);
  static const muted = Color(0xFF475569);
  static const cancelBg = Color(0xFFF1F5F9);
  static const cancelBorder = Color(0xFFE2E8F0);
}

/// Keterangan kelas: LogoutDialogPage adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class LogoutDialogPage extends StatelessWidget {
  const LogoutDialogPage({super.key});

  static Future<void> showAndLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (_) => const LogoutDialogPage(),
    );
    if (shouldLogout == true && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ikon keluar
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: _C.redSoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.logout_rounded, color: _C.red, size: 28),
            ),
            const SizedBox(height: 18),

            // Judul
            const Text(
              'Keluar Aplikasi?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _C.ink,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 10),

            // Deskripsi
            const Text(
              'Apakah Anda yakin ingin keluar\ndari akun SPARA Anda?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: _C.muted, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Tombol
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: _C.cancelBg,
                        foregroundColor: _C.muted,
                        side: const BorderSide(color: _C.cancelBorder),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: FilledButton.styleFrom(
                        backgroundColor: _C.red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Keluar',
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
    );
  }
}
