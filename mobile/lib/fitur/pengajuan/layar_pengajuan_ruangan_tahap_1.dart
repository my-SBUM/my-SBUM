import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

class DetailRuanganPeminjamanScreen extends StatefulWidget {
  const DetailRuanganPeminjamanScreen({super.key});

  @override
  State<DetailRuanganPeminjamanScreen> createState() =>
      _DetailRuanganPeminjamanScreenState();
}

class _DetailRuanganPeminjamanScreenState
    extends State<DetailRuanganPeminjamanScreen> {
  // Awalnya kosong: pengguna harus memilih sendiri.
  DateTime? _tanggalPeminjaman;
  TimeOfDay? _jamMulai;
  TimeOfDay? _jamSelesai;

  static const Color _ink = Color(0xFF1E293B);
  static const Color _hint = Color(0xFF94A3B8);

  bool get _isLengkap =>
      _tanggalPeminjaman != null && _jamMulai != null && _jamSelesai != null;

  String _formatTanggal(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';

  String _formatJam(TimeOfDay time) =>
      '${time.hour.toString().padLeft(2, '0')}:'
      '${time.minute.toString().padLeft(2, '0')}';

  int _menit(TimeOfDay time) => time.hour * 60 + time.minute;

  // Tema hijau untuk pemilih tanggal & jam (menggantikan warna ungu default)
  Widget _temaHijau(BuildContext context, Widget? child) {
    const hijau = Color(0xFF0A6332);
    const hijauMuda = Color(0xFFDCFCE7);
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: hijau,
          onPrimary: Colors.white,
          primaryContainer: hijauMuda,
          onPrimaryContainer: hijau,
          secondary: hijau,
          secondaryContainer: hijauMuda,
          onSecondaryContainer: hijau,
          surface: Colors.white,
          onSurface: _ink,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: hijau),
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          dialHandColor: hijau,
          hourMinuteTextColor: WidgetStateColor.resolveWith(_warnaJamMenit),
          hourMinuteColor: WidgetStateColor.resolveWith(_latarJamMenit),
          dayPeriodTextColor: WidgetStateColor.resolveWith(_warnaJamMenit),
          dayPeriodColor: WidgetStateColor.resolveWith(_latarJamMenit),
          dayPeriodBorderSide: BorderSide(color: Color(0xFFE2E8F0)),
          entryModeIconColor: hijau,
        ),
      ),
      child: child!,
    );
  }

  static Color _warnaJamMenit(Set<WidgetState> states) =>
      states.contains(WidgetState.selected)
      ? const Color(0xFF0A6332)
      : const Color(0xFF1E293B);

  static Color _latarJamMenit(Set<WidgetState> states) =>
      states.contains(WidgetState.selected)
      ? const Color(0xFFDCFCE7)
      : const Color(0xFFF1F5F9);

  Future<void> _pilihTanggal() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final current = _tanggalPeminjaman;
    final selected = await showDatePicker(
      context: context,
      initialDate: (current == null || current.isBefore(today))
          ? today
          : current,
      firstDate: today,
      lastDate: DateTime(today.year + 2, today.month, today.day),
      builder: _temaHijau,
    );
    if (!mounted || selected == null) return;
    setState(() {
      _tanggalPeminjaman = DateTime(
        selected.year,
        selected.month,
        selected.day,
      );
    });
  }

  Future<void> _pilihJam({required bool mulai}) async {
    final current = mulai ? _jamMulai : _jamSelesai;
    final selected = await showTimePicker(
      context: context,
      initialTime: current ?? const TimeOfDay(hour: 8, minute: 0),
      builder: _temaHijau,
    );
    if (!mounted || selected == null) return;

    // Validasi urutan jam hanya jika jam yang lain sudah dipilih.
    final other = mulai ? _jamSelesai : _jamMulai;
    if (other != null) {
      final selectedMinutes = _menit(selected);
      final otherMinutes = _menit(other);
      if ((mulai && selectedMinutes >= otherMinutes) ||
          (!mulai && selectedMinutes <= otherMinutes)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Jam selesai harus setelah jam mulai.'),
          ),
        );
        return;
      }
    }

    setState(() {
      if (mulai) {
        _jamMulai = selected;
      } else {
        _jamSelesai = selected;
      }
    });
  }

  void _lanjut() {
    final previous = ModalRoute.of(context)?.settings.arguments;
    final arguments = previous is Map
        ? Map<String, dynamic>.from(previous)
        : <String, dynamic>{};
    arguments.addAll({
      'tanggal': _formatTanggal(_tanggalPeminjaman!),
      'jamMulai': _formatJam(_jamMulai!),
      'jamSelesai': _formatJam(_jamSelesai!),
    });
    Navigator.pushNamed(
      context,
      AppRoutes.pengajuanRuangTahap2,
      arguments: arguments,
    );
  }

  // Kolom pilihan (tanggal / jam) dengan placeholder saat masih kosong
  Widget _fieldPilihan({
    required String? value,
    required String placeholder,
    required IconData icon,
    required VoidCallback onTap,
    double verticalPadding = 10,
  }) {
    final isEmpty = value == null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? placeholder,
              style: TextStyle(
                fontSize: 16,
                color: isEmpty ? _hint : _ink,
                fontWeight: isEmpty ? FontWeight.w500 : FontWeight.w600,
              ),
            ),
            Icon(icon, color: const Color(0xFF64748B), size: 18),
          ],
        ),
      ),
    );
  }

  Widget _stepItem({
    required String number,
    required String label,
    required bool active,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: active ? const Color(0xFF0A6332) : const Color(0xFFE2E8F0),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: active ? Colors.white : const Color(0xFF475569),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: active ? _ink : const Color(0xFF64748B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lengkap = _isLengkap;

    return AppScaffold(
      showBackground: false,
      body: Stack(
        children: [
          const AppPageBackgroundLayer(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1F5F9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: _ink,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Detail Ruangan',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: _ink,
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF0A6332),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&q=80',
                              ),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Green strip
                  Container(
                    width: double.infinity,
                    height: 110,
                    color: const Color(0xFFD9F0E0),
                  ),

                  Transform.translate(
                    offset: const Offset(0, -44),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step indicator
                          Row(
                            children: [
                              _stepItem(
                                number: '1',
                                label: 'Cek Jadwal',
                                active: true,
                              ),
                              _stepItem(
                                number: '2',
                                label: 'Isi form',
                                active: false,
                              ),
                              _stepItem(
                                number: '3',
                                label: 'Konfirmasi',
                                active: false,
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Card detail
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    'https://images.unsplash.com/photo-1516321165247-4aa89a48be28?auto=format&fit=crop&w=800&q=80',
                                    width: 130,
                                    height: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 130,
                                        height: 120,
                                        color: Colors.grey.shade300,
                                        child: const Icon(
                                          Icons.image_not_supported,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'TA 12.2',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                          color: _ink,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Kode : MMX - 208',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFF64748B),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDCFCE7),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              radius: 6,
                                              backgroundColor: Color(
                                                0xFF16A34A,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Tersedia',
                                              style: TextStyle(
                                                color: Color(0xFF15803D),
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Pilih tanggal
                          const Text(
                            'Pilih Waktu Pengajuan :',
                            style: TextStyle(
                              fontSize: 16,
                              color: _ink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _fieldPilihan(
                            value: _tanggalPeminjaman == null
                                ? null
                                : _formatTanggal(_tanggalPeminjaman!),
                            placeholder: 'Pilih tanggal',
                            icon: Icons.calendar_today_rounded,
                            onTap: _pilihTanggal,
                            verticalPadding: 12,
                          ),

                          const SizedBox(height: 18),

                          // Jam Mulai dan Jam Selesai
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jam Mulai :',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _ink,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _fieldPilihan(
                                      value: _jamMulai == null
                                          ? null
                                          : _formatJam(_jamMulai!),
                                      placeholder: '--:--',
                                      icon: Icons.access_time_rounded,
                                      onTap: () => _pilihJam(mulai: true),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jam Selesai :',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _ink,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    _fieldPilihan(
                                      value: _jamSelesai == null
                                          ? null
                                          : _formatJam(_jamSelesai!),
                                      placeholder: '--:--',
                                      icon: Icons.access_time_rounded,
                                      onTap: () => _pilihJam(mulai: false),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Status box (berubah sesuai kelengkapan input)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: lengkap
                                  ? const Color(0xFFDCFCE7)
                                  : const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: lengkap
                                    ? const Color(0xFF82D8A6)
                                    : const Color(0xFFE2E8F0),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: lengkap
                                      ? const Color(0xFF16A34A)
                                      : _hint,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    lengkap
                                        ? 'Waktu pengajuan sudah dipilih'
                                        : 'Pilih tanggal dan jam pengajuan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: lengkap
                                          ? const Color(0xFF0A6332)
                                          : const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Button lanjut (aktif jika input sudah lengkap)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: lengkap ? _lanjut : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0A6332),
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: const Color(
                                  0xFFCBD5E1,
                                ),
                                disabledForegroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.arrow_forward_rounded, size: 22),
                                  SizedBox(width: 8),
                                  Text(
                                    'Lanjut isi form',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}