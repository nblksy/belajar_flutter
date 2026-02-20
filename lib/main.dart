// import 'package:belajar_flutter/tugas_1/tugas_1.dart';
// import 'package:belajar_flutter/tugas_2/tugas_2.dart';
// import 'package:belajar_flutter/tugas_3/tugas_3.dart';
// import 'package:belajar_flutter/tugas_4/tugas_4.dart';
import 'package:belajar_flutter/tugas_5/tugas_5.dart';
import 'package:belajar_flutter/tugas_6/tugas_6.dart';
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
      title: 'Tugas 5',
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
      home: Tugas6Flutter(),
    );
  }
}
