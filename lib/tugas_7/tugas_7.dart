import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tugas7Flutter extends StatefulWidget {
  const Tugas7Flutter({super.key});

  @override
  State<Tugas7Flutter> createState() => _Tugas7FlutterState();
}

class _Tugas7FlutterState extends State<Tugas7Flutter> {
  int selectedMenu = 0;

  bool isChecked = false;
  bool isDarkMode = false;
  String? selectedKategori;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Color get textColor => isDarkMode ? Colors.white : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xff121212)
          : const Color(0xffF4F6FA),
      appBar: AppBar(
        title: Text(getTitle()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.orange],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Menu Input",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            menuItem(Icons.check_box, "Checkbox", 0),
            menuItem(Icons.dark_mode, "Switch", 1),
            menuItem(Icons.list, "Dropdown", 2),
            menuItem(Icons.calendar_today, "Tanggal", 3),
            menuItem(Icons.access_time, "Jam", 4),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: buildBody(),
        ),
      ),
    );
  }

  Widget menuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(
        icon,
        color: selectedMenu == index ? Colors.deepOrange : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selectedMenu == index
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      selected: selectedMenu == index,
      selectedTileColor: Colors.deepOrange.shade100,
      onTap: () {
        setState(() {
          selectedMenu = index;
        });
        Navigator.pop(context);
      },
    );
  }

  String getTitle() {
    switch (selectedMenu) {
      case 0:
        return "Syarat & Ketentuan";
      case 1:
        return "Mode Tampilan";
      case 2:
        return "Pilih Kategori";
      case 3:
        return "Tanggal Lahir";
      case 4:
        return "Atur Pengingat";
      default:
        return "";
    }
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  Widget buildBody() {
    switch (selectedMenu) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Konfirmasi Persetujuan"),
            const SizedBox(height: 25),
            CheckboxListTile(
              value: isChecked,
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Saya menyetujui semua persyaratan",
                style: TextStyle(color: textColor),
              ),
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              isChecked
                  ? "✅ Anda bisa melanjutkan"
                  : "❌ Silakan setujui terlebih dahulu",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ],
        );

      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Pengaturan Tampilan"),
            const SizedBox(height: 25),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: isDarkMode,
              title: Text(
                "Aktifkan Mode Gelap",
                style: TextStyle(color: textColor),
              ),
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              isDarkMode ? "🌙 Mode Gelap Aktif" : "☀️ Mode Terang Aktif",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        );

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Kategori Produk"),
            const SizedBox(height: 25),
            DropdownButton<String>(
              value: selectedKategori,
              hint: Text("Pilih Kategori", style: TextStyle(color: textColor)),
              isExpanded: true,
              dropdownColor: isDarkMode
                  ? const Color(0xff1E1E1E)
                  : Colors.white,
              items: ["Elektronik", "Pakaian", "Makanan", "Lainnya"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: TextStyle(color: textColor)),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedKategori = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              selectedKategori != null
                  ? "Anda memilih kategori: $selectedKategori"
                  : "❌ Belum memilih kategori",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ],
        );

      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Pilih Tanggal Lahir"),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: const Text("Pilih Tanggal"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedDate != null
                  ? "Tanggal Lahir: ${DateFormat('dd MMMM yyyy').format(selectedDate!)}"
                  : "❌ Belum memilih tanggal",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ],
        );

      case 4:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Atur Waktu Pengingat"),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: const Text("Pilih Waktu"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              selectedTime != null
                  ? "✅ Waktu pengingat diset: ${selectedTime!.format(context)}"
                  : "❌ Belum memilih waktu",
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }
}
