// Penjelasan edukatif: Sumber data lokal simulasi; class di sini menyediakan data contoh dan perubahan data tanpa server.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/catatan_pengajuan.dart';
import '../../model/detail_riwayat.dart';

/// Keterangan kelas: LocalRequestDataSource adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class LocalRequestDataSource {
  const LocalRequestDataSource();

  List<RequestRecord> getAll() => const [
    RequestRecord(
      title: 'Ruang Kelas A101',
      id: '#REQ-2026-089',
      date: 'Senin, 21-09-2026 • 08:15 – 10:15 WIB',
      pic: 'Informatika • Andi Wijaya',
      status: 'Menunggu',
      isRoom: true,
    ),
    RequestRecord(
      title: 'Proyektor Epson LCI',
      id: '#EQP-2026-042',
      date: 'Selasa, 22-09-2026 • 13:00 – 15:30 WIB',
      pic: 'Sistem Informasi • Budi Santoso',
      status: 'Diterima',
      isRoom: false,
    ),
    RequestRecord(
      title: 'Ruang Lab Komputer',
      id: '#REQ-2026-077',
      date: 'Rabu, 23-09-2026 • 09:00 – 11:00 WIB',
      pic: 'Informatika • Jadwal Bentrok Kuliah Reguler',
      status: 'Ditolak',
      isRoom: true,
      reason: 'Informatika • Jadwal Bentrok Kuliah Reguler',
    ),
  ];

  RequestRecord getDashboardFeatured() => const RequestRecord(
    id: '#REQ-2026-091',
    title: 'Ruang Lab Komputer A091',
    date: 'Hari ini',
    pic: 'Laode Abdul Rahman',
    status: 'Diterima',
    isRoom: true,
  );

  List<String> getStatuses() => const [
    'Semua',
    'Menunggu',
    'Diterima',
    'Ditolak',
  ];

  List<String> getRoomActivities() => const [
    'Pilih',
    'Kuliah',
    'Seminar',
    'Workshop',
  ];

  List<String> getEquipmentActivities() => const [
    'Dokumentasi kegiatan kampus',
    'Penelitian',
    'Seminar',
    'Workshop',
  ];

  List<String> getResponsiblePeople() => const [
    'Pilih',
    'Budi Santoso',
    'Andi Wijaya',
    'Siti Nurhaliza',
    'Laode Abdul Rahman',
  ];

  List<String> getEquipmentUnitOptions() => const [
    '1 unit',
    '2 unit',
    '3 unit',
    '4 unit',
    '5 unit',
  ];

  HistoryDetail getSampleStatusDetail() => const HistoryDetail(
    displayId: '#SB-9021',
    requestId: '#REQ-2026-089',
    title: 'Ruang Kelas 12.2',
    building: 'Gedung Tower A • Lantai 12',
    session: 'Sesi 1 (08:15 – 10:15 WIB)',
    date: 'Senin, 21-09-2026',
    capacity: '31 Orang',
    location: 'Gedung Akademik, Lt. 12',
    facilities: ['Proyektor', 'AC', 'PC', 'WiFi'],
    borrower: 'Andi Wijaya',
    borrowerRole: 'Mahasiswa Informatika',
    purpose: 'Kuliah Pengganti Algoritma',
    imageUrl: 'assets/images/foto_lokal_02_53faffa46f.jpg',
  );
}
