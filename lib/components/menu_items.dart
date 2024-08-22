import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const Text('Pending'),
        ),
        Container(
          child: const Text('Delete'),
        ),
      ],
    );
  }
}