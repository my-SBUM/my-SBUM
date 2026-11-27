import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_sbum/fitur/autentikasi/layar_masuk.dart';

void main() {
  testWidgets('kolom login menampilkan kesalahan dan memeriksa perbaikan', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    final masuk = find.text('MASUK');
    final identitas = find.byType(TextField).first;
    final sandi = find.byType(TextField).last;
    expect(find.text('Masukkan kata sandi.'), findsNothing);
    await tester.ensureVisible(masuk);
    await tester.tap(masuk);
    await tester.pumpAndSettle();
    expect(find.text('Masukkan NIM/NIP atau email.'), findsOneWidget);
    expect(find.text('Masukkan kata sandi.'), findsOneWidget);
    expect(tester.widget<TextField>(identitas).focusNode!.hasFocus, isTrue);

    await tester.enterText(identitas, 'nama@');
    await tester.pump();
    expect(find.textContaining('Periksa format email'), findsOneWidget);
    await tester.enterText(identitas, 'nama@kampus.ac.id');
    await tester.pump();
    expect(tester.widget<TextField>(identitas).decoration!.errorText, isNull);
    await tester.enterText(identitas, '1234567890');
    await tester.enterText(sandi, 'uji');
    await tester.pump();
    expect(tester.widget<TextField>(identitas).decoration!.errorText, isNull);
    expect(tester.widget<TextField>(sandi).decoration!.errorText, isNull);
  });
}
