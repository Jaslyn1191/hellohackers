import 'package:flutter/material.dart';

class PharDashboardPage extends StatefulWidget {
  final String staffEmail;
  const PharDashboardPage({super.key, required this.staffEmail});

  @override
  State<PharDashboardPage> createState() => _PharDashboardPageState();
}

class _PharDashboardPageState extends State<PharDashboardPage> {
  bool _showPending = true;
  // Using List (Dart's equivalent of ArrayList) for dynamic arrays
  final List<CaseItem> pendingCases = [];
  final List<CaseItem> resolvedCases = [];

  // Example List operations (similar to ArrayList methods):
  // pendingCases.add(CaseItem(...)) - adds item
  // pendingCases.removeAt(index) - removes item at index
  // pendingCases.clear() - removes all items
  // pendingCases.length - gets size
  // pendingCases[index] - gets item at index

  @override
  Widget build(BuildContext context) {
    final casesToDisplay = _showPending ? pendingCases : resolvedCases;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/chat_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Header with title and logo
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Logo on left
                    Positioned(
                      left: 10,
                      top: 0,
                      child: Image.asset(
                        'assets/images/mediai_logo_noname.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Title centered
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 15,
                      child: Center(
                        child: Text(
                          'MediAI',
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'nextsunday',
                            color: Color(0xFF00796B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),

          // RecyclerView (ListView) for cases
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            bottom: 60,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: casesToDisplay.length,
              itemBuilder: (context, index) {
                final caseItem = casesToDisplay[index];
                return _buildCaseCard(caseItem);
              },
            ),
          ),

          // Buttons at bottom
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pending Cases button
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _showPending = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _showPending ? const Color(0xFF00796B) : Colors.grey[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Pending Cases',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Resolved Cases button
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _showPending = false),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_showPending ? const Color(0xFF00796B) : Colors.grey[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Resolved Cases',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaseCard(CaseItem caseItem) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            caseItem.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00796B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            caseItem.description,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text(
            'Date: ${caseItem.date}',
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

class CaseItem {
  final int id;
  final String title;
  final String description;
  final String date;

  CaseItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}
