import 'package:flutter/material.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_profil.dart';
import 'package:my_sbum/komponen/logo_aplikasi.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  static const Color _green = Color(0xFF0A6332);

  @override
  Widget build(BuildContext context) {
    // Foto diambil dari data profil yang sama dengan halaman Profil Saya
    final profile = const ProfileRepositoryImpl().getCurrentProfile();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const AppLogo(size: 46),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'my',
                  style: TextStyle(
                    color: _green,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    height: 1,
                  ),
                ),
                Text(
                  'SBUM',
                  style: TextStyle(
                    color: _green,
                    fontWeight: FontWeight.w900,
                    fontSize: 21,
                    height: 1.05,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ],
        ),

        Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF64D587), Color(0xFF20693B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.pushNamed(context, AppRoutes.profilSaya),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: ClipOval(
                    child: Image.network(
                      profile.avatarUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const ColoredBox(
                        color: Color(0xFFE2E8F0),
                        child: Icon(Icons.person, color: _green, size: 26),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
