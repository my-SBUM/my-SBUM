import 'package:flutter/material.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';

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
    return AlertDialog(
      icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 48),
      title: const Text('Keluar Aplikasi?'),
      content: const Text('Apakah Anda yakin ingin keluar dari akun mySBUM?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Batal'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Keluar'),
        ),
      ],
    );
  }
}
