import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/pages/front_page.dart';
import 'package:projeto_dev_disp_mob/pages/main_page.dart';
import 'package:projeto_dev_disp_mob/services/Auth/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return const FirstPage();
    } else {
      return const MainPage();
    }
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
