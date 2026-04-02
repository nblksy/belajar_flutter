import 'dart:convert';
import 'dart:developer';

import 'package:belajar_flutter/day15/database/preference.dart';
import 'package:belajar_flutter/tugas_15/api/endpoint.dart';
import 'package:belajar_flutter/tugas_15/models/get_model.dart';
import 'package:belajar_flutter/tugas_15/models/register_model.dart';
import 'package:http/http.dart' as http;

Future<RegisterModel?> registerUser({
  required String name,
  required String email,
  required String password,
  String? phone,
  String role = "user",
}) async {
  final response = await http.post(
    Uri.parse(Endpoint.register),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
    body: jsonEncode({
      "name": name,
      "email": email,
      "password": password,
      "role": role,
      "phone": phone ?? "",
    }),
  );

  log(response.body);
  if (response.statusCode == 200) {
    return RegisterModel.fromJson(json.decode(response.body));
  } else {
    final error = RegisterModel.fromJson(json.decode(response.body));
    log(error.toString());

    throw Exception(error.message);
  }
}

Future<RegisterModel?> loginUser({
  required String email,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse(Endpoint.login),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  log(response.body);
  final body = json.decode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 200) {
    final model = RegisterModel.fromJson(body);
    final token = model.data?.token;
    final user = model.data?.user;

    if (token != null && token.isNotEmpty) {
      await PreferenceHandler().storingToken(token);
    }

    if (user != null) {
      await PreferenceHandler().saveUserProfile(
        name: user.name ?? "",
        email: user.email ?? email,
      );
    }

    return model;
  } else {
    final error = RegisterModel.fromJson(body);
    log(error.toString());
    throw Exception(error.message ?? "Login gagal");
  }
}

Future<GetUserModel?> updateProfile({
  required String name,
  required String email,
}) async {
  final token = await PreferenceHandler.getToken();
  if (token == null || token.isEmpty) {
    throw Exception("Token login tidak ditemukan");
  }

  final response = await http.put(
    Uri.parse(Endpoint.profile),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({"name": name, "email": email}),
  );

  log(response.body);
  final body = json.decode(response.body) as Map<String, dynamic>;

  if (response.statusCode == 200) {
    return GetUserModel.fromJson(body);
  } else {
    final error = GetUserModel.fromJson(body);
    throw Exception(error.message ?? "Profil gagal diperbarui");
  }
}
