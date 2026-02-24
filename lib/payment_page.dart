import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  Future<void> _processPayment(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Processing payment...'),
        backgroundColor: const Color(0xFF64B5F6), // Medium blue
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    await Future.delayed(const Duration(seconds: 2));
    
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Successful!'),
          content: const Text('Your prescription has been paid for. You will receive a confirmation shortly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(color: Color(0xFF64B5F6))),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF64B5F6), // Medium blue app bar
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF64B5F6).withValues(alpha: 0.1), // Medium blue tint
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Order Summary Card - Takes 60% of space
              Expanded(
                flex: 6,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with icon
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF64B5F6).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: Color(0xFF64B5F6),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Prescription Summary',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF64B5F6),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),

                        // Medicine Items - Make this section scrollable if needed
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                _buildMedicineItem(
                                  icon: Icons.medication,
                                  name: 'Paracetamol 500mg',
                                  dosage: '2 tablets • Once daily',
                                  price: '\$5.99',
                                ),
                                const SizedBox(height: 16),
                                
                                _buildMedicineItem(
                                  icon: Icons.medication_liquid,
                                  name: 'Vitamin C 1000mg',
                                  dosage: '1 tablet • Daily',
                                  price: '\$12.50',
                                ),
                                const SizedBox(height: 16),
                                
                                _buildMedicineItem(
                                  icon: Icons.medication,
                                  name: 'Consultation Fee',
                                  dosage: 'Pharmacist review',
                                  price: '\$0.00',
                                  isFree: true,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Total Section - Fixed at bottom
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '\$18.49',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF64B5F6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Payment Methods Section - Takes 15% of space
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.payment, color: Color(0xFF64B5F6), size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Payment Methods',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPaymentMethod(
                            icon: Icons.credit_card,
                            label: 'Card',
                            isSelected: true,
                          ),
                          _buildPaymentMethod(
                            icon: Icons.account_balance_wallet,
                            label: 'Wallet',
                          ),
                          _buildPaymentMethod(
                            icon: Icons.qr_code_scanner,
                            label: 'QR Pay',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Pay Now Button - Fixed height
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _processPayment(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Pay Now',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Collect at Pharmacy Option
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Collect at Pharmacy'),
                      content: const Text(
                        'Your prescription will be ready for collection at the pharmacy. '
                        'Please bring your ID for verification.'
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF64B5F6),
                          ),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order placed for collection!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'I will collect and pay at pharmacy',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64B5F6),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMedicineItem({
    required IconData icon,
    required String name,
    required String dosage,
    required String price,
    bool isFree = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF64B5F6).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF64B5F6)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dosage,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isFree ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod({
    required IconData icon,
    required String label,
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF64B5F6).withValues(alpha: 0.1) : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? const Color(0xFF64B5F6) : Colors.black12,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isSelected ? const Color(0xFF64B5F6) : Colors.grey[600],
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? const Color(0xFF64B5F6) : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}