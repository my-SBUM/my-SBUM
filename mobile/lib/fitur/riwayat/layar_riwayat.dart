// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/fitur/aksi/layar_pembatalan_pengajuan.dart';
import 'package:my_sbum/model/catatan_pengajuan.dart';
import 'package:my_sbum/komponen/bilah_atas_aplikasi.dart';
import 'package:my_sbum/komponen/latar_halaman_aplikasi.dart';

/// Keterangan kelas: RiwayatScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

/// Keterangan kelas: _RiwayatScreenState adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _RiwayatScreenState extends State<RiwayatScreen> {
  int _selectedFilterIndex = 0;
  String _searchQuery = '';

  // Warna Tema
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color secondaryGreen = Color(0xFF16A34A);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);
  static const Color backgroundColor = Color(0xFFF9F9F9);
  static const Color borderColor = Color(0xFFE2E8F0);

  final _repository = const RequestRepositoryImpl();
  late final List<String> _filters = _repository.getStatuses();
  late final List<RequestRecord> _riwayatList = _repository.getAll();

  // LOGIKA FILTER
  List<RequestRecord> get _filteredRiwayat {
    final selectedStatus = _selectedFilterIndex == 0
        ? null
        : _filters[_selectedFilterIndex];
    return _riwayatList.where((item) {
      return (selectedStatus == null || item.status == selectedStatus) &&
          _matchesSearch(item);
    }).toList();
  }

  bool _matchesSearch(RequestRecord item) {
    final query = _searchQuery.trim().toLowerCase();
    return query.isEmpty ||
        item.title.toLowerCase().contains(query) ||
        item.pic.toLowerCase().contains(query) ||
        item.id.toLowerCase().contains(query) ||
        item.status.toLowerCase().contains(query);
  }

  int _getCountForFilter(int index) {
    if (index == 0) {
      return _riwayatList.where(_matchesSearch).length;
    }

    final status = _filters[index];
    return _riwayatList
        .where((item) => item.status == status && _matchesSearch(item))
        .length;
  }

  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  void _openHistoryDetail(RequestRecord record) {
    final route = switch (record.status) {
      'Menunggu' => AppRoutes.riwayatMenunggu,
      'Diterima' => AppRoutes.riwayatDiterima,
      'Ditolak' => AppRoutes.riwayatDitolak,
      _ => null,
    };
    if (route == null) return;

    Navigator.pushNamed(context, route, arguments: record);
  }

  @override
  Widget build(BuildContext context) {
    final displayedRiwayat = _filteredRiwayat;

    return AppScaffold(
      showBackground: true,
      body: Stack(
        children: [
          const AppPageBackgroundLayer(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppHeader(),
                  const SizedBox(height: 24),

                  const Text(
                    'Riwayat Peminjaman',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: textDark,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Riwayat peminjaman ruang dan peralatan',
                    style: TextStyle(
                      fontSize: 13,
                      color: textGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 18),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: borderColor.withOpacity(0.8)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) =>
                          setState(() => _searchQuery = value),
                      style: const TextStyle(
                        fontSize: 14,
                        color: textDark,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: textGrey,
                          size: 22,
                        ),
                        hintText: 'Cari ruangan, peralatan, atau PIC...',
                        hintStyle: TextStyle(
                          color: textGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    height: 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filters.length,
                      itemBuilder: (context, index) {
                        final bool isSelected = _selectedFilterIndex == index;
                        final int itemCount = _getCountForFilter(index);

                        return Padding(
                          padding: const EdgeInsets.only(right: 9),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () => _onFilterSelected(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutCubic,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            primaryGreen,
                                            secondaryGreen,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                      : null,
                                  color: isSelected ? null : Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: isSelected
                                        ? primaryGreen
                                        : borderColor,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: primaryGreen.withOpacity(
                                              0.20,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (index == 0 && isSelected) ...[
                                      const Icon(
                                        Icons.library_books_outlined,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Text(
                                      _filters[index],
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : textGrey,
                                      ),
                                    ),
                                    if (isSelected) ...[
                                      const SizedBox(width: 7),
                                      Container(
                                        constraints: const BoxConstraints(
                                          minWidth: 21,
                                          minHeight: 20,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.22),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(
                                              0.12,
                                            ),
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          itemCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daftar Riwayat',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: textDark,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${displayedRiwayat.length} data',
                          style: const TextStyle(
                            fontSize: 11,
                            color: primaryGreen,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: displayedRiwayat.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            key: ValueKey(_selectedFilterIndex),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: displayedRiwayat.length,
                            itemBuilder: (context, index) {
                              return _buildHistoryCard(displayedRiwayat[index]);
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      key: ValueKey('empty-$_selectedFilterIndex'),
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 42),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history_rounded,
              size: 38,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Riwayat',
            style: TextStyle(
              color: textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Belum ada riwayat untuk status ini.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(RequestRecord data) {
    Color statusColor;
    Color statusBgColor;
    Widget statusIcon;

    if (data.status == 'Menunggu') {
      statusColor = const Color(0xFFD97706);
      statusBgColor = const Color(0xFFFEF3C7);
      statusIcon = const Icon(Icons.circle, size: 8, color: Color(0xFFD97706));
    } else if (data.status == 'Diterima') {
      statusColor = const Color(0xFF059669);
      statusBgColor = const Color(0xFFD1FAE5);
      statusIcon = const Icon(
        Icons.check_circle_outline,
        size: 14,
        color: Color(0xFF059669),
      );
    } else {
      statusColor = const Color(0xFFDC2626);
      statusBgColor = const Color(0xFFFEE2E2);
      statusIcon = const Icon(
        Icons.cancel_outlined,
        size: 14,
        color: Color(0xFFDC2626),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor.withOpacity(0.8)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.055),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: ValueKey('history-${data.id}'),
          onTap: () => _openHistoryDetail(data),
          child: Column(
            children: [
              Container(width: double.infinity, height: 4, color: statusColor),
              Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryGreen.withOpacity(0.14),
                                secondaryGreen.withOpacity(0.07),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: primaryGreen.withOpacity(0.08),
                            ),
                          ),
                          child: Icon(
                            data.isRoom
                                ? data.status == 'Ditolak'
                                      ? Icons.laptop_mac_outlined
                                      : Icons.meeting_room_outlined
                                : Icons.videocam_outlined,
                            color: primaryGreen,
                            size: 23,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: textDark,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'ID: ${data.id}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: textGrey,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: statusBgColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: statusColor.withOpacity(0.12),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              statusIcon,
                              const SizedBox(width: 4),
                              Text(
                                data.status,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: borderColor.withOpacity(0.7)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 16,
                                  color: primaryGreen,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    data.date,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                      fontWeight: FontWeight.w500,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: borderColor.withOpacity(0.7),
                          ),
                          const SizedBox(height: 9),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  data.reason != null
                                      ? Icons.error_outline_rounded
                                      : Icons.person_outline_rounded,
                                  size: 16,
                                  color: data.reason != null
                                      ? const Color(0xFFDC2626)
                                      : primaryGreen,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    data.pic,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: textGrey,
                                      fontWeight: FontWeight.w500,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (data.status == 'Menunggu')
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final canceled = await CancelRequestDialog.show(
                                  context,
                                  requestId: data.id,
                                );
                                if (canceled && mounted) {
                                  setState(() {
                                    final recordIndex = _riwayatList.indexWhere(
                                      (record) => record.id == data.id,
                                    );
                                    _riwayatList[recordIndex] = data.copyWith(
                                      status: 'Dibatalkan',
                                    );
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFEE2E2),
                                foregroundColor: const Color(0xFFDC2626),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Color(0xFFFECACA),
                                  ),
                                ),
                              ),
                              icon: const Icon(Icons.close_rounded, size: 18),
                              label: const Text(
                                'Batalkan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _openHistoryDetail(data),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD1FAE5),
                                foregroundColor: primaryGreen,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Color(0xFFA7F3D0),
                                  ),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lihat Detail',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.chevron_right_rounded, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (data.status == 'Diterima')
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _openHistoryDetail(data),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: primaryGreen.withOpacity(0.25),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 18,
                          ),
                          label: const Text(
                            'Lihat Detail Peminjaman',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    else if (data.status == 'Ditolak')
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _openHistoryDetail(data),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFEE2E2),
                            foregroundColor: const Color(0xFFDC2626),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(color: Color(0xFFFECACA)),
                            ),
                          ),
                          icon: const Icon(
                            Icons.info_outline_rounded,
                            size: 18,
                          ),
                          label: const Text(
                            'Lihat Detail Alasan',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
