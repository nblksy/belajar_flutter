import 'package:belajar_flutter/tugas_14/views/get_character_screen.dart';
import 'package:flutter/material.dart';

class ScreenTugas14 extends StatefulWidget {
  const ScreenTugas14({super.key});

  @override
  State<ScreenTugas14> createState() => _ScreenTugas14();
}

class _ScreenTugas14 extends State<ScreenTugas14>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    goNext();
  }

  void goNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const Tugas14Flutter(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _opacity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/poster_rickmorty.jpg",
              fit: BoxFit.cover,
            ),

            Container(color: Colors.black.withOpacity(0.3)),

            // Optional loading indicator
            const Center(child: CircularProgressIndicator(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
