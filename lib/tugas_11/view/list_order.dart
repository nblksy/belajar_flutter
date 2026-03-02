import 'package:belajar_flutter/day15/database/sqflite.dart';
import 'package:belajar_flutter/tugas_11/view/form_order.dart';
import 'package:flutter/material.dart';
import '../models/order_model.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  List<OrderModel> orderList = [];

  void getData() async {
    final data = await DBHelper.getOrders();
    setState(() {
      orderList = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Order"),
        backgroundColor: Colors.deepOrange,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Tugas11Flutter()),
          ).then((value) => getData());
        },
      ),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final order = orderList[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(order.namaCustomer),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Produk: ${order.namaProduk}"),
                  Text("Jumlah: ${order.jumlah}"),
                  Text("Total: ${order.totalHarga}"),
                  Text("Alamat: ${order.alamat}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
