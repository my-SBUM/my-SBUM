import 'package:flutter/material.dart';
import 'package:my_sbum/komponen/kerangka_aplikasi.dart';
import 'package:my_sbum/komponen/kepala_halaman_aplikasi.dart';
import 'package:my_sbum/data/layanan/layanan_aplikasi_simulasi.dart';

class UbahPasswordScreen extends StatefulWidget {
  const UbahPasswordScreen({super.key});

  @override
  State<UbahPasswordScreen> createState() => _UbahPasswordScreenState();
}

class _UbahPasswordScreenState extends State<UbahPasswordScreen> {
  // Controllers
  late TextEditingController _passwordLamaController;
  late TextEditingController _passwordBaruController;
  late TextEditingController _konfirmasiPasswordController;

  // State
  bool _obscurePasswordLama = true;
  bool _obscurePasswordBaru = true;
  bool _obscureKonfirmasiPassword = true;
  bool _isPasswordLamaFilled = false;
  bool _isPasswordBaruFilled = false;
  bool _isKonfirmasiPasswordFilled = false;
  bool _isSaving = false;

  // Warna
  static const Color primaryGreen = Color(0xFF0A6332);
  static const Color textDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);
  static const Color borderColor = Color(0xFFE2E8F0);

  @override
  void initState() {
    super.initState();
    _passwordLamaController = TextEditingController();
    _passwordBaruController = TextEditingController();
    _konfirmasiPasswordController = TextEditingController();

    _passwordLamaController.addListener(() {
      setState(() {
        _isPasswordLamaFilled = _passwordLamaController.text.isNotEmpty;
      });
    });

    _passwordBaruController.addListener(() {
      setState(() {
        _isPasswordBaruFilled = _passwordBaruController.text.isNotEmpty;
      });
    });

    _konfirmasiPasswordController.addListener(() {
      setState(() {
        _isKonfirmasiPasswordFilled =
            _konfirmasiPasswordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _passwordLamaController.dispose();
    _passwordBaruController.dispose();
    _konfirmasiPasswordController.dispose();
    super.dispose();
  }

  // Check apakah semua form terisi
  bool get _isFormValid =>
      _isPasswordLamaFilled &&
      _isPasswordBaruFilled &&
      _isKonfirmasiPasswordFilled &&
      _passwordBaruController.text.length >= 8 &&
      _passwordBaruController.text == _konfirmasiPasswordController.text;

  Future<void> _saveChanges() async {
    if (!_isPasswordLamaFilled) {
      _showError('Password lama wajib diisi.');
      return;
    }
    if (_passwordBaruController.text.length < 8) {
      _showError('Password baru minimal 8 karakter.');
      return;
    }
    if (_passwordBaruController.text != _konfirmasiPasswordController.text) {
      _showError('Konfirmasi password tidak sama.');
      return;
    }
    setState(() => _isSaving = true);
    try {
      await const MockAppService().changePassword(
        oldPassword: _passwordLamaController.text,
        newPassword: _passwordBaruController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password berhasil diubah'),
          backgroundColor: primaryGreen,
        ),
      );
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      _showError('Gagal mengubah password: $error');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    // Header ditaruh di dalam Column (bukan appBar) supaya konten
    // tidak menabrak header, sama seperti halaman Profil Saya.
    return AppScaffold(
      showBackground: true,
      body: SafeArea(
        child: Column(
          children: [
            const AppPageHeader(title: 'Ubah Password'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER SECTION ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ubah Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Masukkan password lama dan buat password baru yang kuat',
                            style: TextStyle(
                              fontSize: 13,
                              color: textGrey,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // PASSWORD LAMA
                          const Text(
                            'PASSWORD LAMA',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: textGrey,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildPasswordField(
                            controller: _passwordLamaController,
                            placeholder: 'Masukkan password lama',
                            obscure: _obscurePasswordLama,
                            isFilled: _isPasswordLamaFilled,
                            onToggleObscure: () {
                              setState(() {
                                _obscurePasswordLama = !_obscurePasswordLama;
                              });
                            },
                          ),
                          const SizedBox(height: 24),

                          // PASSWORD BARU
                          const Text(
                            'PASSWORD BARU',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: textGrey,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildPasswordField(
                            controller: _passwordBaruController,
                            placeholder: 'Masukkan password baru',
                            obscure: _obscurePasswordBaru,
                            isFilled: _isPasswordBaruFilled,
                            onToggleObscure: () {
                              setState(() {
                                _obscurePasswordBaru = !_obscurePasswordBaru;
                              });
                            },
                          ),
                          const SizedBox(height: 24),

                          // KONFIRMASI PASSWORD BARU
                          const Text(
                            'KONFIRMASI PASSWORD BARU',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: textGrey,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildPasswordField(
                            controller: _konfirmasiPasswordController,
                            placeholder: 'Masukkan ulang password',
                            obscure: _obscureKonfirmasiPassword,
                            isFilled: _isKonfirmasiPasswordFilled,
                            onToggleObscure: () {
                              setState(() {
                                _obscureKonfirmasiPassword =
                                    !_obscureKonfirmasiPassword;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // --- BUTTONS SECTION ---
                    // Tombol Batal
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: borderColor, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Batal',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tombol Simpan Perubahan
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed:
                            _isFormValid && !_isSaving ? _saveChanges : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isFormValid ? primaryGreen : Colors.grey,
                          disabledBackgroundColor: Colors.grey.shade300,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: _isFormValid
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                        label: _isSaving
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Simpan Perubahan',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: _isFormValid
                                      ? Colors.white
                                      : Colors.grey.shade600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk password field
  Widget _buildPasswordField({
    required TextEditingController controller,
    required String placeholder,
    required bool obscure,
    required bool isFilled,
    required VoidCallback onToggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        children: [
          // Icon bullet
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: primaryGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // TextField
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(
                fontSize: 14,
                color: textDark,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: textGrey,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 0,
                ),
              ),
            ),
          ),

          // Toggle button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: onToggleObscure,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  obscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 16,
                  color: textGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}