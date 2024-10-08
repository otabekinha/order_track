import 'package:flutter/material.dart';
import 'package:order_track/components/custom_button.dart';
import 'package:order_track/components/custom_textfield.dart';
import 'package:order_track/screens/kds_screen.dart';
import 'package:order_track/state/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final String loginPassword = '123123';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final loginProvider = context.read<LoginProvider>();
    final enteredPassword = _passwordController.text;
    _passwordController.clear();

    if (loginProvider.validatePassword(enteredPassword, loginPassword)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KDSScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loginProvider.errorMessage ?? 'An error occurred'),
        ),
      );
    }
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
                Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return CustomTextField(
                      hintText: 'Password',
                      obsecureText: !loginProvider.isPasswordVisible,
                      prefixIcon: Icons.lock,
                      controller: _passwordController,
                      suffixIcon: IconButton(
                        style: IconButton.styleFrom(
                          iconSize: 20,
                          foregroundColor: Colors.grey.shade600,
                        ),
                        onPressed: loginProvider.togglePasswordVisibility,
                        icon: Icon(
                          loginProvider.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    );
                  },
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
