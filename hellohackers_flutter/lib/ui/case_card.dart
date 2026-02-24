import 'package:flutter/material.dart';

class CaseCard extends StatelessWidget {
  final String caseId;
  final String status;

  const CaseCard({
    super.key,
    required this.caseId,
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

        // ✅ Stroke (like android border)
        border: Border.all(
          color: Colors.grey, // change color if you want
          width: 2,
        ),

        // ✅ Shadow (like card elevation)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caseId,
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