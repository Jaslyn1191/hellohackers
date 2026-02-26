import 'package:flutter/material.dart';

class UserDashboardPage extends StatefulWidget {
  final String userEmail;

  const UserDashboardPage({super.key, required this.userEmail});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  final messageController = TextEditingController();
  final List<ChatMessage> messages = [];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  /// REMOVE HARDCODING
  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(ChatMessage(
          text: messageController.text,
          isUser: true,
        ));
        // Simulate bot response
        messages.add(ChatMessage(
          text: "Hi! I'm MediBot. How can I help you today?",
          isUser: false,
        ));
      });
      messageController.clear();
    }
  }

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
                    onTap: () => _showProfileMenu(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/mediai_logo_noname.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
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


                  GestureDetector(
                    onTap: () {}, //add on profile page route later
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

            // Chat Messages ListView
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
                      padding: const EdgeInsets.all(8),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return _buildChatBubble(message);
                      },
                    ),
            ),

            // Input area
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
                    onTap: _sendMessage,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00796B),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
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

  void _showProfileMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'User: ${widget.userEmail}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context); // Go back to login
              },
            ),
          ],
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
