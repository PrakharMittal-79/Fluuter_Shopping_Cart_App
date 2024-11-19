import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signup_app/src/home/widgets/background.dart';
import 'package:login_signup_app/src/home/widgets/rounded_button.dart';
import 'package:login_signup_app/src/home/constants/constraints.dart';
import 'package:login_signup_app/src/authentication/views/login_screen.dart';
import 'package:login_signup_app/src/authentication/views/signup_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome To My App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.4,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              RoundedButton(
                text: "LOGIN",
                color: kPrimaryColor,
                textColor: Colors.white,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen(),),);
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kPrimartLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
