import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellohackers_flutter/core/colors.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  Future<void> _processPayment(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to continue'), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      final orderData = {
        'userId': user.uid,
        'userEmail': user.email,
        'items': [
          {'name': 'Paracetamol 500mg', 'price': 5.99, 'dosage': '2 tablets • Once daily'},
          {'name': 'Vitamin C 1000mg', 'price': 12.50, 'dosage': '1 tablet • Daily'},
        ],
        'totalAmount': 18.49,
        'status': 'paid',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance.collection('orders').add(orderData);

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Payment Successful!'),
            content: const Text('Your order has been placed.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: TextStyle(color: AppColors.lightBlue)),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.lightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          children: const [
                            ListTile(
                              leading: Icon(Icons.medication, color: AppColors.lightBlue),
                              title: Text('Paracetamol 500mg'),
                              subtitle: Text('2 tablets • Once daily'),
                              trailing: Text('\$5.99'),
                            ),
                            ListTile(
                              leading: Icon(Icons.medication_liquid, color: AppColors.lightBlue),
                              title: Text('Vitamin C 1000mg'),
                              subtitle: Text('1 tablet • Daily'),
                              trailing: Text('\$12.50'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('\$18.49', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _processPayment(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Pay Now', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}