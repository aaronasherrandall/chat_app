import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

class AuthService extends ChangeNotifier {
  // instance of auth to know if we are logged in or not
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // sign user in
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // sign in
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
        );

        // add a new document for the user in users collection if it doesn't already exit
        // sometimes we might manually create a user in the backend
        // let's make sure to merge this in that case
        _fireStore.collection('users').doc(userCredential.user!.uid).set({
            'uid' : userCredential.user!.uid,
            'email': email,
          },
          SetOptions(merge: true));

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

          // after creating a new user
          // create a document for the user in the user's collection
          _fireStore.collection('users').doc(userCredential.user!.uid).set({
            'uid' : userCredential.user!.uid,
            'email': email,
          });

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
