import 'dart:convert';

import 'package:belajar_flutter/day15/database/preference.dart';
import 'package:belajar_flutter/tugas_14/views/get_character_screen.dart';
import 'package:belajar_flutter/tugas_14/views/splash_screen.dart';
import 'package:belajar_flutter/tugas_15/api/endpoint.dart';
import 'package:belajar_flutter/tugas_15/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  bool isValidEmail(String email) => email.contains("@");

  Future<void> login(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMsg("Email dan password wajib diisi");
      return;
    }

    if (!isValidEmail(email)) {
      showMsg("Format email tidak valid");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(Endpoint.login),
        body: {"email": email, "password": password},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        await PreferenceHandler().storingIsLogin(true);

        showMsg(data["message"] ?? "Login berhasil 👋");

        await Future.delayed(const Duration(milliseconds: 700));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ScreenTugas14()),
        );
      } else {
        showMsg(data["message"] ?? "Login gagal");
      }
    } catch (e) {
      showMsg("Terjadi kesalahan server");
    }

    setState(() => isLoading = false);
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? hidePassword : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                )
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              const Text(
                "Welcome Back 👋",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Login to continue",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              inputField(
                hint: "Email",
                icon: Icons.email_outlined,
                controller: emailController,
              ),

              inputField(
                hint: "Password",
                icon: Icons.lock_outline,
                controller: passwordController,
                isPassword: true,
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Login"),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Register()),
                  );
                },
                child: const Text("Belum punya akun? Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
