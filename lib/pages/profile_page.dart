import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
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
                        backgroundColor: Color.fromARGB(255, 230, 230, 230),
                        radius: 50,
                        child: CircleAvatar(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 45, left: 80),
                                child: Center(
                                  child: Icon(
                                    color: Colors.black,
                                    Icons.photo,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundImage:
                              const AssetImage('images/avatar.png'),
                          radius: 48,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8), // Espaço entre o avatar e o texto
                      Text(
                        "username",
                        style: TextStyle(
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
                      title: Text('My trails'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('My trails clicked');
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
                      title: Text('I want to go'),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          print('I want to go clicked');
                        },
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
