import 'package:belajar_flutter/tugas_7/tentang_aplikasi.dart';
import 'package:belajar_flutter/tugas_7/tugas_7.dart';
import 'package:belajar_flutter/tugas_9/tugas_9.dart';
import 'package:flutter/material.dart';

class Tugas8Flutter extends StatefulWidget {
  const Tugas8Flutter({super.key});

  @override
  State<Tugas8Flutter> createState() => _Tugas8Flutter();
}

class _Tugas8Flutter extends State<Tugas8Flutter> {
  int _currentIndex = 0;
  void ontapItem(int index) {
    _currentIndex = index;
    setState(() {});
  }

  final List<Widget> listWidget = [
    Tugas7Flutter(),
    TentangAplikasi(),
    Tugas9Flutter(),
    // Text("data 3"),
    // Text("data 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget.elementAt(_currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Tentang Aplikasi",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Produk",
            backgroundColor: Colors.blue,
          ),
        ],
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: Colors.black),
        currentIndex: _currentIndex,
        onTap: ontapItem,
      ),
    );
  }
}
