import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTrailsPage extends StatefulWidget {
  const MyTrailsPage({super.key});

  @override
  State<MyTrailsPage> createState() => _MyTrailsPage();
}

class _MyTrailsPage extends State<MyTrailsPage> {
  final List<Map<String, dynamic>> _allTrails = [
    {"id": 1, "username": "Trilha do morro da santa"},
    {"id": 2, "username": "Trilha do morro da santa"},
    {"id": 3, "username": "Trilha do morro da santa"},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundTrails = [];
  @override
  initState() {
    _foundTrails = _allTrails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: const Icon(
          Icons.terrain,
        ),
        title: Text(
          'Trails',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'My trails',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                height: 0.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: _foundTrails.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundTrails.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundTrails[index]["id"]),
                        color: Colors.white,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundTrails[index]["id"].toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black),
                          ),
                          title: Text(_foundTrails[index]['username'],
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
