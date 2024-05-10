import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/pages/iwanttogo_page.dart';
import 'package:projeto_dev_disp_mob/pages/mytrails_page.dart';
import 'package:projeto_dev_disp_mob/services/Auth/auth_service.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  //final User user;
  //const ProfilePage({super.key, required this.user});
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                        ),
                      ],
                      image: DecorationImage(
                        image: const AssetImage(
                          "assets/images/background.png",
                        ), // <-- BACKGROUND IMAGE
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.1), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 230, 230, 230),
                        radius: 50,
                        child: CircleAvatar(
                          backgroundImage:
                              const AssetImage('images/avatar.png'),
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: Stack(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 45, left: 80),
                                child: const Center(
                                  child: Icon(
                                    color: Colors.black,
                                    Icons.photo,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Espaço entre o avatar e o texto
                      Text(
                        userController.loggedUser!.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: const Text('My trails'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyTrailsPage()),
                          );
                        },
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      title: const Text('I want to go'),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const IWantToGoPage()),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 16), // Add some space before the logout button
                  // Logout button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Call the signOut method from your authentication service
                      Provider.of<AuthService>(context, listen: false).logout();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor: MaterialStateProperty.all(Colors.red[100]),
                      elevation: MaterialStateProperty.all(1),
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.red,
                    ),
                    label: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
