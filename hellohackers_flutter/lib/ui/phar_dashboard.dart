import 'package:flutter/material.dart';
import 'package:hellohackers_flutter/core/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chat_background.png'),
            fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: [

                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 10,
                    ),
                    child: Image.asset(
                      'assets/images/mediai_logo_noname.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 70, top: 20),
                        child: Text(
                          'MediAI',
                          style: const TextStyle(
                            fontSize: 35,
                            fontFamily: 'nextsunday',
                            color: AppColors.darkTeal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Profile icon - UPDATED to navigate to full profile
                  GestureDetector(
                    onTap: () => _openAdminProf(),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 10),
                      child: Image.asset(
                        'assets/images/user_prof.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
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

  void _openAdminProf() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: AppColors.white,
        child: const Center(
          child: Text(
            'Log Out',
            style: TextStyle(fontSize: 18, color: AppColors.darkTeal),
          ),
        ),

      ));
  }

    void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/userLogin');
      }
    } catch (e) {
      _showErrorDialog('Error signing out:', "An unknown error occurred while signing out. Please try again.");
    }
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
