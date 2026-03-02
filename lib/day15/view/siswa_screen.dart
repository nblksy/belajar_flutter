import 'package:belajar_flutter/day15/database/siswa_controller.dart';
import 'package:belajar_flutter/day15/models/siswa_model.dart';
import 'package:flutter/material.dart';

class SiswaScreen extends StatefulWidget {
  const SiswaScreen({super.key});

  @override
  State<SiswaScreen> createState() => _SiswaScreenState();
}

class _SiswaScreenState extends State<SiswaScreen> {
  late List<SiswaModel> dataSiswa = [];
  @override
  void initState() {
    super.initState();
    getDataSiswa();
  }

  Future<void> getDataSiswa() async {
    await Future.delayed(Duration(seconds: 3));
    dataSiswa = await SiswaController.getAllSiswa();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataSiswa.isEmpty || dataSiswa == []
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: dataSiswa.length,
              itemBuilder: (BuildContext context, int index) {
                final items = dataSiswa[index];
                return ListTile(
                  title: Text(items.nama),
                  subtitle: Text(items.kelas),
                );
              },
            ),
    );
  }
}