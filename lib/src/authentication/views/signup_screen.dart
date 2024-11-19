import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup_app/src/authentication/services/auth_services.dart';
import 'package:login_signup_app/src/home/widgets/rounded_button.dart';
import 'package:login_signup_app/src/home/constants/constraints.dart';
import 'package:login_signup_app/src/home/widgets/error_message.dart';
import 'package:login_signup_app/src/home/views/home_screen.dart';
import 'package:login_signup_app/src/authentication/views/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  void signUp() async {
    String res = await AuthServices().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // print(res);
    if (res == 'success' && mounted) {
      Navigator.pop(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
      return;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SIGN UP",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Color.fromARGB(255, 84, 48, 118)),
              ),
              const SizedBox(height: 30),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.32,
              ),
              const SizedBox(height: 30),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldContainer(
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            hintText: "Name",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (val) {
                            setState(() {
                              nameError = null;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                nameError = "Please enter your name";
                              });
                              return '';
                            } else if (!RegExp(
                                    r'(^[A-Za-z]{3,16})([ ]{0,1})([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})?([ ]{0,1})?([A-Za-z]{3,16})')
                                .hasMatch(value)) {
                              setState(() {
                                nameError = "Please enter a valid name";
                              });
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (nameError != null)
                        ErrorMessage(
                          errorMessage: nameError!,
                        ),
                      TextFieldContainer(
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: kPrimaryColor,
                            ),
                            hintText: "Email",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (val) {
                            setState(() {
                              emailError = null;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                emailError = "Please enter your email";
                              });
                              return '';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                              setState(() {
                                emailError = "Please enter a valid email";
                              });
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (emailError != null)
                        ErrorMessage(
                          errorMessage: emailError!,
                        ),
                      TextFieldContainer(
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            hintText: "Password",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              passwordError = null;
                            });
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              setState(() {
                                passwordError = "Please enter your password";
                              });
                              return "";
                            } else if (val.length < 6) {
                              setState(() {
                                passwordError =
                                    "Password must be at least 6 characters long";
                              });
                              return "";
                            }
                            return null;
                          },
                        ),
                      ),
                      if (passwordError != null)
                        ErrorMessage(
                          errorMessage: passwordError!,
                        ),
                      TextFieldContainer(
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            hintText: "Confirm Password",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                            suffixIcon: Icon(
                              Icons.visibility,
                              color: kPrimaryColor,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              confirmPasswordError = null;
                            });
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              setState(() {
                                confirmPasswordError =
                                    "Please enter your password";
                              });
                              return "";
                            } else if (val != passwordController.text) {
                              setState(() {
                                confirmPasswordError = "Passwords do not match";
                              });
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (confirmPasswordError != null)
                        ErrorMessage(
                          errorMessage: confirmPasswordError!,
                        ),
                    ],
                  )),
              const SizedBox(height: 5),
              RoundedButton(
                text: "Register",
                color: kPrimaryColor,
                textColor: Colors.white,
                press: () {
                  final isAllFieldsFilled =
                      formKey.currentState?.validate() ?? false;
                  if (isAllFieldsFilled) {
                    signUp();
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
                          builder: (context) => const LoginScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
  const TextFieldContainer({
    super.key,
    required this.child,
  });

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
              "assets/images/signup_top.png",
              height: size.height * 0.17,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              height: size.height * 0.15,
            ),
          ),
          child
        ],
      ),
    );
  }
}
