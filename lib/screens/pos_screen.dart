import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_track/components/custom_button.dart';
import 'package:order_track/components/custom_textfield.dart';
import 'package:order_track/screens/kds_screen.dart';

class POSScreen extends StatefulWidget {
  const POSScreen({super.key});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _submitOrder() async {
    final itemName = _itemNameController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (itemName.isNotEmpty && quantity > 0 && price > 0) {
      try {
        await FirebaseFirestore.instance.collection('orders').add({
          'item_name': itemName,
          'quantity': quantity,
          'price': price,
          'status': 'pending', // Set initial status to "pending"
          'timestamp':
              FieldValue.serverTimestamp(), // Optional: to sort by time
        });

        // Clear input fields
        _itemNameController.clear();
        _quantityController.clear();
        _priceController.clear();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order submitted successfully!')),
        );

        // Navigate to KDS screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const KDSScreen(),
          ),
        );
      } catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit order: $e')),
        );
      }
    } else {
      // Validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields with valid values')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              textInputType: TextInputType.text,
              controller: _itemNameController,
              hintText: 'Item Name',
              obsecureText: false,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              textInputType: TextInputType.number,
              controller: _quantityController,
              hintText: 'Quantity',
              obsecureText: false,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              controller: _priceController,
              hintText: 'Price',
              obsecureText: false,
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Submit',
              onPressed: _submitOrder, // Call the submit method here
            ),
          ],
        ),
      ),
    );
  }
}
