// ignore_for_file: use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/services/Auth/auth_service.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  register(String email, String passwd, String username) async {
    try {
      await context.read<AuthService>().register(email, passwd);

      if (context.read<AuthService>().usuario != null) {
        await context.read<UserController>().registerUser(
            context.read<AuthService>().usuario!.uid, username, passwd, email);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to register the user.")));
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final usernamecontroller = TextEditingController();
    final signupForm = GlobalKey<FormState>();
    final emailcontroller = TextEditingController();
    final passwordcontroller = TextEditingController();

    return Stack(
      children: [
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
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 50.0, left: 30.0, right: 30.0, bottom: 30.0),
              child: Container(
                decoration: const BoxDecoration(
                    //backgroundBlendMode: BlendMode.exclusion,
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sign up',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 48.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Form(
                          key: signupForm,
                          child: Column(
                            children: [
                              TextFormField(
                                //username
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white),
                                    //labelText: 'E-mail',
                                    hintText: 'Username',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.5))),
                                controller: usernamecontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field can\'t be empty.';
                                  } else {
                                    bool isValid = User.validateUsername(value);
                                    if (!isValid) {
                                      return 'Invalid username!';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                //email
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white),
                                    //labelText: 'Password',
                                    hintText: 'E-mail',
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 5))),
                                controller: emailcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field can\'t be empty.';
                                  } else {
                                    bool isValid = User.validateEmail(value);
                                    if (!isValid) {
                                      return 'Invalid Email! Try something like example@example.com';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                // password
                                obscureText: true,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white),
                                    //labelText: 'Password',
                                    hintText: 'Password',
                                    prefixIcon: Icon(Icons.lock_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 5))),
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field can\'t be empty.';
                                  }
                                  return null;
                                },
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'The password must be at least 8 characters long.',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                //confirm password
                                obscureText: true,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white),
                                    //labelText: 'Password',
                                    hintText: 'Confirm password',
                                    prefixIcon: Icon(Icons.lock_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 5))),
                                //controller: passwordcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field can\'t be empty.';
                                  } else {
                                    bool isValid = User.validateNewPassword(
                                      passwordcontroller.text,
                                      value,
                                    );
                                    if (isValid == false) {
                                      return 'The passwords don\'t match. Please try again';
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (signupForm.currentState!
                                            .validate()) {
                                          register(
                                            emailcontroller.text,
                                            passwordcontroller.text,
                                            usernamecontroller.text,
                                          );
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 23),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      child: const Text('Create account')),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
