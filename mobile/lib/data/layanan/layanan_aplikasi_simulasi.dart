import 'dart:async';

class MockAppService {
  const MockAppService();

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // TODO: sambungkan ke API
  }

  Future<void> register({
    required String name,
    required String identifier,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // TODO: sambungkan ke API
  }

  Future<void> requestPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // TODO: sambungkan ke API
  }

  Future<void> submitRequest() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // TODO: sambungkan ke API
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // TODO: sambungkan ke API
  }

  Future<void> cancelRequest(String requestId) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    // TODO: sambungkan ke API
  }
}
