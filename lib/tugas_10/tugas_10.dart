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

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final noHpController = TextEditingController();
  final kotaController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure1 = true;
  bool isObscure2 = true;

  InputDecoration modernInput(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey.shade600),
      filled: true,
      fillColor: const Color(0xffF5F5F7),
      contentPadding: const EdgeInsets.symmetric(vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.black, width: 1.5),
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
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("Success"),
            content: const Text("Account created. Please login."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Tugas6Flutter()),
                  );
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Register failed")));
      }
    }
  }

  Widget space() => const SizedBox(height: 16);

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
      backgroundColor: const Color(0xffEFEFF2), // 🔥 soft modern bg
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // 🔥 Title minimalis
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 6),

              Text(
                "Sign up to get started",
                style: TextStyle(color: Colors.grey.shade600),
              ),

              const SizedBox(height: 25),

              // 🔥 Card form clean
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: namaController,
                        decoration: modernInput(
                          "Full Name",
                          Icons.person_outline,
                        ),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      space(),
                      TextFormField(
                        controller: emailController,
                        decoration: modernInput("Email", Icons.email_outlined),
                        validator: (v) {
                          if (v!.isEmpty) return "Required";
                          if (!v.contains("@")) return "Invalid email";
                          return null;
                        },
                      ),
                      space(),
                      TextFormField(
                        controller: noHpController,
                        keyboardType: TextInputType.number,
                        decoration: modernInput(
                          "Phone Number",
                          Icons.phone_outlined,
                        ),
                      ),
                      space(),
                      TextFormField(
                        controller: kotaController,
                        decoration: modernInput(
                          "City",
                          Icons.location_city_outlined,
                        ),
                        validator: (v) => v!.isEmpty ? "Required" : null,
                      ),
                      space(),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isObscure1,
                        decoration: modernInput("Password", Icons.lock_outline)
                            .copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => isObscure1 = !isObscure1),
                              ),
                            ),
                        validator: (v) =>
                            v!.length < 6 ? "Min 6 characters" : null,
                      ),
                      space(),
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: isObscure2,
                        decoration:
                            modernInput(
                              "Confirm Password",
                              Icons.lock_outline,
                            ).copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () =>
                                    setState(() => isObscure2 = !isObscure2),
                              ),
                            ),
                        validator: (v) =>
                            v != passwordController.text ? "Not match" : null,
                      ),

                      const SizedBox(height: 25),

                      // 🔥 Button modern (clean banget)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
