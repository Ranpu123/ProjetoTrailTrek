import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/pages/profile_page.dart';
import 'package:projeto_dev_disp_mob/pages/record_trail_page.dart';
import 'package:projeto_dev_disp_mob/pages/trailslist_page.dart';
import 'package:projeto_dev_disp_mob/services/Auth/auth_service.dart';
import 'package:provider/provider.dart';

import 'package:projeto_dev_disp_mob/pages/save_location_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<String> names = ["Trails", "", "Profile"];
  List<IconData> icons = [Icons.terrain, Icons.terrain, Icons.person_2];
  List<Widget> list = const [
    TrailsListPage(),
    Text(''),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    userController.login(context.read<AuthService>().usuario!.uid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: Icon(
          icons[currentIndex],
        ),
        title: Text(
          names[currentIndex],
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: list[currentIndex],
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveLocationPage()),
          );
        },
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
