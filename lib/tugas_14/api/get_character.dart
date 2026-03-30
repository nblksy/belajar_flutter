import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:belajar_flutter/tugas_14/models/character_models.dart';

Future<List<GetCharacter>> getCharacter() async {
  final response = await http.get(
    Uri.parse("https://rickandmortyapi.com/api/character?page=2"),
  );

  log(response.body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final List<dynamic> jsonData = data["results"];

    return jsonData.map((json) => GetCharacter.fromJson(json)).toList();
  } else {
    throw Exception("Gagal memuat data");
  }
}
