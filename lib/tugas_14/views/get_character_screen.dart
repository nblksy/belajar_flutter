import 'package:belajar_flutter/tugas_14/views/detail_character.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/tugas_14/api/get_character.dart';
import 'package:belajar_flutter/tugas_14/models/character_models.dart';
import 'package:lottie/lottie.dart';

class Tugas14Flutter extends StatefulWidget {
  const Tugas14Flutter({super.key});

  @override
  State<Tugas14Flutter> createState() => _Tugas14FlutterState();
}

class _Tugas14FlutterState extends State<Tugas14Flutter> {
  late Future<List<GetCharacter>> futureCharacter;

  List<GetCharacter> allCharacter = [];
  List<GetCharacter> filteredCharacter = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCharacter = getCharacter();
  }

  Future<void> refreshData() async {
    final data = await getCharacter();
    setState(() {
      futureCharacter = Future.value(data);
      allCharacter = data;
      filteredCharacter = data;
    });
  }

  void filterSearch(String query) {
    final results = allCharacter.where((char) {
      final name = char.name?.toLowerCase() ?? "";
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCharacter = results;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: searchController,
        onChanged: filterSearch,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search character...",
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/animation/not_found.json", width: 200),
        const SizedBox(height: 10),
        const Text(
          "Data tidak ditemukan",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: filteredCharacter.length,
      itemBuilder: (context, index) {
        final char = filteredCharacter[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(character: char),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08), // 🔥 transparan
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    char.image ?? "",
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        char.name ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        "Status: ${char.status}",
                        style: TextStyle(
                          color: char.status == "Alive"
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),
                      ),

                      Text(
                        "Species: ${char.species}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.white54,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 🔥 biar nyatu
      appBar: AppBar(
        title: const Text(
          "Rick and Morty",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027), // biru gelap
              Color(0xFF203A43),
              Color(0xFF000000), // hitam
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: refreshData,
            child: FutureBuilder<List<GetCharacter>>(
              future: futureCharacter,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    allCharacter.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Terjadi error",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (snapshot.hasData && allCharacter.isEmpty) {
                  allCharacter = snapshot.data!;
                  filteredCharacter = allCharacter;
                }

                return Column(
                  children: [
                    const SizedBox(height: 10),
                    buildSearchBar(),

                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: filteredCharacter.isEmpty
                            ? buildEmptyState()
                            : buildList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
