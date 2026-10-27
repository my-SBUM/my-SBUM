// Penjelasan edukatif: Model data aplikasi; class di sini membawa nilai yang dipakai layar dan repository.

/// Keterangan kelas: Room adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class Room {
  final String name;
  final String building;
  final int floor;
  final int capacity;
  final String location;
  final List<String> facilities;
  final String imageUrl;
  final bool available;

  const Room({
    required this.name,
    required this.building,
    required this.floor,
    required this.capacity,
    required this.location,
    required this.facilities,
    required this.imageUrl,
    required this.available,
  });
}

/// Keterangan kelas: SessionSlot adalah class/widget utama yang menyediakan tanggung jawab sesuai file ini.
class SessionSlot {
  final String label;
  final String time;
  final bool isFree;

  const SessionSlot({
    required this.label,
    required this.time,
    required this.isFree,
  });
}
