import 'dart:io';
import 'dart:ui';
import 'package:belajar_flutter/day15/database/preference.dart';
import 'package:belajar_flutter/tugas_14/views/get_character_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();

  bool editName = false;
  bool editEmail = false;
  bool editPhone = false;

  File? imageFile;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final data = await PreferenceHandler().getProfile();
    setState(() {
      nameC.text = data["name"] ?? "";
      emailC.text = data["email"] ?? "";
      phoneC.text = data["phone"] ?? "";
      if (data["image"] != null && data["image"]!.isNotEmpty) {
        imageFile = File(data["image"]!);
      }
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
      await saveField("image"); // otomatis simpan foto
    }
  }

  InputDecoration inputStyle(
    String label,
    IconData icon,
    bool isEdit,
    VoidCallback onSave,
  ) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFFFF8A65)),
      suffixIcon: IconButton(
        icon: Icon(isEdit ? Icons.check : Icons.edit, size: 20),
        onPressed: onSave,
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
  }

  Future<void> saveField(String field) async {
    final currentData = await PreferenceHandler().getProfile();

    String name = nameC.text;
    String email = emailC.text;
    String phone = phoneC.text;

    switch (field) {
      case "name":
        await PreferenceHandler().saveUserProfile(
          name: name,
          email: currentData["email"] ?? "",
          phone: currentData["phone"] ?? "",
          image: currentData["image"] ?? "",
        );
        setState(() => editName = false);
        break;
      case "email":
        await PreferenceHandler().saveUserProfile(
          name: currentData["name"] ?? "",
          email: email,
          phone: currentData["phone"] ?? "",
          image: currentData["image"] ?? "",
        );
        setState(() => editEmail = false);
        break;
      case "phone":
        await PreferenceHandler().saveUserProfile(
          name: currentData["name"] ?? "",
          email: currentData["email"] ?? "",
          phone: phone,
          image: currentData["image"] ?? "",
        );
        setState(() => editPhone = false);
        break;
      case "image":
        await PreferenceHandler().saveUserProfile(
          name: currentData["name"] ?? "",
          email: currentData["email"] ?? "",
          phone: currentData["phone"] ?? "",
          image: imageFile?.path ?? "",
        );
        break;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("$field berhasil diperbarui")));
  }

  Future<void> saveProfile() async {
    await PreferenceHandler().saveUserProfile(
      name: nameC.text,
      email: emailC.text,
      phone: phoneC.text,
      image: imageFile?.path ?? "",
    );

    setState(() {
      editName = false;
      editEmail = false;
      editPhone = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile disimpan")));
  }

  Future<void> deleteProfile() async {
    await PreferenceHandler().deleteUserProfile();
    setState(() {
      nameC.clear();
      emailC.clear();
      phoneC.clear();
      imageFile = null;
      editName = false;
      editEmail = false;
      editPhone = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile dihapus")));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const Tugas14Flutter()),
    );
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    phoneC.dispose();
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
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7043),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Colors.white,
                            backgroundImage: imageFile != null
                                ? FileImage(imageFile!)
                                : null,
                            child: imageFile == null
                                ? const Icon(Icons.person, size: 45)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.camera,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: nameC,
                        enabled: editName,
                        decoration: inputStyle(
                          "Nama",
                          Icons.person,
                          editName,
                          () {
                            if (editName) {
                              saveField("name");
                            } else {
                              setState(() => editName = true);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: emailC,
                        enabled: editEmail,
                        decoration: inputStyle(
                          "Email",
                          Icons.email,
                          editEmail,
                          () {
                            if (editEmail) {
                              saveField("email");
                            } else {
                              setState(() => editEmail = true);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: phoneC,
                        enabled: editPhone,
                        decoration: inputStyle(
                          "No HP",
                          Icons.phone,
                          editPhone,
                          () {
                            if (editPhone) {
                              saveField("phone");
                            } else {
                              setState(() => editPhone = true);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: saveProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF8A65),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text("Simpan"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: deleteProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text("Hapus"),
                            ),
                          ),
                        ],
                      ),
                    ],
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
