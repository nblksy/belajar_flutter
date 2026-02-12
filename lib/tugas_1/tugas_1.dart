import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas1Flutter());
}

class Tugas1Flutter extends StatelessWidget {
  const Tugas1Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProfilSaya());
  }
}

class ProfilSaya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 57, 156, 238),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Nama: Nabilah Lakeisha Syifa',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_on, color: Colors.red),

              Text('Jakarta', style: TextStyle(fontSize: 16)),
            ],
          ),

          const Text(
            'Seorang pelajar yang sedang belajar Flutter.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Image.asset("assets/images/ss.png"),
        ],
      ),
    );
  }
}
