import 'dart:convert';

import 'package:belajar_flutter/tugas_15/api/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool isLoading = false;

  bool isValidEmail(String email) => email.contains("@");

  Future<void> register(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showMsg("Semua field wajib diisi");
      return;
    }

    if (!isValidEmail(email)) {
      showMsg("Format email tidak valid");
      return;
    }

    if (password.length < 6) {
      showMsg("Password minimal 6 karakter");
      return;
    }

    if (password != confirmPassword) {
      showMsg("Password tidak sama");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        body: {"email": email, "password": password},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showMsg(data["message"] ?? "Register berhasil 🎉");

        await Future.delayed(const Duration(milliseconds: 800));

        Navigator.pop(context); // balik ke login
      } else {
        showMsg(data["message"] ?? "Register gagal");
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
    bool isConfirm = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword
            ? (isConfirm ? hideConfirmPassword : hidePassword)
            : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    (isConfirm ? hideConfirmPassword : hidePassword)
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isConfirm) {
                        hideConfirmPassword = !hideConfirmPassword;
                      } else {
                        hidePassword = !hidePassword;
                      }
                    });
                  },
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
    confirmPasswordController.dispose();
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
                "Create Account 🚀",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Register to get started",
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

              inputField(
                hint: "Confirm Password",
                icon: Icons.lock_outline,
                controller: confirmPasswordController,
                isPassword: true,
                isConfirm: true,
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : () => register(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Register"),
                ),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Sudah punya akun? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
