import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KDSScreen extends StatefulWidget {
  const KDSScreen({super.key});

  @override
  State<KDSScreen> createState() => _KDSScreenState();
}

class _KDSScreenState extends State<KDSScreen> {
  void _markAsCompleted(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({
        'status': 'completed',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order marked as completed!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordered Items'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders available.'),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order.id;
              final itemName = order['item_name'];
              final quantity = order['quantity'];
              final price = order['price'];
              final status = order['status'];

              return ListTile(
                title: Text('$itemName (x$quantity)'),
                subtitle: Text('Price: \$${price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(
                    status == 'completed' ? Icons.check_circle : Icons.pending,
                    color: status == 'completed' ? Colors.green : Colors.orange,
                  ),
                  onPressed: () {
                    if (status != 'completed') {
                      _markAsCompleted(orderId);
                    }
                  },
                ),
                onTap: () {
                  if (status != 'completed') {
                    _markAsCompleted(orderId);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
