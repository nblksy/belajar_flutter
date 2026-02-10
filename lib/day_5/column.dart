import 'package:flutter/material.dart';

class ColumnDay5 extends StatelessWidget {
  const ColumnDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Nama :Bila",
          style: TextStyle(fontSize: 50),
        ),
        Text(
          "Umur : 17 Tahun", 
          style: TextStyle(
        
            color: Colors.blue, 
            fontSize: 40, 
            fontWeight: FontWeight.bold, 
          ),
        ),
        Text(
          "Pekerjaan : Instruktur",
          style: TextStyle(
            color: Colors.red, 
            fontSize: 30, 
            fontWeight: FontWeight.w400,
            decoration:
                TextDecoration.underline,
            fontStyle: FontStyle
                .italic, 
          ),
        ),
        Text("Pekerjaan : Instruktur"),
      ],
    );
  }
}