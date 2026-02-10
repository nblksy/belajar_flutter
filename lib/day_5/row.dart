import 'package:flutter/material.dart';

class RowDay5 extends StatelessWidget {
  const RowDay5({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Menu 1"),
        Text("Menu 2"),
        Text("Menu 3"),
        Text("Menu 4"),
        Text("Menu 5"),
      ],
    );
  }
}