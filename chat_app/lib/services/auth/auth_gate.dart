import 'package:chat_app/pages/lobby.dart';
import 'package:chat_app/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// use this class to check if we are logged in or not

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          // list to stream FirebaseAuth and and any stream state changes
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // user is logged in
        if (snapshot.hasData) {
          return const Lobby();
        }
        // user is not logged in
        else {
          return const LoginOrRegister();
        }
      },
    )
    );
  }
}
