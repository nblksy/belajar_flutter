import 'package:belajar_flutter/tugas_10/tugas_10.dart';
import 'package:belajar_flutter/tugas_11_12/view/form_order.dart';
import 'package:belajar_flutter/tugas_6/login.dart';
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
    Tugas10Flutter(),
    Tugas6Flutter(),
    Tugas7Flutter(),
    Tugas9Flutter(),
    Tugas11Flutter(),
    TentangAplikasi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidget.elementAt(_currentIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: "Register",
            backgroundColor: Color(0xffFF7043),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: "Login",
            backgroundColor: Color(0xff12325E),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Produk",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            label: "Order",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Tentang Aplikasi",
            backgroundColor: Colors.white,
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
