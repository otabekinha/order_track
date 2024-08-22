import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_track/screens/pos_screen.dart';

class KDSScreen extends StatefulWidget {
  const KDSScreen({super.key});

  @override
  State<KDSScreen> createState() => _KDSScreenState();
}

class _KDSScreenState extends State<KDSScreen> {
  void _toggleOrderStatus(String orderId, String currentStatus) async {
    final newStatus = currentStatus == 'completed' ? 'pending' : 'completed';

    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .update({
        'status': newStatus,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order status updated to $newStatus!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update order: $e')),
      );
    }
  }

  void _deleteOrder(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete order: $e')),
      );
    }
  }

  Widget _buildOrderList(List<DocumentSnapshot> orders, String statusFilter) {
    final filteredOrders =
        orders.where((order) => order['status'] == statusFilter).toList();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Text(
            'No ${statusFilter == 'pending' ? 'pending' : 'completed'} orders available.'),
      );
    }

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        final orderId = order.id;
        final itemName = order['item_name'];
        final quantity = order['quantity'];
        final price = order['price'];
        final status = order['status'];

        return ListTile(
          title: Text('$itemName (x$quantity)'),
          subtitle: Text('Price: \$${price.toStringAsFixed(2)}'),
          trailing: PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _toggleOrderStatus(orderId, status);
                  },
                  child: Text(status == 'completed'
                      ? 'Mark as Pending'
                      : 'Mark as Completed'),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteOrder(orderId);
                  },
                  child: const Text('Delete'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordered Items'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const POSScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 28),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data?.docs ?? [];

          return Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Pending Orders',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: _buildOrderList(orders, 'pending'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Completed Orders',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: _buildOrderList(orders, 'completed'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
