// Penjelasan edukatif: Sumber data lokal simulasi; class di sini menyediakan data contoh dan perubahan data tanpa server.
// Repository biasanya dipanggil layar, sedangkan sumber data lokal menyimpan sumber nilai simulasi.

import '../../model/ruangan.dart';
import '../../model/ruang.dart';

/// Keterangan kelas: LocalRuanganDataSource adalah class akses data yang memisahkan kebutuhan UI dari penyimpanan lokal.
class LocalRuanganDataSource {
  const LocalRuanganDataSource();

  List<Ruangan> getAll() => const [
    Ruangan(
      nama: 'Ruang Teater D301',
      lokasi: 'Gedung D • Lt. 3',
      kapasitas: 80,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_05_d4b40d7995.jpg',
    ),
    Ruangan(
      nama: 'Ruang Seminar C201',
      lokasi: 'Gedung C • Lt. 2',
      kapasitas: 60,
      tersedia: false,
      gambar: 'assets/images/foto_lokal_06_9d5ab13f64.jpg',
    ),
    Ruangan(
      nama: 'Ruang Rapat B105',
      lokasi: 'Gedung B • Lt. 1',
      kapasitas: 20,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_07_5b412f4a7d.jpg',
    ),
    Ruangan(
      nama: 'Lab Komputer A091',
      lokasi: 'Gedung A • Lt. 2',
      kapasitas: 40,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_08_5b3127fe5f.jpg',
    ),
    Ruangan(
      nama: 'Aula Serbaguna',
      lokasi: 'Gedung D • Lt. 1',
      kapasitas: 200,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_05_d4b40d7995.jpg',
    ),
    Ruangan(
      nama: 'Ruang Kelas B202',
      lokasi: 'Gedung B • Lt. 2',
      kapasitas: 50,
      tersedia: false,
      gambar: 'assets/images/foto_lokal_06_9d5ab13f64.jpg',
    ),
    Ruangan(
      nama: 'Lab Multimedia',
      lokasi: 'Gedung A • Lt. 2',
      kapasitas: 25,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_07_5b412f4a7d.jpg',
    ),
    Ruangan(
      nama: 'Ruang Diskusi C110',
      lokasi: 'Gedung C • Lt. 1',
      kapasitas: 12,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_08_5b3127fe5f.jpg',
    ),
  ];

  List<Ruangan> getAdditional() => const [
    Ruangan(
      nama: 'Ruang Kelas A102',
      lokasi: 'Gedung A • Lt. 1',
      kapasitas: 40,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_09_81d96e1cfa.jpg',
      lantai: 'Lt. 1',
      fasilitas: ['Proyektor'],
      ringkasanFasilitas: '40 Kursi • Proyektor',
    ),
    Ruangan(
      nama: 'Ruang Kelas A103',
      lokasi: 'Gedung A • Lt. 1',
      kapasitas: 36,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_10_c05a13b706.jpg',
      lantai: 'Lt. 1',
      fasilitas: ['Smart TV'],
      ringkasanFasilitas: '36 Kursi • Smart TV',
    ),
    Ruangan(
      nama: 'Lab Komputer',
      lokasi: 'Gedung C • Lt. 1',
      kapasitas: 35,
      tersedia: false,
      gambar: 'assets/images/foto_lokal_11_cea1e86e06.jpg',
      lantai: 'Lt. 1',
      fasilitas: ['PC', 'LAN High Speed'],
      ringkasanFasilitas: '35 PC • LAN High Speed',
    ),
    Ruangan(
      nama: 'Ruang Seminar B201',
      lokasi: 'Gedung B • Lt. 2',
      kapasitas: 90,
      tersedia: false,
      gambar: 'assets/images/foto_lokal_12_172d337c80.jpg',
      lantai: 'Lt. 2',
      fasilitas: ['Sound System'],
      ringkasanFasilitas: '90 Orang • Sound System',
    ),
    Ruangan(
      nama: 'Ruang Diskusi A301',
      lokasi: 'Gedung A • Lt. 3',
      kapasitas: 15,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_13_b1a77fd0b7.jpg',
      lantai: 'Lt. 3',
      fasilitas: ['Whiteboard'],
      ringkasanFasilitas: '15 Orang • Whiteboard',
    ),
    Ruangan(
      nama: 'Auditorium E101',
      lokasi: 'Gedung E • Lt. 1',
      kapasitas: 250,
      tersedia: false,
      gambar: 'assets/images/foto_lokal_14_5c0f11b092.jpg',
      lantai: 'Lt. 1',
      fasilitas: ['Panggung Utama'],
      dalamPerawatan: true,
      ringkasanFasilitas: '250 Kursi • Panggung Utama',
    ),
    Ruangan(
      nama: 'Studio Musik E102',
      lokasi: 'Gedung E • Lt. 1',
      kapasitas: 0,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_15_0033482eee.jpg',
      lantai: 'Lt. 1',
      fasilitas: ['Soundproof', 'Instrumen'],
      ringkasanFasilitas: 'Soundproof • Instrumen',
    ),
    Ruangan(
      nama: 'Ruang Rapat B301',
      lokasi: 'Gedung B • Lt. 3',
      kapasitas: 25,
      tersedia: true,
      gambar: 'assets/images/foto_lokal_16_957c2860cd.jpg',
      lantai: 'Lt. 3',
      fasilitas: ['Video Conf'],
      ringkasanFasilitas: '25 Kursi • Video Conf',
    ),
  ];

  List<String> getBuildings() => const [
    'Semua Gedung',
    'Gedung A',
    'Gedung B',
    'Gedung C',
    'Gedung D',
    'Gedung E',
  ];

  Room getDefaultDetailRoom() => const Room(
    name: 'Ruang Kelas 12.2',
    building: 'Gedung Tower A',
    floor: 12,
    capacity: 31,
    location: 'Gedung Akademik, Lt. 12',
    facilities: ['Proyektor', 'AC', 'PC', 'WiFi'],
    imageUrl: 'assets/images/foto_lokal_17_bef81e4286.jpg',
    available: true,
  );

  List<SessionSlot> getSessions() => const [
    SessionSlot(label: 'Sesi 1', time: '08:15 - 10:15', isFree: true),
    SessionSlot(label: 'Sesi 2', time: '10:30 - 12:30', isFree: false),
    SessionSlot(label: 'Sesi 3', time: '13:30 - 15:30', isFree: true),
  ];
}
