// Penjelasan edukatif: Komponen UI yang dapat dipakai ulang agar tampilan dan interaksi antar layar tetap konsisten.

import 'package:flutter/material.dart';

import '../inti/warna_aplikasi.dart';

/// Keterangan kelas: CustomButton adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
