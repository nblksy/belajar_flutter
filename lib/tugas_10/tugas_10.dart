import 'package:belajar_flutter/tugas_10/konfirmasi_page.dart';
import 'package:flutter/material.dart';

class Tugas10Flutter extends StatefulWidget {
  const Tugas10Flutter({super.key});

  @override
  State<Tugas10Flutter> createState() => _FormPendaftaranState();
}

class _FormPendaftaranState extends State<Tugas10Flutter> {
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

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Data Pendaftaran"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama: ${namaController.text}"),
              Text("Email: ${emailController.text}"),
              Text(
                "No HP: ${noHpController.text.isEmpty ? "-" : noHpController.text}",
              ),
              Text("Kota: ${kotaController.text}"),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Lanjut"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => KonfirmasiPage(
                      nama: namaController.text,
                      kota: kotaController.text,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  InputDecoration modernInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Color.fromARGB(255, 236, 231, 231),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.deepOrange, width: 2),
      ),
    );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffFF8A65), Color(0xffFF7043)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Daftar Akun",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(height: 20),
                          TextFormField(
                            controller: namaController,
                            decoration: modernInput(
                              "Nama Lengkap",
                              Icons.person,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Nama wajib diisi";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: emailController,
                            decoration: modernInput("Email", Icons.email),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email wajib diisi";
                              }
                              if (!value.contains("@")) {
                                return "Email harus mengandung @";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: noHpController,
                            keyboardType: TextInputType.number,
                            decoration: modernInput("Nomor HP", Icons.phone),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return "Nomor HP hanya boleh angka";
                                }
                                if (value.length < 9 || value.length > 15) {
                                  return "Nomor HP min 9 dan max 15 digit";
                                }
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
                          TextFormField(
                            controller: kotaController,
                            decoration: modernInput(
                              "Kota",
                              Icons.location_city,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Kota wajib diisi";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16),
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
                                    onPressed: () {
                                      setState(() {
                                        isObscure1 = !isObscure1;
                                      });
                                    },
                                  ),
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password wajib diisi";
                              }
                              if (value.length < 6) {
                                return "Password minimal 6 karakter";
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return "Password harus mengandung angka";
                              }
                              if (!RegExp(
                                r'[!@#$%^&*(),.?":{}|<>]',
                              ).hasMatch(value)) {
                                return "Password harus mengandung simbol";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
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
                                    onPressed: () {
                                      setState(() {
                                        isObscure2 = !isObscure2;
                                      });
                                    },
                                  ),
                                ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Konfirmasi password wajib diisi";
                              }
                              if (value != passwordController.text) {
                                return "Password tidak cocok";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: submitForm,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: Colors.deepOrange,
                                elevation: 5,
                              ),
                              child: Text(
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
