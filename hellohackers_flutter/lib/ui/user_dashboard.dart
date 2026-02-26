import 'dart:isolate';
import 'package:hellohackers_flutter/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:hellohackers_flutter/api_service.dart';
import 'package:hellohackers_flutter/ui/profile_page.dart'; // Add your profile page
import 'package:hellohackers_flutter/ui/payment_page.dart'; // Add your payment page
import 'package:firebase_auth/firebase_auth.dart'; // Add for auth

class UserDashboardPage extends StatefulWidget {
  final String userEmail;

  const UserDashboardPage({super.key, required this.userEmail});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String responseText = "";
  bool _isLoading = false;

  final List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
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
            // Header
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
                  // Menu button
                  GestureDetector(
                    onTap: () => _showMenu(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Icon(
                        Icons.menu,
                        color: AppColors.darkTeal,
                        size: 28,
                      ),
                    ),
                  ),
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
                    onTap: () => _navigateToProfile(),
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

            // Chat Messages ListView (rest of your existing code remains the same)
            Expanded(
              child: messages.isEmpty
                  ? Center(
                      child: Text(
                        'Start chatting with MediBot!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return _buildChatBubble(message);
                      },
                    ),
            ),

            // Input area (your existing code)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: messageController,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Send a message',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () async {
                      String userMessage = messageController.text;
                      setState(() {
                        messages.add(ChatMessage(
                          text: messageController.text,
                          isUser: true,
                        ));
                        _isLoading = true;
                      });
                      messageController.clear();
                      _scrollToBottom();

                      String aiReply = await ApiService.sendMessage(userMessage);
                      setState(() {
                        messages.add(ChatMessage(text: aiReply, isUser: false));
                        _isLoading = false;
                      });
                      _scrollToBottom();
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: AppColors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Container(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: message.isUser ? const Color(0xFF00796B) : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Text(
          message.text,
          style: TextStyle(
            fontSize: 15,
            color: message.isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  void _showMenu() {
    // You can add menu items here later
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.payment, color: AppColors.lightBlue),
              title: const Text('Make a Payment'),
              onTap: () {
                Navigator.pop(context);
                _navigateToPayment();
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.lightBlue),
              title: const Text('Order History'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon('Order History');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: AppColors.lightBlue),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
                _showComingSoon('Help & Support');
              },
            ),
          ],
        ),
      ),
    );
  }

  // NEW: Navigate to full profile page
  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  // NEW: Navigate to payment page
  void _navigateToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentPage(),
      ),
    );
  }

  // Helper for showing coming soon features
  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature coming soon!'),
        backgroundColor: AppColors.lightBlue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Keep the existing bottom sheet as an alternative access point
  void _showProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              
              // User info
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.lightBlue,
                child: Text(
                  widget.userEmail[0].toUpperCase(),
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.userEmail,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Options
              ListTile(
                leading: const Icon(Icons.person, color: AppColors.lightBlue),
                title: const Text('View Full Profile'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToProfile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment, color: AppColors.lightBlue),
                title: const Text('Make a Payment'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToPayment();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout'),
                onTap: () async {
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/userLogin');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}