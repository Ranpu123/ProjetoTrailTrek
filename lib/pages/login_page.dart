import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:projeto_dev_disp_mob/pages/main_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Verifica se o usuário logado já foi inicializado
      final userController =
          Provider.of<UserController>(context, listen: false);

      if (userController.loggedUser != null) {
        // Se o usuário já estiver logado, navegue para a MainPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UserController>(context);

    final loginForm = GlobalKey<FormState>();
    final emailcontroller = TextEditingController();
    final passwordcontroller = TextEditingController();

    return Stack(
      children: [
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
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 15.0, right: 15.0, bottom: 30.0),
              child: Container(
                decoration: const BoxDecoration(
                    //backgroundBlendMode: BlendMode.exclusion,
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 48.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Form(
                          key: loginForm,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white),
                                    labelText: 'E-mail',
                                    hintText: 'Enter your e-mail',
                                    prefixIcon: Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.5))),
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
                              const SizedBox(height: 25),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    floatingLabelStyle: TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white),
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
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
                                    'Forgot your password?',
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 80),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (loginForm.currentState!
                                            .validate()) {
                                          usersProvider
                                              .login(emailcontroller.text,
                                                  passwordcontroller.text)
                                              .then((value) {
                                            if (value) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MainPage()),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Invalid email or password. Please try again.'),
                                                ),
                                              );
                                            }
                                          });
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      child: const Text('Login')),
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
