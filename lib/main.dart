import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_app/src/cart/controller/cart_controller.dart';
import 'package:login_signup_app/src/home/constants/constraints.dart';
import 'package:login_signup_app/src/home/views/home_screen.dart';
import 'package:login_signup_app/src/authentication/views/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

void debugAuthState() {
  final user = FirebaseAuth.instance.currentUser;
  print(user != null
      ? 'User is logged in: ${user.email}'
      : 'No user is logged in');
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Auth',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSeed(
              seedColor: kPrimaryColor,
              primary: kPrimaryColor,
              secondary: kPrimartLightColor,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            textTheme: const TextTheme(
                titleMedium: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                bodyMedium: TextStyle(
                  fontSize: 18,
                )),
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              debugAuthState();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return const HomeScreen();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const WelcomeScreen();
              }
            },
          )
          // routes: {
          //   '/signup': (context) =>const SignupScreen(),
          // },

          ),
    );
  }
}
