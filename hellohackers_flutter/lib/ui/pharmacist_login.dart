import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'forgot_password.dart';
import 'phar_dashboard.dart';

class PharmacistLoginPage extends StatefulWidget {
  const PharmacistLoginPage({super.key});

  @override
  State<PharmacistLoginPage> createState() => _PharmacistLoginPageState();
}

class _PharmacistLoginPageState extends State<PharmacistLoginPage> {
  final staffIdController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    staffIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Logo
              Image.asset(
                'assets/images/mediai_logo_noname.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 10),

              // App name
              const Text(
                'MediAI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 45,
                  fontFamily: 'nextsunday',
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Color(0xFF004D40),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Staff ID label + input
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Staff ID:',
                    style: TextStyle(fontSize: 20, fontFamily: 'winterdraw', color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.white,
                      child: TextField(
                        controller: staffIdController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter staff ID',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Password label + input with toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Password:',
                    style: TextStyle(fontSize: 20, fontFamily: 'winterdraw', color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.white,
                      child: TextField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00796B),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
              ),

              const Spacer(flex: 3),

              // Bottom links: left and right
              Padding(
                padding: EdgeInsets.symmetric(horizontal: (screenWidth - 320) / 2 < 0 ? 20 : (screenWidth - 320) / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                      ),
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(color: Color(0xFF1976D2), fontSize: 15),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'User Role Login',
                        style: TextStyle(color: Color(0xFF1976D2), fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    final staffId = staffIdController.text.trim();
    final password = passwordController.text.trim();

    if (staffId.isEmpty || password.isEmpty) {
      _showErrorDialog('Error', 'Please enter staff ID and password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Query Firestore to find staff member by staffId
      final QuerySnapshot querySnapshot = await _firestore
          .collection('pharmacists')
          .where('staffId', isEqualTo: staffId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        if (mounted) {
          _showErrorDialog('Error', 'Staff ID not found. Contact administrator.');
        }
        setState(() => _isLoading = false);
        return;
      }

      // Get the email from the staff document
      final staffDoc = querySnapshot.docs.first;
      final staffEmail = staffDoc['email'] as String?;

      if (staffEmail == null) {
        if (mounted) {
          _showErrorDialog('Error', 'Staff email not found in database.');
        }
        setState(() => _isLoading = false);
        return;
      }

      // Authenticate using email and password
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: staffEmail,
        password: password,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PharDashboardPage(staffEmail: staffEmail),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed';
      if (e.code == 'user-not-found') {
        errorMessage = 'Staff account not found. Contact administrator.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password. Try again.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      }
      if (mounted) {
        _showErrorDialog('Login Error', errorMessage);
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Error', 'An error occurred: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
}
