import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_sbum/komponen/latar_aplikasi.dart';
import 'package:my_sbum/inti/rute/pengarah_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/sumber_data/sumber_data_notifikasi_lokal.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_pengajuan.dart';
import 'package:my_sbum/fitur/autentikasi/layar_masuk.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_peralatan.dart';
import 'package:my_sbum/model/ruangan.dart';
import 'package:my_sbum/fitur/ruangan/layar_detail_ruangan.dart';
import 'package:my_sbum/fitur/ruangan/layar_ruangan_lainnya.dart';
import 'package:my_sbum/fitur/ruangan/layar_ruangan.dart';
import 'package:my_sbum/data/repositori/implementasi_repositori_ruangan.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat_diterima.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat_ditolak.dart';
import 'package:my_sbum/fitur/riwayat/layar_riwayat_menunggu.dart';
import 'package:my_sbum/main.dart';

void main() {
  test('room repository retains the sample catalog', () {
    final rooms = const RuanganRepositoryImpl().getAll();

    expect(rooms, hasLength(8));
    expect(rooms.where((room) => room.tersedia), hasLength(6));
    expect(const RuanganRepositoryImpl().getAdditional(), hasLength(8));
  });

  test('equipment repository retains the sample catalog', () {
    final equipment = const PeralatanRepositoryImpl().getAll();

    expect(equipment, hasLength(8));
    expect(equipment.where((item) => item.tersedia), hasLength(6));
    expect(const PeralatanRepositoryImpl().getAdditional(), hasLength(8));
  });

  test('history and notification fixtures are provided by data sources', () {
    expect(const RequestRepositoryImpl().getAll(), hasLength(3));
    expect(
      const LocalNotificationDataSource().getAll().where(
        (notification) => notification.isNew,
      ),
      hasLength(2),
    );
  });

  testWidgets('app background loads platform-specific SVG assets', (
    WidgetTester tester,
  ) async {
    try {
      for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
        debugDefaultTargetPlatformOverride = platform;
        await tester.pumpWidget(
          const MaterialApp(home: AppBackground(child: SizedBox.expand())),
        );
        await tester.pumpAndSettle();

        expect(find.byType(SvgPicture), findsOneWidget);
        expect(tester.takeException(), isNull);
      }
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets('app opens on the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('named room route opens the room screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.ruangan,
        onGenerateRoute: AppRouter.generate,
      ),
    );

    expect(find.byType(RuanganScreen), findsOneWidget);
  });

  testWidgets('rejected history route shows rejected requests', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        initialRoute: AppRoutes.riwayatDitolak,
        onGenerateRoute: AppRouter.generate,
      ),
    );
    await tester.pump();

    expect(find.text('Riwayat Ditolak'), findsOneWidget);
    expect(find.text('Ruang Lab Komputer'), findsOneWidget);
    expect(find.textContaining('Alasan penolakan:'), findsOneWidget);
    expect(find.text('Ubah Password'), findsNothing);
  });

  testWidgets('history status filters stay on the list and filter records', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: const RiwayatScreen()));
    await tester.pump();

    await tester.tap(find.text('Diterima').first);
    await tester.pumpAndSettle();

    expect(find.text('Proyektor Epson LCI'), findsOneWidget);
    expect(find.text('Ruang Kelas A101'), findsNothing);
    expect(find.text('1 data'), findsOneWidget);
    expect(find.byType(RiwayatScreen), findsOneWidget);
  });

  testWidgets(
    'pending history detail opens the pending screen with its record',
    (WidgetTester tester) async {
      final record = const RequestRepositoryImpl().getAll().first;

      await tester.pumpWidget(
        MaterialApp(
          initialRoute: AppRoutes.riwayat,
          onGenerateRoute: AppRouter.generate,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(record.title));
      await tester.pumpAndSettle();

      expect(find.byType(MenungguScreen), findsOneWidget);
      expect(find.text('Detail Menunggu'), findsOneWidget);
      expect(find.text(record.title), findsOneWidget);
      expect(find.text(record.id), findsOneWidget);
      expect(find.text(record.pic), findsOneWidget);
    },
  );

  testWidgets(
    'history detail buttons navigate by status without changing filter',
    (WidgetTester tester) async {
      const details = {
        'Menunggu': (route: AppRoutes.riwayatMenunggu, button: 'Lihat Detail'),
        'Diterima': (
          route: AppRoutes.riwayatDiterima,
          button: 'Lihat Detail Peminjaman',
        ),
        'Ditolak': (
          route: AppRoutes.riwayatDitolak,
          button: 'Lihat Detail Alasan',
        ),
      };

      for (final record in const RequestRepositoryImpl().getAll()) {
        final detail = details[record.status]!;
        final observer = _RecordingNavigatorObserver();

        await tester.pumpWidget(
          MaterialApp(
            initialRoute: AppRoutes.riwayat,
            onGenerateRoute: AppRouter.generate,
            navigatorObservers: [observer],
          ),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.text(record.status).first);
        await tester.pumpAndSettle();
        await tester.ensureVisible(find.text(detail.button));
        await tester.tap(find.text(detail.button));
        await tester.pumpAndSettle();

        expect(observer.pushedRouteName, detail.route);
        expect(observer.pushedArguments, same(record));
        expect(find.text('Detail ${record.status}'), findsOneWidget);
        expect(find.text(record.title), findsOneWidget);

        Navigator.of(tester.element(find.text('Detail ${record.status}')))
            .pop();
        await tester.pumpAndSettle();

        expect(find.text('1 data'), findsOneWidget);
        expect(find.text(record.title), findsOneWidget);
        for (final otherRecord in const RequestRepositoryImpl().getAll()) {
          if (otherRecord.status != record.status) {
            expect(find.text(otherRecord.title), findsNothing);
          }
        }
      }
    },
  );

  testWidgets('history cards open their matching status detail screens', (
    WidgetTester tester,
  ) async {
    final records = const RequestRepositoryImpl().getAll();
    for (final record in records) {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: AppRoutes.riwayat,
          onGenerateRoute: AppRouter.generate,
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text(record.title));
      await tester.tap(find.text(record.title));
      await tester.pumpAndSettle();

      expect(find.text(record.title), findsOneWidget);
      expect(find.text('Detail ${record.status}'), findsOneWidget);
      switch (record.status) {
        case 'Menunggu':
          expect(find.byType(MenungguScreen), findsOneWidget);
        case 'Diterima':
          expect(find.byType(DiterimaScreen), findsOneWidget);
        case 'Ditolak':
          expect(find.byType(DitolakScreen), findsOneWidget);
      }
    }
  });

  testWidgets('room catalog filters, searches, sorts, and changes layout', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: RuanganLainnyaScreen()));
    await tester.pump();

    expect(find.text('Ruang Kelas A102'), findsOneWidget);
    expect(find.text('ruangan ditemukan'), findsOneWidget);

    await tester.ensureVisible(find.text('Gedung B'));
    await tester.tap(find.text('Gedung B'));
    await tester.pump();
    expect(find.text('Ruang Seminar B201'), findsOneWidget);
    expect(find.text('Ruang Rapat B301'), findsOneWidget);
    expect(find.text('Ruang Kelas A102'), findsNothing);
    expect(find.text('2 ruangan ditemukan'), findsOneWidget);

    await tester.ensureVisible(find.text('Semua Gedung'));
    await tester.tap(find.text('Semua Gedung'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Auditorium');
    await tester.pump();
    expect(find.text('Auditorium E101'), findsOneWidget);
    expect(find.text('1 ruangan ditemukan'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Urutkan: Kapasitas').last);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<DropdownButton<String>>(find.byType(DropdownButton<String>))
          .value,
      'Kapasitas',
    );
    expect(
      tester.getTopLeft(find.text('Auditorium E101')).dy,
      lessThan(tester.getTopLeft(find.text('Ruang Kelas A102')).dy),
    );

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Urutkan: Nama').last);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<DropdownButton<String>>(find.byType(DropdownButton<String>))
          .value,
      'Nama',
    );
    expect(
      tester.getTopLeft(find.text('Ruang Kelas A102')).dy,
      lessThan(tester.getTopLeft(find.text('Ruang Seminar B201')).dy),
    );

    await tester.tap(find.byIcon(Icons.grid_view_rounded));
    await tester.pump();
    expect(find.byType(GridView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('room detail lets users continue without selecting a session', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: RuanganDetailScreen(
          ruangan: const Ruangan(
            nama: 'Ruang Kelas untuk Kegiatan dan Pertemuan Kampus',
            lokasi: 'Gedung A',
            kapasitas: 30,
            tersedia: true,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('Sesi Jadwal Hari Ini'), findsNothing);

    final requestButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Ajukan Peminjaman'),
    );
    expect(requestButton.onPressed, isNotNull);
    expect(tester.takeException(), isNull);
  });
}

class _RecordingNavigatorObserver extends NavigatorObserver {
  String? pushedRouteName;
  Object? pushedArguments;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRouteName = route.settings.name;
    pushedArguments = route.settings.arguments;
  }
}
