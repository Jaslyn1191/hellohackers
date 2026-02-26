import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api-cqohnaeeea-uc.a.run.app/chat';

  /// Send a message to your AI backend
  static Future<String> sendMessage(String message) async {
    // Generate a unique session key for each user
    String sessionKey = 'user123'; // You can make this dynamic later

    // Prepare JSON payload
    Map<String, dynamic> payload = {
      'chat': message,
      'sessionKey': sessionKey,
    };

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['reply'] ?? "No reply from AI";
      } else {
        print('Server error: ${response.statusCode}');
        return "Server error";
      }
    } catch (e) {
      print('Error sending message: $e');
      return "Error sending message";
    }
  }
}



