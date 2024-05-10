import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/services/Auth/auth_service.dart';
import 'package:projeto_dev_disp_mob/services/Trail/local_trails_repository.dart';
import 'package:projeto_dev_disp_mob/services/Trail/remote_trails_repository.dart';
import 'package:projeto_dev_disp_mob/services/User/remote_user_repository.dart';
import 'package:projeto_dev_disp_mob/widget/auth_check.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserController(RemoteUserRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => TrailController(RemoteTrailsRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
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
      home: const AuthCheck(),
    );
  }
}
