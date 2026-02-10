import 'package:flutter/material.dart';
import 'package:belajar_flutter/day_5/column.dart';
import 'package:belajar_flutter/day_5/row.dart';

class ScaffoldDay5 extends StatelessWidget {
  const ScaffoldDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(255, 59, 173, 7), //Pakai Color ARGB
        backgroundColor: Color(0xff6CA651), //Pakai Color HEX
        // backgroundColor: Colors.blue, //Pakai Color Native Flutter
        title: Text("Profil Saya"),
        centerTitle: true,
        // leading: Icon(Icons.arrow_back), //Posisi di sebelah kiri
        // actions: [Text("PPKD Batch 5")],//Posisi di sebelah kanan
      ),
      body: Column(children: [ColumnDay5(), RowDay5()]),
      // backgroundColor: Color(0xffBBCB2E), //Mengubah warna background
    );
  }
}