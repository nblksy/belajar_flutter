import 'package:flutter/material.dart';

class Tugas4Flutter extends StatelessWidget {
  const Tugas4Flutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Pelanggan & Daftar Produk"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),

      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          //INPUT
          Text(
            "Formulir Pelanggan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              labelText: "No. HP",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 12),

          TextField(
            decoration: InputDecoration(
              labelText: "Deskripsi",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),

          SizedBox(height: 24),

          Divider(),
          SizedBox(height: 8),

          Text(
            "Daftar Produk",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text("Dustbag UK 50x40"),
            subtitle: Text("Harga: Rp3.800"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text("Dustbag UK 50x50"),
            subtitle: Text("Harga: Rp5.000"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text("Dustbag UK 40x50"),
            subtitle: Text("Harga: Rp4.500"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text("Dustbag UK 50x60"),
            subtitle: Text("Harga: Rp5.700"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag, color: Colors.orange),
            title: Text("Dustbag UK 18x14"),
            subtitle: Text("Harga: Rp1.300"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }
}
