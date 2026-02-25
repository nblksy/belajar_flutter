import 'package:flutter/material.dart';
import 'product_page.dart';

class Tugas9Flutter extends StatelessWidget {
  const Tugas9Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text("Nafie Store"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          menuKategori(
            context,
            "Dustbag Custom Logo",
            Icons.workspace_premium,
            Colors.orange,
            "Bisa custom logo brand kamu",
          ),
          menuKategori(
            context,
            "Dustbag Sepatu",
            Icons.shopping_bag,
            Colors.blue,
            "Cocok untuk sneakers & sepatu",
          ),
          menuKategori(
            context,
            "Dustbag Tas",
            Icons.shopping_bag_sharp,
            const Color.fromARGB(255, 88, 53, 104),
            "Melindungi tas agar tetap bersih",
          ),
        ],
      ),
    );
  }

  Widget menuKategori(
    BuildContext context,
    String kategori,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(kategori: kategori),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 255, 173, 80),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 224, 214),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kategori,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(subtitle, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
