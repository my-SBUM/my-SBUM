import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_sbum/data/layanan/layanan_autentikasi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const auth = AuthService();

  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test(
    'login menyimpan sesi, restore memeriksa token, logout menghapus sesi',
    () async {
      final client = MockClient((request) async {
        if (request.url.path == '/api/login') {
          expect(request.bodyFields, {'identifier': '123', 'password': 'uji'});
          return http.Response('{"token":"token-uji"}', 200);
        }
        expect(request.headers['Authorization'], 'Bearer token-uji');
        if (request.url.path == '/api/me')
          return http.Response('{"name":"Uji"}', 200);
        expect(request.url.path, '/api/logout');
        return http.Response('', 204);
      });
      await http.runWithClient(() async {
        await auth.login(identifier: '123', password: 'uji');
        expect(await auth.restore(), isTrue);
        await auth.logout();
        expect(await auth.restore(), isFalse);
      }, () => client);
    },
  );

  test('sandi salah meninggalkan pengguna tanpa sesi', () async {
    await http.runWithClient(() async {
      await expectLater(
        auth.login(identifier: '123', password: 'salah'),
        throwsA(isA<AuthException>()),
      );
      expect(await auth.restore(), isFalse);
    }, () => MockClient((_) async => http.Response('{}', 401)));
  });
}
