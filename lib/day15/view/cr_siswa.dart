import 'package:belajar_flutter/day15/database/siswa_controller.dart';
import 'package:belajar_flutter/day15/models/siswa_model.dart';
import 'package:belajar_flutter/day15/utils/decoration_form.dart';
import 'package:flutter/material.dart';

class CrSiswaScreen extends StatefulWidget {
  const CrSiswaScreen({super.key});

  @override
  State<CrSiswaScreen> createState() => _CrSiswaScreenState();
}

class _CrSiswaScreenState extends State<CrSiswaScreen> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    kelasController.dispose();
    super.dispose();
  }

  void _tambahSiswa() {
    if (namaController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Nama belum diisi")));
      return;
    }

    if (kelasController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Kelas belum diisi")));
      return;
    }

    SiswaController.registerSiswa(
      SiswaModel(nama: namaController.text, kelas: kelasController.text),
    );

    namaController.clear();
    kelasController.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: namaController,
                decoration: decorationConstant(hintText: "Masukkan Nama Siswa"),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: kelasController,
                decoration: decorationConstant(
                  hintText: "Masukkan Kelas Siswa",
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _tambahSiswa,
                  child: const Text("Tambah Siswa"),
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // context.push(SiswaScreen());
                  },
                  child: const Text("Lihat Data Siswa"),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                "Data Siswa",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              const SiswaListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SiswaListWidget extends StatelessWidget {
  const SiswaListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SiswaModel>>(
      future: SiswaController.getAllSiswa(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("Belum ada data siswa");
        }

        final dataSiswa = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataSiswa.length,
          itemBuilder: (context, index) {
            final siswa = dataSiswa[index];

            return Card(
              child: ListTile(
                title: Text(siswa.nama),
                subtitle: Text(siswa.kelas),
              ),
            );
          },
        );
      },
    );
  }
}
