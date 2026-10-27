// Penjelasan edukatif: Konfigurasi navigasi aplikasi; rute dipetakan ke layar dan pengarah meneruskan perpindahan halaman.

/// Keterangan kelas: AppRoutes adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class AppRoutes {
  AppRoutes._();

  // ---------------- SPLASH ----------------
  static const String splash = '/splash';

  // ---------------- AUTH ----------------
  static const String login = '/login';
  static const String register = '/register';
  static const String lupaPassword = '/lupa-password';

  // ---------------- HOME ----------------
  static const String home = '/home';

  // ---------------- RUANGAN ----------------
  static const String ruangan = '/ruangan';
  static const String ruanganDetail = '/ruangan/detail';
  static const String ruanganLainnya = '/ruangan/lainnya';

  // ---------------- PERALATAN ----------------
  static const String peralatan = '/peralatan';
  static const String peralatanDetail = '/peralatan/detail';
  static const String peralatanLainnya = '/peralatan/lainnya';

  // ---------------- PENGAJUAN: RUANG ----------------
  static const String pengajuanRuangTahap1 = '/pengajuan/ruang/tahap1';
  static const String pengajuanRuangTahap2 = '/pengajuan/ruang/tahap2';
  static const String pengajuanRuangTahap3 = '/pengajuan/ruang/tahap3';

  // ---------------- PENGAJUAN: ALAT ----------------
  static const String pengajuanAlatTahap1 = '/pengajuan/alat/tahap1';
  static const String pengajuanAlatTahap2 = '/pengajuan/alat/tahap2';
  static const String pengajuanAlatTahap3 = '/pengajuan/alat/tahap3';
  static const String pengajuanBerhasil = '/pengajuan/berhasil';

  // ---------------- RIWAYAT ----------------
  static const String riwayat = '/riwayat';
  static const String riwayatMenunggu = '/riwayat/menunggu';
  static const String riwayatDiterima = '/riwayat/diterima';
  static const String riwayatDitolak = '/riwayat/ditolak';

  // ---------------- LAINNYA ----------------
  static const String lainnya = '/lainnya';
  static const String notifikasi = '/lainnya/notifikasi';

  // Panduan
  static const String panduan = '/lainnya/panduan';
  static const String panduanMeminjamRuangan =
      '/lainnya/panduan/meminjam-ruangan';
  static const String panduanMeminjamPeralatan =
      '/lainnya/panduan/meminjam-peralatan';
  static const String panduanMengajukan = '/lainnya/panduan/mengajukan';
  static const String panduanMelihatRiwayat =
      '/lainnya/panduan/melihat-riwayat';
  static const String panduanMembatalkan = '/lainnya/panduan/membatalkan';

  // ---------------- PROFIL ----------------
  static const String profilSaya = '/profil/saya';
  static const String ubahPassword = '/profil/ubah-password';

  // ---------------- AKSI ----------------
  static const String batalkan = '/aksi/batalkan';
  static const String keluar = '/aksi/keluar';
}
