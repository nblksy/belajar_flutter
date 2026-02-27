import 'package:belajar_flutter/tugas_6/login.dart';
import 'package:belajar_flutter/tugas_9/tugas_9.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool("is_login");

    if (isLogin == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Tugas6Flutter()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Tugas9Flutter()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffb3800),
      body: Center(child: Image.asset("assets/images/logo.png")),
    );
  }
}
