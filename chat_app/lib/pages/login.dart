import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // The Column widget in Flutter is a layout widget that displays its children in a vertical array.
      // Each child is placed below the previous one along the vertical axis.
      //The children can be any widget like Text, Button, Image, etc.
      //The Column widget takes the full height available by default.
      //If you wrap it in a Scaffold widget like in your code, it will take the full height of the screen minus the app bar area.
      body: Column(
        children: [
        // logo

        //welcome back message

        //email textField

        //sign in button

        //not a member? register now
      ],)
    );
  }
}
