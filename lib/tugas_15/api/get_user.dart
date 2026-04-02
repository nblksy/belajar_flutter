import 'dart:convert';
import 'dart:developer';

import 'package:belajar_flutter/tugas_15/api/endpoint.dart';
import 'package:belajar_flutter/tugas_15/models/get_model.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/day15/database/preference.dart';

Future<GetUserModel?> getUser() async {
  var token = await PreferenceHandler.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Token login tidak ditemukan");
  }

  final response = await http.get(
    Uri.parse(Endpoint.profile),
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  log(response.body);
  if (response.statusCode == 200) {
    return GetUserModel.fromJson(json.decode(response.body));
  } else {
    final error = GetUserModel.fromJson(json.decode(response.body));
    log(error.toString());

    throw Exception(error.message);
  }
}
