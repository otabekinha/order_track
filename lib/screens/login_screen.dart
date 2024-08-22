import 'package:flutter/material.dart';
import 'package:order_track/components/custom_button.dart';
import 'package:order_track/components/custom_textfield.dart';
import 'package:order_track/screens/kds_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final String loginPassword = '123123';
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final enteredPassword = _passwordController.text;
    _passwordController.clear();

    if (enteredPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a password'),
        ),
      );
    } else if (enteredPassword == loginPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KDSScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect password. Please try again.'),
        ),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

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
                CustomTextField(
                  hintText: 'Password',
                  obsecureText: !_isPasswordVisible,
                  prefixIcon: Icons.lock,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                    style: IconButton.styleFrom(
                      iconSize: 20,
                      foregroundColor: Colors.grey.shade600,
                    ),
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Get started',
                  onPressed: _onLoginPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
