// import 'package:belajar_flutter/tugas_1/tugas_1.dart';
// import 'package:belajar_flutter/tugas_2/tugas_2.dart';
// import 'package:belajar_flutter/tugas_3/tugas_3.dart';
// import 'package:belajar_flutter/tugas_4/tugas_4.dart';
// import 'package:belajar_flutter/tugas_5/tugas_5.dart';
// import 'package:belajar_flutter/tugas_5/tugas_5.dart';
// import 'package:belajar_flutter/tugas_6/login.dart';
// import 'package:belajar_flutter/tugas_7/tugas_7.dart';
// import 'package:belajar_flutter/tugas_7/tentang_aplikasi.dart';
// import 'package:belajar_flutter/tugas_7/tugas_7.dart';
// import 'package:belajar_flutter/tugas_10/konfirmasi_page.dart';
// import 'package:belajar_flutter/tugas_8/tugas_8.dart';
// import 'package:belajar_flutter/tugas_9/tugas_9.dart';
// import 'package:belajar_flutter/tugas_10/tugas_10.dart';
// import 'package:belajar_flutter/tugas_11/splash_screen.dart';
// import 'package:belajar_flutter/day15/view/cr_siswa.dart';
// import 'package:belajar_flutter/tugas_6/login.dart';
// import 'package:belajar_flutter/tugas_8/tugas_8.dart';
// import 'package:belajar_flutter/tugas_9/tugas_9.dart';
// import 'package:belajar_flutter/tugas_8/tugas_8.dart';
// import 'package:belajar_flutter/day15/splash_screen.dart';
// import 'package:belajar_flutter/tugas_14/views/get_character_screen.dart';
import 'package:belajar_flutter/tugas_14/views/splash_screen.dart';
// import 'package:belajar_flutter/tugas_6/login.dart';
// import 'package:belajar_flutter/tugas_8/tugas_8.dart';
// import 'package:belajar_flutter/tugas_9/tugas_9.dart';
// import 'package:belajar_flutter/welcome_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas 9',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ScreenTugas14(),
      // routes: {
      //   '/welcome': (context) => const WelcomePage(),
      //   '/login': (context) => const Tugas6Flutter(),
      // '/tugas9': (context) => const Tugas9Flutter(),
      // 'navbar': (context) => const Tugas8Flutter(),
      // },
    );
  }
}
