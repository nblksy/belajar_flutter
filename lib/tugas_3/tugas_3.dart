import 'package:flutter/material.dart';

class Tugas3Flutter extends StatelessWidget {
  const Tugas3Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form & Galeri Produk"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//NO.1
              const Text(
                "Input Produk Baru",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Nama Produk",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Kategori",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              const TextField(
                decoration: InputDecoration(
                  labelText: "Deskripsi Produk",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 30),

//NO.2
              const Text(
                "Galeri Produk",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(6, (index) {
                  return Stack(
                    children: [
                      // Kotak warna / gambar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[(index + 1) * 100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      // Label di atas kotak
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "Produk ${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}