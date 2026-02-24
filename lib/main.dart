import 'package:flutter/material.dart';
// Perhatikan: Gunakan nama file sesuai di Explorer kamu (splash_screens.dart)
import 'screen/splash_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Memanggil class SplashScreen
    );
  }
}