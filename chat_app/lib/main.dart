import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:flutter/material.dart';

import 'services/login_or_register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
    );
  }
}
