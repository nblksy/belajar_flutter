import 'package:flutter/material.dart';

class Tugas5Flutter extends StatefulWidget {
  const Tugas5Flutter({super.key});

  @override
  State<Tugas5Flutter> createState() => _Tugas5FlutterState();
}

class _Tugas5FlutterState extends State<Tugas5Flutter> {
  bool showSecret = false;
  bool isFavorite = false;
  bool showDetail = false;
  bool showInkText = false;
  bool showImage = false;

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tugas 5"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 247, 198, 183),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showSecret = !showSecret;
                  });
                },

                //NO.1
                child: Text("Tampilkan Nama?"),
              ),
              if (showSecret)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Nama saya: BILA",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              SizedBox(height: 20),

              //NO.2
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                  if (isFavorite)
                    Text("Disukai!", style: TextStyle(color: Colors.red)),
                ],
              ),
              SizedBox(height: 20),

              //NO.3
              TextButton(
                onPressed: () {
                  setState(() {
                    showDetail = !showDetail;
                  });
                },
                child: Text("Lihat Selengkapnya"),
              ),
              if (showDetail)
                Text(
                  "Saya Peserta PPKD Batch-1 2026.",
                  textAlign: TextAlign.center,
                ),
              SizedBox(height: 20),

              //NO.4
              InkWell(
                onTap: () {
                  setState(() {
                    showImage = !showImage;
                    showInkText = !showInkText;
                  });
                  print("Kotak berhasil disentuh!");
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 87, 169, 236),
                  child: Text(
                    "Jadwal Imsakiyah👇",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              // if (showInkText)
              if (showImage)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://bansos.medanaktual.com/wp-content/uploads/2026/02/jadwal-imsakiyah-ramadhan-1447-h-2026-m-wilayah-dki-jakarta-lengkap-dan-resmi.webp",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    counter += 1;
                  });
                  print("Tekan sekali");
                },
                onDoubleTap: () {
                  setState(() {
                    counter += 2;
                  });
                  print("Tekan dua kali");
                },
                onLongPress: () {
                  setState(() {
                    counter += 3;
                  });
                  print("Tahan lama");
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 215, 142),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "Counter: $counter",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter -= 1;
          });
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.remove),
      ),
    );
  }
}
