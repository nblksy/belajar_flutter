import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas1Flutter());
}

class Tugas1Flutter extends StatelessWidget {
  const Tugas1Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilSaya(),
    );
  }
}

class ProfilSaya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
    
            const Text(
              'Nama: Nabilah Lakeisha Syifa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

      
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                SizedBox(width: 4),
                Text(
                  'Jakarta',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            const SizedBox(height: 12),


            const Text(
              'Seorang pelajar yang sedang belajar Flutter.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}