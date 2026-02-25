import 'package:flutter/material.dart';
import 'product_data.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final String kategori;

  const ProductPage({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    List<Product> products = getProducts(kategori);

    return Scaffold(
      appBar: AppBar(
        title: Text(kategori),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                product.gambar,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(product.nama),
              subtitle: Text(product.deskripsi),
              trailing: Text(
                "Rp ${product.harga}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
