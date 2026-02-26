import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Klasifikasi"),
        backgroundColor: const Color(0xFF1B5E20),
      ),
      body: const Center(child: Text("Halaman Riwayat Siap Dihubungkan ke MySQL")),
    );
  }
}