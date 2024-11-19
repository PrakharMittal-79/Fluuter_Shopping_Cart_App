
import 'package:flutter/material.dart';
import 'package:login_signup_app/src/cart/views/cart_screen.dart';
import 'package:login_signup_app/src/product/views/shirts_screen.dart';
import 'package:login_signup_app/src/user/views/profilepage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // signout() async {
  //   await FirebaseAuth.instance.signOut();
  //   if (mounted) {
  //     Navigator.of(context).pushReplacement(
  //         MaterialPageRoute(builder: (context) => const WelcomeScreen()));
  //   }
  // }
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {

    List<Widget> pages = const [Homepage(),Cartpage(),Profilepage()];
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person_4_sharp), label: ""),
          ],
          iconSize: 32,
          currentIndex: currentPage,
          onTap: (val) {
            setState(() {
              currentPage = val;
            });
          },
          unselectedItemColor:const Color.fromARGB(255, 56, 53, 53),
          selectedFontSize: 0,
          unselectedFontSize: 0,
        ),
      ),
    );
  }
}
