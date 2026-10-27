// Penjelasan edukatif: Konfigurasi navigasi aplikasi; rute dipetakan ke layar dan pengarah meneruskan perpindahan halaman.

import 'package:flutter/material.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/fitur/autentikasi/layar_masuk.dart';
import 'package:my_sbum/fitur/splash/layar_splash.dart';
import 'package:my_sbum/fitur/autentikasi/layar_daftar.dart';
import 'package:my_sbum/fitur/autentikasi/layar_lupa_kata_sandi.dart';
import 'package:my_sbum/fitur/beranda/layar_beranda.dart';
import 'package:my_sbum/fitur/peralatan/layar_detail_peralatan.dart';
import 'package:my_sbum/fitur/peralatan/layar_peralatan.dart';
import 'package:my_sbum/fitur/peralatan/layar_peralatan_lainnya.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat_diterima.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat_menunggu.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat_ditolak.dart';
import 'package:my_sbum/fitur/lainnya/layar_panduan_peralatan.dart';
import 'package:my_sbum/fitur/lainnya/layar_artikel_panduan.dart';
import 'package:my_sbum/fitur/lainnya/layar_panduan.dart';
import 'package:my_sbum/fitur/lainnya/layar_panduan_riwayat.dart';
import 'package:my_sbum/fitur/lainnya/layar_lainnya.dart';
import 'package:my_sbum/fitur/lainnya/layar_notifikasi.dart';
import 'package:my_sbum/fitur/lainnya/layar_panduan_pengajuan.dart';
import 'package:my_sbum/fitur/profil/layar_ubah_kata_sandi.dart';
import 'package:my_sbum/fitur/profil/layar_profil.dart';
import 'package:my_sbum/fitur/ruangan/layar_ruangan_lainnya.dart';
import 'package:my_sbum/fitur/ruangan/layar_detail_ruangan.dart';
import 'package:my_sbum/fitur/ruangan/layar_ruangan.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_peralatan_tahap_1.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_peralatan_tahap_2.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_peralatan_tahap_3.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_ruangan_tahap_1.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_ruangan_tahap_2.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_ruangan_tahap_3.dart';
import 'package:my_sbum/fitur/pengajuan/layar_pengajuan_berhasil.dart';
import 'package:my_sbum/model/ruangan.dart';
import 'package:my_sbum/model/peralatan.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';

/// Keterangan kelas: AppRouter adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppRouter {
  AppRouter._();

  static Route<dynamic> generate(RouteSettings settings) {
    final Widget? page = switch (settings.name) {
      AppRoutes.splash => const SplashScreen(),
      AppRoutes.login => const LoginScreen(),
      AppRoutes.register => const RegisterScreen(),
      AppRoutes.lupaPassword => const ForgotPasswordScreen(),
      AppRoutes.home => HomeScreen(
        initialTab: settings.arguments is int ? settings.arguments! as int : 0,
      ),
      AppRoutes.ruangan => const RuanganScreen(),
      AppRoutes.ruanganDetail => RuanganDetailScreen(
        ruangan: settings.arguments is Ruangan
            ? settings.arguments! as Ruangan
            : null,
      ),
      AppRoutes.ruanganLainnya => const RuanganLainnyaScreen(),
      AppRoutes.peralatan => const PeralatanScreen(),
      AppRoutes.peralatanDetail => PeralatanDetailScreen(
        peralatan: settings.arguments is Peralatan
            ? settings.arguments! as Peralatan
            : null,
      ),
      AppRoutes.peralatanLainnya => const PeralatanLainnyaScreen(),
      AppRoutes.pengajuanRuangTahap1 => const DetailRuanganPeminjamanScreen(),
      AppRoutes.pengajuanRuangTahap2 => IsiFoRuanganScreen(
        initialDate: _argumentString(settings.arguments, 'tanggal'),
        initialStartTime: _argumentString(settings.arguments, 'jamMulai'),
        initialEndTime: _argumentString(settings.arguments, 'jamSelesai'),
      ),
      AppRoutes.pengajuanRuangTahap3 => const KonfirmasiPengajuanScreen(),
      AppRoutes.pengajuanAlatTahap1 => const DetailPeralatanCekJadwalScreen(),
      AppRoutes.pengajuanAlatTahap2 => IsiFoPeralatanScreen(
        initialDate: _argumentString(settings.arguments, 'tanggal'),
        initialStartTime: _argumentString(settings.arguments, 'jamMulai'),
        initialEndTime: _argumentString(settings.arguments, 'jamSelesai'),
      ),
      AppRoutes.pengajuanAlatTahap3 =>
        const KonfirmasiPengajuanPeralatanScreen(),
      AppRoutes.pengajuanBerhasil => const RequestSuccessScreen(),
      AppRoutes.riwayat => const RiwayatScreen(),
      AppRoutes.riwayatMenunggu => MenungguScreen(
        record: settings.arguments is RequestRecord
            ? settings.arguments! as RequestRecord
            : null,
      ),
      AppRoutes.riwayatDiterima => DiterimaScreen(
        record: settings.arguments is RequestRecord
            ? settings.arguments! as RequestRecord
            : null,
      ),
      AppRoutes.riwayatDitolak => DitolakScreen(
        record: settings.arguments is RequestRecord
            ? settings.arguments! as RequestRecord
            : null,
      ),
      AppRoutes.lainnya => const LainnyaScreen(),
      AppRoutes.notifikasi => const NotifikasiScreen(),
      AppRoutes.panduan => const PanduanScreen(),
      AppRoutes.panduanMeminjamRuangan => const GuideArticleScreen(
        type: GuideArticleType.roomBooking,
      ),
      AppRoutes.panduanMeminjamPeralatan => const CaraMeminjamPeralatanScreen(),
      AppRoutes.panduanMengajukan => const CaraMengajukanPeminjamanScreen(),
      AppRoutes.panduanMelihatRiwayat => const CaraMelihatRiwayatScreen(),
      AppRoutes.panduanMembatalkan => const GuideArticleScreen(
        type: GuideArticleType.cancellation,
      ),
      AppRoutes.profilSaya => const ProfilSayaScreen(),
      AppRoutes.ubahPassword => const UbahPasswordScreen(),
      _ => null,
    };

    if (page == null) {
      return _page(
        Scaffold(
          appBar: AppBar(title: const Text('Tidak ditemukan')),
          body: Center(
            child: Text('Halaman "${settings.name}" tidak ditemukan'),
          ),
        ),
        settings,
      );
    }

    return _page(page, settings);
  }

  static PageRoute<dynamic> _page(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (_, _, _) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (_, _, _, child) => child,
    );
  }

  static String? _argumentString(Object? arguments, String key) {
    if (arguments is Map && arguments[key] is String) {
      return arguments[key] as String;
    }
    return null;
  }
}
