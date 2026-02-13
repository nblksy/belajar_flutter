import 'package:flutter/material.dart';

class ProfilTokoPage extends StatelessWidget {
  const ProfilTokoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nafie Shop"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 108, 171, 243),
      ),

      //NO.2
      body: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              "Since Februari 2026",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),

          // NO.3
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 10),
                  Text("nafieshop@gmail.com", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),

          //NO.4
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 8),
                Text("0812-3456-7890"),
                Spacer(),
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 8),
                Text("Jakarta"),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 24, 30, 43),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "120",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Produk", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 13, 45, 75),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "4.9",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Rating", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Nafie Shop adalah toko Dustbag online bahan dipotong secara manual",
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: Image.asset("assets/images/ss.png")),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
