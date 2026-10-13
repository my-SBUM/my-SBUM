import 'package:flutter/material.dart';

import './inti/rute/pengarah_aplikasi.dart';
import './inti/rute/rute_aplikasi.dart';
import './inti/warna_aplikasi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my-SBUM',
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.generate,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          surfaceTintColor: Colors.transparent,
        ),
      ),
    );
  }
}
