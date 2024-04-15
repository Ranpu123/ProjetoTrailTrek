import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/pages/front_page.dart';
import 'package:projeto_dev_disp_mob/services/Trail/local_trails_repository.dart';
import 'package:projeto_dev_disp_mob/services/User/local_user_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserController(LocalUserRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => TrailController(LocalTrailRepository()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FirstPage(),
    );
  }
}
