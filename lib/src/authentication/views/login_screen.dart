import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup_app/src/authentication/services/auth_services.dart';
import 'package:login_signup_app/src/home/widgets/rounded_button.dart';
import 'package:login_signup_app/src/home/constants/constraints.dart';
import 'package:login_signup_app/src/home/widgets/error_message.dart';
import 'package:login_signup_app/src/home/views/home_screen.dart';
import 'package:login_signup_app/src/authentication/views/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    super.key,
  });

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  signin() async {
    String res = await AuthServices().loginUser(
        email: emailController.text, password: passwordController.text);
    if (res == 'success' && mounted) {
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 84, 48, 118)),
              ),
              const SizedBox(height: 30),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.32,
              ),
              const SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldContainer(
                      child: TextFormField(
                          autofocus: true,
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            hintText: "Email",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (val) {
                            setState(
                              () {
                                emailError = null;
                              },
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                emailError = "Please enter your email";
                              });
                              return "";
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                              setState(() {
                                emailError = 'Please enter a valid email';
                              });
                              return "";
                            }
                            return null;
                          }),
                    ),
                    if (emailError != null)
                      ErrorMessage(errorMessage: emailError!),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.password_sharp,
                            color: kPrimaryColor,
                          ),
                          hintText: "Password",
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          suffixIcon: Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                        ),
                        onChanged: (val) {
                          setState(
                            () {
                              passwordError = null;
                            },
                          );
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            setState(() {
                              passwordError = "Please enter the password";
                            });
                            return "";
                          } else if (val.length < 6) {
                            setState(() {
                              passwordError =
                                  'Password must be at least 6 characters long';
                            });
                            return "";
                          }
                          return null;
                        },

                      ),
                    ),
                    if (passwordError != null)
                      ErrorMessage(errorMessage: passwordError!)
                  ],
                ),
              ),
              const SizedBox(height: 5),
              RoundedButton(
                text: "Login",
                color: kPrimaryColor,
                textColor: Colors.white,
                press: () {
                  if (formKey.currentState!.validate()) {
                    signin();
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimartLightColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              height: size.height * 0.2,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              height: size.height * 0.15,
            ),
          ),
          child
        ],
      ),
    );
  }
}

