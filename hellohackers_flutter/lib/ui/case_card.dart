import 'package:flutter/material.dart';
import 'package:hellohackers_flutter/core/colors.dart';

class CaseCard extends StatelessWidget {
  final String case_id;
  final String status;

  const CaseCard({
    super.key,
    required this.case_id,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: AppColors.ashBlue,
          width: 2,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            case_id,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            status,
            style: TextStyle(
              fontSize: 14,
              color: status == "Resolved"
                  ? Colors.green
                  : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}