import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService extends ChangeNotifier {
  // instance of auth to know if we are logged in or not
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // sign user in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // sign in
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
        );

        return userCredential;
      }
      // catch any errors
      on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }

    }

    // create a new user
    // we just need an email and a password to create a user
    Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
      try {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
          );

          return userCredential;
      } on FirebaseAuthException catch (e) {
        throw Exception(e.code);
      }
    }

    // sign user out
    Future<void> signOut() async {
      return await FirebaseAuth.instance.signOut();
    }
}
