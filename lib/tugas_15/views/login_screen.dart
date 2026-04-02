import 'dart:convert';
import 'package:belajar_flutter/day15/database/preference.dart';
import 'package:belajar_flutter/tugas_15/api/endpoint.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'register_screen.dart';
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

    final body = {"email": email.toLowerCase(), "password": password};
    print("Login body: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse(Endpoint.login), // gunakan endpoint login
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      print("Login response: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // simpan login state
        await PreferenceHandler().storingIsLogin(true);

        // simpan profil
        await PreferenceHandler().saveUserProfile(
          name: data["data"]?["name"] ?? "",
          email: email,
        );

        showMsg("Login Berhasil");

        await Future.delayed(const Duration(milliseconds: 700));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ProfileScreen()),
        );
      } else {
        showMsg(data["message"] ?? "Login gagal");
      }
    } catch (e) {
      print("Error: $e");
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
        color: Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black12),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? hidePassword : false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black45),
          prefixIcon: Icon(icon, color: Colors.black54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget loginIcon() {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Icon(Icons.login, size: 45, color: Colors.black),
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
      backgroundColor: const Color(0xFFFFF4EA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 80),
              loginIcon(),
              const SizedBox(height: 30),
              const Text(
                "Hello Welcome Back",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Welcome back please sign in again",
                style: TextStyle(color: Colors.black54),
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
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFB9B8F),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: isLoading ? null : () => login(context),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black26),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Register()),
                    );
                  },
                  child: const Text(
                    "Daftar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
