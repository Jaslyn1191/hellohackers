import 'package:flutter/material.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
    }
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

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

                const SizedBox(height: 30),

                // Email label + input
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Email:',
                      style: TextStyle(fontSize: 18, fontFamily: 'winterdraw', color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.white,
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter email',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Password label + input
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Password:',
                      style: TextStyle(fontSize: 18, fontFamily: 'winterdraw', color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.white,
                        child: TextField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(fontSize: 16),
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

                const SizedBox(height: 18),

                // Date of Birth label + input
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Date of Birth:',
                      style: TextStyle(fontSize: 18, fontFamily: 'winterdraw', color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: TextField(
                            controller: dobController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Select date',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            focusNode: AlwaysDisabledFocusNode(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Back Button
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00796B),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom FocusNode that's always disabled for non-editable TextField
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}