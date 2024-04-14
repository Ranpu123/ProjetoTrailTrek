import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/pages/login_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(color: Colors.white),
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(
              "assets/images/background.png",
            ), // <-- BACKGROUND IMAGE
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 8.0, right: 8.0, bottom: 8.0),
              // ignore: avoid_unnecessary_containers
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'TrailTrek',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 48.0,
                          height: 0.0,
                        ),
                      ),
                      Text(
                        'Connect&Share',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w300,
                          fontSize: 32.0,
                          height: 0.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Go beyond the horizon',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          height: 0.0,
                        ),
                      ),
                      Text(
                        'Embark on your next adventure with ease '
                        'using our app designed exclusively for adventurers.',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0,
                          height: 0.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black87,
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              child: const Text('Sign-in'))),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              child: const Text('Login'))),
                    ],
                  )
                ],
              )),
        ),
      ),
    ]);
  }
}
