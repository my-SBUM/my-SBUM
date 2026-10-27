// Penjelasan edukatif: Layar fitur aplikasi; widget membangun UI, state menyimpan perubahan sementara, dan aksi pengguna memicu navigasi atau repository.
// Pemula dapat mengikuti alur dari build() ke callback interaksi, lalu melihat perubahan state atau perpindahan rute.

import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/inti/rute/rute_aplikasi.dart';
import 'package:my_sbum/data/layanan/layanan_aplikasi_simulasi.dart';
import 'package:my_sbum/komponen/logo_aplikasi.dart';

/// Keterangan kelas: LoginScreen adalah widget layar yang menjadi titik interaksi pengguna dan dapat meneruskan navigasi.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

/// Keterangan kelas: _LoginScreenState adalah widget/helper internal untuk menyusun bagian kecil UI atau state.
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _nimFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordObscured = true;
  bool _isLoading = false;

  Future<void> _login() async {
    final identifier = _nimController.text.trim();
    final password = _passwordController.text;

    // Jika NIM/NIP kosong, langsung fokus ke input NIM/NIP
    if (identifier.isEmpty) {
      _nimFocusNode.requestFocus();
      return;
    }

    // Jika password kosong, langsung fokus ke input password
    if (password.isEmpty) {
      _passwordFocusNode.requestFocus();
      return;
    }

    setState(() => _isLoading = true);

    try {
      await const MockAppService().login(
        identifier: identifier,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login gagal: $error')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Warna sesuai tema desain Figma
  static const Color primaryGreen = Color(0xFF2E9451);
  static const Color labelColor = Color(0xFF1E293B);
  static const Color hintColor = Color(0xFF94A3B8);
  static const Color borderSideColor = Color(0xFFE2E8F0);

  @override
  void dispose() {
    _nimController.dispose();
    _passwordController.dispose();
    _nimFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackground: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                // Logo Aplikasi
                Center(child: const AppLogo(size: 76)),
                const SizedBox(height: 20),

                // 2. Judul Aplikasi
                const Text(
                  'Aplikasi peminjaman',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  'SBUM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 36),

                // 3. Label & Input NIM/NIP
                const Text(
                  'NIM/NIP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: labelColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nimController,
                  focusNode: _nimFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Masukkan NIM/NIP anda',
                    hintStyle: const TextStyle(color: hintColor, fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.badge_outlined,
                      color: hintColor,
                      size: 22,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderSideColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderSideColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: primaryGreen,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 4. Label & Input Password
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: labelColor,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: _isPasswordObscured,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Password Anda',
                    hintStyle: const TextStyle(color: hintColor, fontSize: 14),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: hintColor,
                      size: 22,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: hintColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderSideColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: borderSideColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: primaryGreen,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                // 5. Link Lupa Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.lupaPassword),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Lupa password?',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 6. Tombol MASUK (Gradasi Hijau)
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF64D587), Color(0xFF20693B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'MASUK',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.8,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),

                // 7. Footer Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun? ',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: primaryGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
