import 'package:flutter/material.dart';
import 'package:belajar_flutter/day15/database/order_controller.dart';
import 'package:belajar_flutter/tugas_11_12/view/form_order.dart';
import '../models/order_model.dart';

class ListOrderPage extends StatefulWidget {
  const ListOrderPage({super.key});

  @override
  State<ListOrderPage> createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  List<OrderModel> orderList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final data = await OrderController.getOrders();
    setState(() {
      orderList = data;
    });
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
            MaterialPageRoute(builder: (context) => Tugas11Flutter()),
          ).then((_) => getData());
        },
      ),
      body: orderList.isEmpty
          ? const Center(child: Text("Belum ada data"))
          : ListView.builder(
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await showEditDialog(order);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await showDeleteDialog(order.id!);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> showEditDialog(OrderModel order) async {
    final namaCustomerController = TextEditingController(
      text: order.namaCustomer,
    );
    final namaProdukController = TextEditingController(text: order.namaProduk);
    final jumlahController = TextEditingController(
      text: order.jumlah.toString(),
    );
    final totalHargaController = TextEditingController(
      text: order.totalHarga.toString(),
    );
    final alamatController = TextEditingController(text: order.alamat);

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Order"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaCustomerController,
                  decoration: const InputDecoration(labelText: "Nama Customer"),
                ),
                TextField(
                  controller: namaProdukController,
                  decoration: const InputDecoration(labelText: "Nama Produk"),
                ),
                TextField(
                  controller: jumlahController,
                  decoration: const InputDecoration(labelText: "Jumlah"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: totalHargaController,
                  decoration: const InputDecoration(labelText: "Total Harga"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: alamatController,
                  decoration: const InputDecoration(labelText: "Alamat"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (order.id == null) return;

                await OrderController.updateOrder(
                  OrderModel(
                    id: order.id,
                    namaCustomer: namaCustomerController.text,
                    namaProduk: namaProdukController.text,
                    jumlah: int.tryParse(jumlahController.text) ?? 0,
                    totalHarga: int.tryParse(totalHargaController.text) ?? 0,
                    alamat: alamatController.text,
                  ),
                );

                Navigator.pop(context);
                await getData();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order berhasil diupdate")),
                );
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteDialog(int id) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Apakah anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await OrderController.deleteOrder(id);
      await getData();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Data berhasil dihapus")));
    }
  }
}
