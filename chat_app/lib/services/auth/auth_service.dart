import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
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

      // sign user up
  }
