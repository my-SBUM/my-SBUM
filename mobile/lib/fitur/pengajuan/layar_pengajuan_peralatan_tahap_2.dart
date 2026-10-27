// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/model/peralatan.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';

/// Keterangan kelas: IsiFoPeralatanScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class IsiFoPeralatanScreen extends StatefulWidget {
  const IsiFoPeralatanScreen({
    super.key,
    this.initialDate,
    this.initialStartTime,
    this.initialEndTime,
  });

  final String? initialDate;
  final String? initialStartTime;
  final String? initialEndTime;

  @override
  State<IsiFoPeralatanScreen> createState() => _IsiFoPeralatanScreenState();
}

/// Keterangan kelas: _IsiFoPeralatanScreenState adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _IsiFoPeralatanScreenState extends State<IsiFoPeralatanScreen> {
  static const Color _ink = Color(0xFF1E293B);
  static const Color _muted = Color(0xFF64748B);
  static const Color _green = Color(0xFF0A6332);
  static const Color _red = Color(0xFFC62828);
  static const Color _fieldBg = Color(0xFFF1F5F1);
  static const Color _fieldBorder = Color(0xFFE2E8F0);

  // Hanya sebagai salah satu pilihan di daftar, TIDAK dipilih otomatis.
  static const String _defaultPenanggungJawab = 'Laode Abdul Rahman';

  final _repository = const RequestRepositoryImpl();

  // Daftar pilihan: item ganda dan placeholder "Pilih" dibuang supaya
  // DropdownButton tidak error (nilai harus muncul tepat satu kali).
  late final List<String> _activities = _bersihkan(
    _repository.getEquipmentActivities().cast<String>(),
  );
  late final List<String> _responsiblePeople = _bersihkan([
    _defaultPenanggungJawab,
    ..._repository.getResponsiblePeople().cast<String>(),
  ]);
  late final List<String> _unitOptions = _bersihkan(
    _repository.getEquipmentUnitOptions().cast<String>(),
  );

  // Nilai terpilih. null = belum dipilih / tidak ada di daftar.
  String? _pilihanKegiatan;
  String? _pilihanPenanggungJawab;
  String? _jumlahUnit;

  late String _tanggalPeminjaman;
  late int _jamMulaiHour;
  late int _jamMulaiMinute;
  late int _jamSelesaiHour;
  late int _jamSelesaiMinute;

  final _keteranganController = TextEditingController();

  static List<String> _bersihkan(List<String> items) => items
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty && item != 'Pilih')
      .toSet()
      .toList();

  int get _durasiJam {
    final menit =
        _jamSelesaiHour * 60 +
        _jamSelesaiMinute -
        _jamMulaiHour * 60 -
        _jamMulaiMinute;
    return menit <= 0 ? 0 : (menit / 60).ceil();
  }

  @override
  void initState() {
    super.initState();
    _tanggalPeminjaman = widget.initialDate ?? '22/09/2026';
    final start = _parseTime(widget.initialStartTime, 12, 30);
    final end = _parseTime(widget.initialEndTime, 14, 30);
    _jamMulaiHour = start.$1;
    _jamMulaiMinute = start.$2;
    _jamSelesaiHour = end.$1;
    _jamSelesaiMinute = end.$2;
    // Kegiatan, penanggung jawab, dan jumlah unit sengaja dibiarkan kosong
    // (null) sampai pengguna memilih sendiri.
  }

  bool _argumenDibaca = false;

  // Membaca tanggal & jam yang dikirim dari halaman Cek Jadwal langsung dari
  // argumen rute, jadi tidak bergantung pada cara rute membuat layar ini.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_argumenDibaca) return;
    _argumenDibaca = true;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is! Map) return;

    final tanggal = args['tanggal']?.toString();
    if (tanggal != null && tanggal.isNotEmpty) {
      _tanggalPeminjaman = tanggal;
    }
    final mulai = _parseTime(
      args['jamMulai']?.toString(),
      _jamMulaiHour,
      _jamMulaiMinute,
    );
    final selesai = _parseTime(
      args['jamSelesai']?.toString(),
      _jamSelesaiHour,
      _jamSelesaiMinute,
    );
    _jamMulaiHour = mulai.$1;
    _jamMulaiMinute = mulai.$2;
    _jamSelesaiHour = selesai.$1;
    _jamSelesaiMinute = selesai.$2;
  }

  @override
  void dispose() {
    _keteranganController.dispose();
    super.dispose();
  }

  (int, int) _parseTime(String? value, int fallbackHour, int fallbackMinute) {
    final parts = value?.split(':');
    if (parts == null || parts.length != 2) {
      return (fallbackHour, fallbackMinute);
    }
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null ||
        hour < 0 ||
        hour > 23 ||
        minute == null ||
        minute < 0 ||
        minute > 59) {
      return (fallbackHour, fallbackMinute);
    }
    return (hour, minute);
  }

  String _dua(int value) => value.toString().padLeft(2, '0');

  void _lanjut() {
    if (_pilihanKegiatan == null ||
        _pilihanPenanggungJawab == null ||
        _jumlahUnit == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih kegiatan, penanggung jawab, dan jumlah unit.'),
        ),
      );
      return;
    }
    if (_durasiJam <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jam selesai harus setelah jam mulai.')),
      );
      return;
    }

    final previous = ModalRoute.of(context)?.settings.arguments;
    final arguments = previous is Map
        ? Map<String, dynamic>.from(previous)
        : <String, dynamic>{};
    if (previous is Peralatan) {
      arguments['peralatan'] = previous;
    }
    final keterangan = _keteranganController.text.trim();
    arguments.addAll({
      'kegiatan': _pilihanKegiatan,
      'penanggungJawab': _pilihanPenanggungJawab,
      'tanggal': _tanggalPeminjaman,
      'jamMulai': '${_dua(_jamMulaiHour)}:${_dua(_jamMulaiMinute)}',
      'jamSelesai': '${_dua(_jamSelesaiHour)}:${_dua(_jamSelesaiMinute)}',
      'durasiJam': _durasiJam,
      'jumlahUnit': _jumlahUnit,
      'keterangan': keterangan,
    });
    Navigator.pushNamed(
      context,
      AppRoutes.pengajuanAlatTahap3,
      arguments: arguments,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackground: true,
      body: Stack(
        children: [
          const AppPageBackgroundLayer(),
          SafeArea(
            top: false,
            child: Column(
              children: [
                const AppPageHeader(title: 'Detail Peralatan'),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Step indicator
                        Row(
                          children: [
                            _stepItem(
                              child: const Icon(
                                Icons.check_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                              label: 'Cek Jadwal',
                              active: true,
                            ),
                            _stepItem(
                              child: const Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              label: 'Isi form',
                              active: true,
                            ),
                            _stepItem(
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              label: 'Konfirmasi',
                              active: false,
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          'Detail pengajuan',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: _ink,
                          ),
                        ),

                        const SizedBox(height: 18),

                        _label('Pilih Kegiatan:'),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _pilihanKegiatan,
                          items: _activities,
                          onChanged: (value) =>
                              setState(() => _pilihanKegiatan = value),
                        ),

                        const SizedBox(height: 16),

                        _label('Pilih penanggung Jawab :'),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _pilihanPenanggungJawab,
                          items: _responsiblePeople,
                          onChanged: (value) =>
                              setState(() => _pilihanPenanggungJawab = value),
                        ),

                        const SizedBox(height: 16),

                        _label('Tanggal Peminjaman:'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          decoration: _fieldDecoration(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _tanggalPeminjaman,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: _muted,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(
                                Icons.calendar_today_rounded,
                                color: _muted,
                                size: 20,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Jam mulai dan selesai
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _jamBlok(
                                'Jam mulai',
                                _jamMulaiHour,
                                _jamMulaiMinute,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _jamBlok(
                                'Jam selesai',
                                _jamSelesaiHour,
                                _jamSelesaiMinute,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _label('Jumlah Unit:'),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _jumlahUnit,
                          items: _unitOptions,
                          onChanged: (value) =>
                              setState(() => _jumlahUnit = value),
                        ),

                        const SizedBox(height: 18),

                        // Duration info
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: _green,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Total durasi peminjaman · $_durasiJam jam',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        _label('Keterangan'),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: _fieldDecoration(12),
                          child: TextField(
                            controller: _keteranganController,
                            minLines: 3,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Tulis keterangan peminjaman...',
                              hintStyle: TextStyle(color: _muted, fontSize: 14),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(fontSize: 14, color: _ink),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 52,
                                child: OutlinedButton.icon(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: _red,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    size: 20,
                                    color: _red,
                                  ),
                                  label: const Text(
                                    'Kembali',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: _red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SizedBox(
                                height: 52,
                                child: ElevatedButton.icon(
                                  onPressed: _lanjut,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _green,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 20,
                                  ),
                                  label: const Text(
                                    'Lanjut',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Komponen kecil ----------

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      color: _ink,
      fontWeight: FontWeight.w600,
    ),
  );

  BoxDecoration _fieldDecoration(double radius) => BoxDecoration(
    color: _fieldBg,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: _fieldBorder, width: 1.2),
  );

  Widget _stepItem({
    required Widget child,
    required String label,
    required bool active,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: active ? _green : const Color(0xFFD1D5DB),
              shape: BoxShape.circle,
            ),
            child: Center(child: child),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: active ? _ink : const Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kotakWaktu(int value) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    decoration: _fieldDecoration(10),
    child: Text(
      _dua(value),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        color: _ink,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _jamBlok(String label, int jam, int menit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(label),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _kotakWaktu(jam)),
            const SizedBox(width: 8),
            const Text(
              ':',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _ink,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: _kotakWaktu(menit)),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _fieldDecoration(12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          // Aman: jika nilai tidak ada di daftar, tampilkan "Pilih".
          value: (value != null && items.contains(value)) ? value : null,
          hint: const Text(
            'Pilih',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
          icon: const Icon(Icons.expand_more_rounded, color: _muted, size: 24),
          style: const TextStyle(
            fontSize: 16,
            color: _muted,
            fontWeight: FontWeight.w600,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) onChanged(newValue);
          },
          items: items
              .map(
                (item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)),
              )
              .toList(),
        ),
      ),
    );
  }
}
