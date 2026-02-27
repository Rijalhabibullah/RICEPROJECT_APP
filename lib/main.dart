import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dashboard_klasifikasi.dart'; 
import 'screen/history_screen.dart';
import 'screen/ecommerce_screen.dart';
import 'package:padi_app/screen/login.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}

// --- 1. SPLASH SCREEN DENGAN TAGLINE ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _pindahHalaman();
  }

  _pindahHalaman() async {
    // Tunggu 3 detik untuk menampilkan logo dan tagline
    await Future.delayed(const Duration(seconds: 3));
    
    // Cek status login di memori lokal HP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool statusLogin = prefs.getBool('isLoggedIn') ?? false;

    if (!mounted) return;

    if (statusLogin) {
      // Jika sudah pernah login, langsung masuk ke Navigasi Utama (Dashboard)
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const MainNavigation())
      );
    } else {
      // Jika belum login, arahkan ke halaman Login
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => const LoginScreen())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0F703A), // Warna hijau AgriPadi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.eco, size: 100, color: Colors.white),
            SizedBox(height: 10),
            Text(
              "AgriPadi",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Solusi Deteksi Penyakit Padi Akurat", // Tagline yang kamu minta
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. NAVIGASI UTAMA (SWIPE ANTARA HISTORY, DASHBOARD, & ECOMMERCE) ---
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  // Controller untuk mengatur halaman awal di Dashboard (Index 1)
  final PageController _controller = PageController(initialPage: 1); 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Area Halaman yang bisa digeser
          PageView(
            controller: _controller,
            children: const [
              HistoryScreen(),    // Sebelah Kiri (Index 0)
              HomeScreen(),       // Tengah/Dashboard Utama (Index 1)
              EcommerceScreen(),  // Sebelah Kanan (Index 2 - Fitur Pencarian)
            ],
          ),

          // Indikator Titik (Page Indicator) di bagian bawah
          Container(
            alignment: const Alignment(0, 0.9),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const ExpandingDotsEffect(
                activeDotColor: Color(0xFF0F703A),
                dotColor: Colors.grey,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}