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
        child: SafeArea( // 🔥 prevents overflow on top
          child: Column(
            children: [

              // ================= HEADER =================
              Container(
                height: 80,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // Logo
                    Image.asset(
                      'assets/images/mediai_logo_noname.png',
                      width: 60,
                      height: 60,
                    ),

                    const SizedBox(width: 10),

                    // App Name
                    const Expanded(
                      child: Center(
                        child: Text(
                          'MediAI',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'nextsunday',
                            color: AppColors.darkTeal,
                          ),
                        ),
                      ),
                    ),

                    // Profile Icon
                    GestureDetector(
                      onTap: _openAdminProf,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/user_prof.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ================= LIST SECTION =================
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: casesToDisplay.length,
                  itemBuilder: (context, index) {
                    final caseItem = casesToDisplay[index];
                    return _buildCaseCard(caseItem);
                  },
                ),
              ),

              // ================= BOTTOM BUTTONS =================
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _showPending = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _showPending ? const Color(0xFF00796B) : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Pending Cases',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => setState(() => _showPending = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              !_showPending ? const Color(0xFF00796B) : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Resolved Cases',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
