import 'package:flutter/material.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key});

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  // Warna Tema
  static const Color primaryGreen = Color(0xFF2E9451);
  static const Color greenDark = Color(0xFF0A6332);
  static const Color greenSoft = Color(0xFFC9F0D6);
  static const Color red = Color(0xFFC62828);
  static const Color redSoft = Color(0xFFFFD6D6);
  static const Color blueSoft = Color(0xFFDDE8FA);
  static const Color blue = Color(0xFF1E3A8A);
  static const Color bg = Color(0xFFF8FAFC);
  static const Color text = Color(0xFF1E293B);
  static const Color muted = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);

  // Data notifikasi
  late List<NotifikasiItem> notifikasi;

  @override
  void initState() {
    super.initState();
    notifikasi = [
      NotifikasiItem(
        id: '1',
        icon: Icons.check_circle_rounded,
        iconBg: const Color(0xFFDCFCE7),
        iconColor: primaryGreen,
        title: 'Peminjaman Ruangan Diterima',
        subtitle:
            'Pengajuan peminjaman Ruang Lab Komputer A091 anda telah disetujui oleh PIC.',
        waktu: '2 jam yang lalu',
        status: StatusNotifikasi.baru,
        borderColor: const Color(0xFF9FE4B5),
        dotColor: primaryGreen,
        cardBg: const Color(0xFFF0FDF4),
        isNew: true,
      ),
      NotifikasiItem(
        id: '2',
        icon: Icons.notifications_active_rounded,
        iconBg: const Color(0xFFE0F2FE),
        iconColor: const Color(0xFF3B82F6),
        title: 'Pengingat Pengembalian',
        subtitle:
            'Batas akhir peminjaman Proyektor Epson tinggal 2 jam lagi. Mohon segera dikembalikan.',
        waktu: '3 jam yang lalu',
        status: StatusNotifikasi.baru,
        borderColor: const Color(0xFF9AC7FF),
        dotColor: const Color(0xFF3B82F6),
        cardBg: const Color(0xFFF7FBFF),
        isNew: true,
      ),
      NotifikasiItem(
        id: '3',
        icon: Icons.close_rounded,
        iconBg: redSoft,
        iconColor: red,
        title: 'Peminjaman Peralatan Ditolak',
        subtitle:
            'Maaf, pengajuan peminjaman Kamera DSLR Canon ditolak karena kuota penuh.',
        waktu: 'Kemarin',
        status: StatusNotifikasi.ditolak,
        borderColor: border,
        dotColor: red,
        cardBg: Colors.white,
        isNew: false,
      ),
      NotifikasiItem(
        id: '4',
        icon: Icons.check_circle_rounded,
        iconBg: const Color(0xFFDCFCE7),
        iconColor: primaryGreen,
        title: 'Peminjaman Ruang Rapat Selesai',
        subtitle:
            'Terima kasih telah mengembalikan kunci Ruang Rapat Utama tepat waktu.',
        waktu: '20 Mar 2027',
        status: StatusNotifikasi.selesai,
        borderColor: border,
        dotColor: primaryGreen,
        cardBg: Colors.white,
        isNew: false,
      ),
    ];
  }

  // Hitung jumlah notifikasi baru
  int get jumlahBaru => notifikasi.where((n) => n.isNew).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // Background header image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE8F5E9).withOpacity(0.5),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.02),
                        bg.withOpacity(0.10),
                        bg,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dekorasi lengkung hijau di pojok kanan atas
          Positioned(
            top: -90,
            right: -80,
            child: Container(
              width: 300,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFD7F2E0), Color(0x00D7F2E0)],
                ),
              ),
            ),
          ),

          // Header putih dengan tombol kembali
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    // Tombol kembali dengan background bulat
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          borderRadius: BorderRadius.circular(22),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: text,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Judul halaman
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notifikasi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: text,
                              letterSpacing: -0.3,
                            ),
                          ),
                          if (jumlahBaru > 0)
                            Text(
                              '$jumlahBaru notifikasi baru',
                              style: const TextStyle(
                                fontSize: 12,
                                color: muted,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Konten daftar notifikasi
          SafeArea(
            child: notifikasi.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off_rounded,
                          size: 64,
                          color: muted.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada notifikasi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: muted,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 80, 16, 24),
                    itemCount: notifikasi.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _NotificationCard(
                          item: notifikasi[index],
                          onTap: () => _handleNotifikasiTap(notifikasi[index]),
                          onDismiss: () =>
                              _handleDismiss(notifikasi[index].id),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Handle ketika notifikasi di-tap
  void _handleNotifikasiTap(NotifikasiItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} - ${item.waktu}'),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        backgroundColor: greenDark,
      ),
    );
  }

  // Handle dismiss notifikasi
  void _handleDismiss(String id) {
    setState(() {
      notifikasi.removeWhere((n) => n.id == id);
    });
  }
}

// Model untuk Notifikasi
enum StatusNotifikasi { baru, ditolak, selesai }

class NotifikasiItem {
  final String id;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String waktu;
  final StatusNotifikasi status;
  final Color borderColor;
  final Color dotColor;
  final Color cardBg;
  final bool isNew;

  NotifikasiItem({
    required this.id,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.waktu,
    required this.status,
    required this.borderColor,
    required this.dotColor,
    required this.cardBg,
    required this.isNew,
  });
}

// Widget Notifikasi Card
class _NotificationCard extends StatefulWidget {
  final NotifikasiItem item;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const _NotificationCard({
    required this.item,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  State<_NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<_NotificationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _dismissController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _dismissController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(
      CurvedAnimation(parent: _dismissController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _dismissController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _dismissController.dispose();
    super.dispose();
  }

  void _handleDismiss() {
    _dismissController.forward().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
              decoration: BoxDecoration(
                color: widget.item.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.item.borderColor,
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
              child: Stack(
                children: [
                  // Indikator status baru
                  if (widget.item.isNew)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: widget.item.dotColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.item.dotColor.withOpacity(0.4),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Konten utama
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: widget.item.iconBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.item.iconColor.withOpacity(0.15),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          widget.item.icon,
                          color: widget.item.iconColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Teks
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.item.title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF1E293B),
                                      height: 1.25,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.item.subtitle,
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.45,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.item.waktu,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    const Color(0xFF64748B).withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tombol dismiss
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: GestureDetector(
                          onTap: _handleDismiss,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 16,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
