import 'package:belajar_flutter/day15/database/sqflite.dart';
import 'package:belajar_flutter/day15/models/user_model.dart';
import 'package:belajar_flutter/tugas_6/login.dart';
import 'package:flutter/material.dart';

class Tugas10Flutter extends StatefulWidget {
  const Tugas10Flutter({super.key});

  @override
  State<Tugas10Flutter> createState() => _Tugas10FlutterState();
}

class _Tugas10FlutterState extends State<Tugas10Flutter> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController kotaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isObscure1 = true;
  bool isObscure2 = true;

  InputDecoration modernInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color.fromARGB(255, 236, 231, 231),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
      ),
    );
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await DBHelper.registerUser(
          UserModel(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Pendaftaran Berhasil"),
            content: const Text(
              "Silakan login menggunakan akun yang baru dibuat.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Tugas6Flutter()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Pendaftaran Gagal")));
      }
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noHpController.dispose();
    kotaController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: modernInput("Nama Lengkap", Icons.person),
                  validator: (value) =>
                      value!.isEmpty ? "Nama wajib diisi" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: modernInput("Email", Icons.email),
                  validator: (value) {
                    if (value!.isEmpty) return "Email wajib diisi";
                    if (!value.contains("@")) return "Email harus mengandung @";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: noHpController,
                  keyboardType: TextInputType.number,
                  decoration: modernInput("Nomor HP", Icons.phone),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^[0-9]+$').hasMatch(value))
                        return "Nomor HP hanya angka";
                      if (value.length < 9 || value.length > 15)
                        return "Nomor HP min 9 & max 15 digit";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: kotaController,
                  decoration: modernInput("Kota", Icons.location_city),
                  validator: (value) =>
                      value!.isEmpty ? "Kota wajib diisi" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: isObscure1,
                  decoration: modernInput("Password", Icons.lock).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure1 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => isObscure1 = !isObscure1),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return "Password wajib diisi";
                    if (value.length < 6) return "Password minimal 6 karakter";
                    if (!RegExp(r'[0-9]').hasMatch(value))
                      return "Harus mengandung angka";
                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value))
                      return "Harus mengandung simbol";
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
                  validator: (value) {
                    if (value!.isEmpty)
                      return "Konfirmasi password wajib diisi";
                    if (value != passwordController.text)
                      return "Password tidak cocok";
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.deepOrange,
                      elevation: 5,
                    ),
                    child: const Text(
                      "Daftar",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
