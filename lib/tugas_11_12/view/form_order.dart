import 'package:belajar_flutter/day15/database/sqflite.dart';
import 'package:belajar_flutter/tugas_11_12/view/list_order.dart';
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class Tugas11Flutter extends StatefulWidget {
  const Tugas11Flutter({super.key});

  @override
  State<Tugas11Flutter> createState() => _Tugas11FlutterState();
}

class _Tugas11FlutterState extends State<Tugas11Flutter> {
  final _formKey = GlobalKey<FormState>();

  final namaCustomer = TextEditingController();
  final namaProduk = TextEditingController();
  final jumlah = TextEditingController();
  final totalHarga = TextEditingController();
  final alamat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Order"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    controller: namaCustomer,
                    label: "Nama Customer",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: namaProduk,
                    label: "Nama Produk",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: jumlah,
                    label: "Jumlah",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    isNumber: true,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: totalHarga,
                    label: "Total Harga",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    isNumber: true,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: alamat,
                    label: "Alamat",
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          OrderModel order = OrderModel(
                            namaCustomer: namaCustomer.text,
                            namaProduk: namaProduk.text,
                            jumlah: int.parse(jumlah.text),
                            totalHarga: int.parse(totalHarga.text),
                            alamat: alamat.text,
                          );

                          await DBHelper.insertOrder(order);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListOrderPage(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Simpan Order",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: (value) {
        if (value!.isEmpty) return "Tidak boleh kosong";
        if (isNumber && int.tryParse(value) == null) return "Harus angka";
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
