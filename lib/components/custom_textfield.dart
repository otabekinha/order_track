import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.icon,
    this.textInputType,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  final TextEditingController controller;
  final IconData? icon;
  final TextInputType? textInputType;
  final String hintText;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: Colors.grey.shade600,
                size: 20,
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
