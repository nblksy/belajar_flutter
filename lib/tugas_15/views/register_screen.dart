import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/tugas_15/api/endpoint.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure1 = true;
  bool isObscure2 = true;
  bool isLoading = false;

  String selectedRole = "user"; // bisa diubah "admin" kalau perlu

  InputDecoration modernInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFFFF8A65)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFFFF8A65), width: 1.5),
      ),
    );
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim().toLowerCase(),
      "password": passwordController.text.trim(),
      "role": selectedRole,
      "phone": phoneController.text.trim(),
    };

    print("Sending data: ${jsonEncode(body)}");

    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Berhasil 🎉"),
            content: Text(data["message"] ?? "Register sukses"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // tutup dialog
                  Navigator.pop(context); // kembali ke login
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        showMsg(data["message"] ?? "Register gagal");
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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0D6), Color(0xFFFFB7A5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF7043),
                          ),
                        ),
                        const SizedBox(height: 25),
                        TextFormField(
                          controller: nameController,
                          decoration: modernInput("Nama Lengkap", Icons.person),
                          validator: (v) =>
                              v!.isEmpty ? "Nama wajib diisi" : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: modernInput("Email", Icons.email),
                          validator: (v) {
                            if (v!.isEmpty) return "Email wajib diisi";
                            if (!v.contains("@")) return "Email tidak valid";
                            return null;
                          },
                        ),
                        // const SizedBox(height: 16),
                        // TextFormField(
                        //   controller: phoneController,
                        //   keyboardType: TextInputType.phone,
                        //   decoration: modernInput("Nomor HP", Icons.phone),
                        // ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          obscureText: isObscure1,
                          decoration: modernInput("Password", Icons.lock)
                              .copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () =>
                                      setState(() => isObscure1 = !isObscure1),
                                ),
                              ),
                          validator: (v) {
                            if (v!.isEmpty) return "Password wajib diisi";
                            if (v.length < 8) return "Minimal 8 karakter";
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: isObscure2,
                          decoration:
                              modernInput(
                                "Konfirmasi Password",
                                Icons.lock_outline,
                              ).copyWith(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () =>
                                      setState(() => isObscure2 = !isObscure2),
                                ),
                              ),
                          validator: (v) {
                            if (v != passwordController.text) {
                              return "Password tidak cocok";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: isLoading ? null : register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF8A65),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 40,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Daftar",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Sudah punya akun? Login"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
