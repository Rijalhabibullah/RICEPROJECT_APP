import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String diseaseName;
  final String accuracy;

  const ResultScreen({
    super.key, 
    required this.diseaseName, 
    required this.accuracy
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Klasifikasi', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0F703A),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card Penyakit Terdeteksi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  const Text("Penyakit Terdeteksi:", style: TextStyle(fontSize: 16)),
                  Text(
                    diseaseName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  Text("Akurasi: $accuracy", style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => _showDetailPopup(context, diseaseName),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: const Text("Detail Klasifikasi & Rekomendasi", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Rekomendasi Produk:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            
            // Grid Produk (Sesuai Sketsa Kamu)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemCount: 4, // Jumlah produk contoh
              itemBuilder: (context, index) {
                return _buildProductCard();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300], // Tempat gambar produk
              // PERBAIKAN: Hapus 'const' dan ganti 'Inventory' jadi 'inventory'
              child: Center(
                child: Icon(Icons.inventory, size: 50, color: Colors.grey),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: Colors.black,
            child: const Text(
              "Deskripsi Produk",
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  void _showDetailPopup(BuildContext context, String disease) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Detail: $disease"),
        content: const Text(
          "Rekomendasi Obat:\n1. Gunakan Pestisida X\n2. Atur irigasi sawah\n3. Berikan pupuk pendukung Y.",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
        ],
      ),
    );
  }
}