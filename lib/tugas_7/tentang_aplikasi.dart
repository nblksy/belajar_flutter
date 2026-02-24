import 'package:flutter/material.dart';

class TentangAplikasi extends StatelessWidget {
  const TentangAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang Aplikasi"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepOrange,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Aplikasi Form Interaktif",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Aplikasi ini dibuat untuk memenuhi tugas Flutter "
              "7 dan 8.",
            ),
            SizedBox(height: 20),
            Text("Pembuat: Nabilah Lakeisha Syifa"),
            Text("Versi: 1.0.0"),
          ],
        ),
      ),
    );
  }
}
