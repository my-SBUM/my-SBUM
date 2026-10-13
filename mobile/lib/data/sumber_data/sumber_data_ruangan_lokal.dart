import '../../model/ruangan.dart';
import '../../model/ruang.dart';

class LocalRuanganDataSource {
  const LocalRuanganDataSource();

  List<Ruangan> getAll() => const [
    Ruangan(
      nama: 'Ruang Teater D301',
      lokasi: 'Gedung D • Lt. 3',
      kapasitas: 80,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=600',
    ),
    Ruangan(
      nama: 'Ruang Seminar C201',
      lokasi: 'Gedung C • Lt. 2',
      kapasitas: 60,
      tersedia: false,
      gambar: 'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?q=80&w=600',
    ),
    Ruangan(
      nama: 'Ruang Rapat B105',
      lokasi: 'Gedung B • Lt. 1',
      kapasitas: 20,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=600',
    ),
    Ruangan(
      nama: 'Lab Komputer A091',
      lokasi: 'Gedung A • Lt. 2',
      kapasitas: 40,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=600',
    ),
    Ruangan(
      nama: 'Aula Serbaguna',
      lokasi: 'Gedung D • Lt. 1',
      kapasitas: 200,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=600',
    ),
    Ruangan(
      nama: 'Ruang Kelas B202',
      lokasi: 'Gedung B • Lt. 2',
      kapasitas: 50,
      tersedia: false,
      gambar: 'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?q=80&w=600',
    ),
    Ruangan(
      nama: 'Lab Multimedia',
      lokasi: 'Gedung A • Lt. 2',
      kapasitas: 25,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=600',
    ),
    Ruangan(
      nama: 'Ruang Diskusi C110',
      lokasi: 'Gedung C • Lt. 1',
      kapasitas: 12,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=600',
    ),
  ];

  List<Ruangan> getAdditional() => const [
    Ruangan(
      nama: 'Ruang Kelas A102',
      lokasi: 'Gedung A • Lt. 1',
      kapasitas: 40,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1517502884422-41eaead166d4?q=80&w=400',
      lantai: 'Lt. 1',
      fasilitas: ['Proyektor'],
      ringkasanFasilitas: '40 Kursi • Proyektor',
    ),
    Ruangan(
      nama: 'Ruang Kelas A103',
      lokasi: 'Gedung A • Lt. 1',
      kapasitas: 36,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1541829070764-84a7d30dd3f3?q=80&w=400',
      lantai: 'Lt. 1',
      fasilitas: ['Smart TV'],
      ringkasanFasilitas: '36 Kursi • Smart TV',
    ),
    Ruangan(
      nama: 'Lab Komputer',
      lokasi: 'Gedung C • Lt. 1',
      kapasitas: 35,
      tersedia: false,
      gambar: 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=400',
      lantai: 'Lt. 1',
      fasilitas: ['PC', 'LAN High Speed'],
      ringkasanFasilitas: '35 PC • LAN High Speed',
    ),
    Ruangan(
      nama: 'Ruang Seminar B201',
      lokasi: 'Gedung B • Lt. 2',
      kapasitas: 90,
      tersedia: false,
      gambar: 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=400',
      lantai: 'Lt. 2',
      fasilitas: ['Sound System'],
      ringkasanFasilitas: '90 Orang • Sound System',
    ),
    Ruangan(
      nama: 'Ruang Diskusi A301',
      lokasi: 'Gedung A • Lt. 3',
      kapasitas: 15,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=400',
      lantai: 'Lt. 3',
      fasilitas: ['Whiteboard'],
      ringkasanFasilitas: '15 Orang • Whiteboard',
    ),
    Ruangan(
      nama: 'Auditorium E101',
      lokasi: 'Gedung E • Lt. 1',
      kapasitas: 250,
      tersedia: false,
      gambar: 'https://images.unsplash.com/photo-1511578314322-379afb476865?q=80&w=400',
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
      gambar: 'https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?q=80&w=400',
      lantai: 'Lt. 1',
      fasilitas: ['Soundproof', 'Instrumen'],
      ringkasanFasilitas: 'Soundproof • Instrumen',
    ),
    Ruangan(
      nama: 'Ruang Rapat B301',
      lokasi: 'Gedung B • Lt. 3',
      kapasitas: 25,
      tersedia: true,
      gambar: 'https://images.unsplash.com/photo-1497215728101-856f4ea42174?q=80&w=400',
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
    imageUrl: 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=1200&q=80',
    available: true,
  );

  List<SessionSlot> getSessions() => const [
    SessionSlot(label: 'Sesi 1', time: '08:15 - 10:15', isFree: true),
    SessionSlot(label: 'Sesi 2', time: '10:30 - 12:30', isFree: false),
    SessionSlot(label: 'Sesi 3', time: '13:30 - 15:30', isFree: true),
  ];
}
