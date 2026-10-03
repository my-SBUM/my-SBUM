import 'package:flutter/material.dart';

class PanduanScreen extends StatelessWidget {
  const PanduanScreen({super.key});

  // Warna Tema Utama (Diselaraskan dengan aplikasi)
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color iconBgGreen = Color(0xFFDCFCE7); // Hijau sangat muda untuk kotak ikon
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF475569);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF1F5F9), // Abu-abu terang untuk tombol back
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: textDark),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Panduan',
          style: TextStyle(
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true, // Agar background bisa naik sampai ke bawah AppBar
      body: Stack(
        children: [
          // 1. Latar Belakang Gambar (Wave/Gelombang)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE8F5E9).withOpacity(0.3),
                );
              },
            ),
          ),

          // 2. Konten Utama
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER SECTION ---
                  const Text(
                    'PANDUAN PENGGUNAAN',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: textGrey,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- LIST PANDUAN CARDS ---
                  _buildGuideCard(
                    icon: Icons.home_outlined,
                    title: 'Cara Meminjam Ruangan',
                    onTap: () {
                      // Tindakan saat diklik
                    },
                  ),
                  _buildGuideCard(
                    icon: Icons.desktop_windows_outlined,
                    title: 'Cara Meminjam Peralatan',
                    onTap: () {
                      // Tindakan saat diklik
                    },
                  ),
                  _buildGuideCard(
                    icon: Icons.description_outlined,
                    title: 'Cara Mengajukan Peminjaman',
                    onTap: () {
                      // Tindakan saat diklik
                    },
                  ),
                  _buildGuideCard(
                    icon: Icons.access_time,
                    title: 'Cara Melihat Riwayat',
                    onTap: () {
                      // Tindakan saat diklik
                    },
                  ),
                  _buildGuideCard(
                    icon: Icons.delete_outline,
                    title: 'Cara Membatalkan\nPeminjaman', // Teks multi-baris agar sesuai desain
                    onTap: () {
                      // Tindakan saat diklik
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: KARTU PANDUAN ---
  Widget _buildGuideCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2), // Border abu-abu tipis
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.015),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ikon Kotak dengan Latar Hijau Muda
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: primaryGreen, // Warna hijau tua untuk ikon
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            
            // Judul Panduan
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                  height: 1.3,
                ),
              ),
            ),
            
            // Panah Kanan
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF94A3B8), // Abu-abu ikon chevron
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}