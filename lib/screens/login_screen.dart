import 'package:flutter/material.dart';
import 'package:order_track/components/login_button.dart';
import 'package:order_track/components/login_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 145, 218, 252),
              Color.fromARGB(255, 193, 233, 251),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 193, 235, 255)
                            .withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 6), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.login,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  'Sign In With Password',
                ),
                const SizedBox(height: 6),
                Text(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                  'Effortlessly manage & track orders from customers to the kitchen with real-time updates.',
                ),
                const SizedBox(height: 20),
                const LoginTextField(),
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoginButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
