import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat_service.dart';
import 'ui/case_detailed_view.dart';

class CasePage extends StatelessWidget {
  const CasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pending Cases')),
      body: StreamBuilder<QuerySnapshot>(
        stream: ChatService.getPendingCasesForPharmacist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending cases'));
          } else {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(data['caseID'] ?? ''),
                    subtitle: Text(data['lastMessage'] ?? ''),
                    trailing: Text(data['status'] ?? ''),
                    onTap: () {
                      // Navigate to case detailed view
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CaseDetailedView(caseId: data['caseID']),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}