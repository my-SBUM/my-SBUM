// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';

/// Keterangan kelas: IsiFoRuanganScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class IsiFoRuanganScreen extends StatefulWidget {
  const IsiFoRuanganScreen({
    super.key,
    this.initialDate,
    this.initialStartTime,
    this.initialEndTime,
  });

  final String? initialDate;
  final String? initialStartTime;
  final String? initialEndTime;

  @override
  State<IsiFoRuanganScreen> createState() => _IsiFoRuanganScreenState();
}

/// Keterangan kelas: _IsiFoRuanganScreenState adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _IsiFoRuanganScreenState extends State<IsiFoRuanganScreen> {
  final _repository = const RequestRepositoryImpl();
  late final List<String> _activities = _repository.getRoomActivities();
  late final List<String> _responsiblePeople = _repository
      .getResponsiblePeople();
  String _pilihanKegiatan = 'Pilih';
  String _pilihanPenanggungJawab = 'Pilih';
  late String _tanggalPeminjaman;
  late int _jamMulaiHour;
  late int _jamMulaiMinute;
  late int _jamSelesaiHour;
  late int _jamSelesaiMinute;
  int get _durasiJam =>
      ((_jamSelesaiHour * 60 +
                  _jamSelesaiMinute -
                  _jamMulaiHour * 60 -
                  _jamMulaiMinute) /
              60)
          .ceil();

  @override
  void initState() {
    super.initState();
    _tanggalPeminjaman = widget.initialDate ?? '12/04/2026';
    final start = _parseTime(widget.initialStartTime, 12, 30);
    final end = _parseTime(widget.initialEndTime, 14, 30);
    _jamMulaiHour = start.$1;
    _jamMulaiMinute = start.$2;
    _jamSelesaiHour = end.$1;
    _jamSelesaiMinute = end.$2;
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
                const AppPageHeader(title: 'Detail Ruangan'),
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
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0A6332),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Cek Jadwal',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1E293B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0A6332),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '2',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Isi form',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1E293B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE2E8F0),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                          color: Color(0xFF475569),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Konfirmasi',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF64748B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 26),

                        // Detail pengajuan section
                        const Text(
                          'Detail pengajuan',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E293B),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Pilih Kegiatan
                        const Text(
                          'Pilih Kegiatan:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _pilihanKegiatan,
                          items: _activities,
                          onChanged: (value) {
                            setState(() {
                              _pilihanKegiatan = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // Pilih Penanggung Jawab
                        const Text(
                          'Pilih penanggung Jawab :',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: _pilihanPenanggungJawab,
                          items: _responsiblePeople,
                          onChanged: (value) {
                            setState(() {
                              _pilihanPenanggungJawab = value;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // Tanggal Peminjaman
                        const Text(
                          'Tanggal Peminjaman:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            _tanggalPeminjaman,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF1E293B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Jam mulai dan selesai
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Jam mulai',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF1E293B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F1),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE2E8F0),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Text(
                                            _jamMulaiHour.toString().padLeft(
                                              2,
                                              '0',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF1E293B),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        ':',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F1),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE2E8F0),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Text(
                                            _jamMulaiMinute.toString().padLeft(
                                              2,
                                              '0',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF1E293B),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                                    'Jam selesai',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF1E293B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F1),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE2E8F0),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Text(
                                            _jamSelesaiHour.toString().padLeft(
                                              2,
                                              '0',
                                            ),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF1E293B),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        ':',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF1E293B),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F1),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFE2E8F0),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Text(
                                            _jamSelesaiMinute
                                                .toString()
                                                .padLeft(2, '0'),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF1E293B),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                                color: Color(0xFF0A6332),
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Total durasi peminjaman : $_durasiJam jam',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0A6332),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Keterangan
                        const Text(
                          'Keterangan',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1E293B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.2,
                            ),
                          ),
                          child: TextField(
                            minLines: 4,
                            maxLines: 6,
                            decoration: const InputDecoration(
                              hintText: 'Masukkan keterangan...',
                              hintStyle: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: OutlinedButton.icon(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFFC62828),
                                      width: 1.2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    size: 20,
                                    color: Color(0xFFC62828),
                                  ),
                                  label: const Text(
                                    'Kembali',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFC62828),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (_pilihanKegiatan == 'Pilih' ||
                                        _pilihanPenanggungJawab == 'Pilih') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Pilih kegiatan dan penanggung jawab.',
                                              ),
                                            ),
                                          );
                                      return;
                                    }
                                    final previous = ModalRoute.of(context)
                                        ?.settings
                                        .arguments;
                                    final arguments = previous is Map
                                        ? Map<String, dynamic>.from(previous)
                                        : <String, dynamic>{};
                                    arguments.addAll({
                                      'kegiatan': _pilihanKegiatan,
                                      'penanggungJawab':
                                          _pilihanPenanggungJawab,
                                      'tanggal': _tanggalPeminjaman,
                                      'jamMulai':
                                          '${_jamMulaiHour.toString().padLeft(2, '0')}:'
                                          '${_jamMulaiMinute.toString().padLeft(2, '0')}',
                                      'jamSelesai':
                                          '${_jamSelesaiHour.toString().padLeft(2, '0')}:'
                                          '${_jamSelesaiMinute.toString().padLeft(2, '0')}',
                                      'durasiJam': _durasiJam,
                                    });
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.pengajuanRuangTahap3,
                                      arguments: arguments,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0A6332),
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
                                    'Lanjut isi form',
                                    style: TextStyle(
                                      fontSize: 16,
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

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: const Icon(
            Icons.expand_more_rounded,
            color: Color(0xFF64748B),
            size: 24,
          ),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
        ),
      ),
    );
  }
}
