import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/pages/front_page.dart';
import 'package:projeto_dev_disp_mob/pages/profile_page.dart';
import 'package:projeto_dev_disp_mob/pages/trailslist_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _mainPageState();
}

class _mainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> list = [
    TrailsListPage(),
    Text(''),
    ProfilePage(),
  ];

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
      body: list[currentIndex],
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        onPressed: () {},
        child: const Icon(
          Icons.radio_button_checked_rounded,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        color: const Color(0xEFEFEFEF),
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.terrain_rounded), label: 'Trails'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.terrain_rounded), label: 'Record'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2), label: 'Profile'),
            ],
            onTap: (idx) {
              setState(() {
                currentIndex = idx == 1 ? currentIndex : idx;
              });
            },
          ),
        ),
      ),
    );
  }
}
