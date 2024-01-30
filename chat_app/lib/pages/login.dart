import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({
    super.key,
    required this.onTap
    });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user
  void signIn() async {
    // Get the auth service
    // Import provider
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        // Get text of whatever is in controllers
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // The Column widget in Flutter is a layout widget that displays its children in a vertical array.
      // Each child is placed below the previous one along the vertical axis.
      //The children can be any widget like Text, Button, Image, etc.
      //The Column widget takes the full height available by default.
      //If you wrap it in a Scaffold widget like in your code, it will take the full height of the screen minus the app bar area.
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const SizedBox(height: 50),

                // logo
                Icon(Icons.message,
                size: 100,
                color: Colors.grey[800],
                ),

                const SizedBox(height: 50),

                //welcome back message
                const Text("Welcome back you have been missed!",
                style: TextStyle(
                  fontSize: 16,
                ),
                ),

                const SizedBox(height: 25),

                //email textField
                MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                ),

                const SizedBox(height: 10),

                //password
                MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(
                  onTap: signIn,
                  text: "Sign In"),

                //not a member? register now
                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
                ),
              ],
              ),
            ),
          ),
      )
    );
  }
}
