
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = "Some error occured";
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
