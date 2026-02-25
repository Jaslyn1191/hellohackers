import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hellohackers_flutter/core/colors.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final dobController = TextEditingController();
  int? _age;
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
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dobController.text = '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
        // calculate age
        final now = DateTime.now();
        int years = now.year - picked.year;
        if (now.month < picked.month || (now.month == picked.month && now.day < picked.day)) {
          years -= 1;
        }
        _age = years;
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
                const SizedBox(height: 20),

                // Logo
                Image.asset(
                  'assets/images/mediai_logo_noname.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),

                // App name
                const Text(
                  'MediAI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    fontFamily: 'nextsunday',
                    color: AppColors.white,
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
              Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Email:',
                                style: TextStyle(fontSize: 20, fontFamily: 'winterdraw'),

                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              color: AppColors.white,
                              child: TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 18),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter email',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                const SizedBox(height: 20),

                // Password label + input
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Password:',
                        style: TextStyle(fontSize: 20, fontFamily: 'winterdraw'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      color: AppColors.white,
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
            ),
            const SizedBox(height: 10),

            Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 60,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Date of Birth:',
                              style: TextStyle(fontSize: 18, fontFamily: 'winterdraw', color: AppColors.black),
                            ),
                          ),
                        ),


                        const SizedBox(width: 16),
                        SizedBox(
                          width: 220,
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              color: AppColors.white,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: dobController,
                                      style: const TextStyle(fontSize: 18),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Select date',
                                      ),
                                      focusNode: AlwaysDisabledFocusNode(),
                                    ),
                                  ),
                                  const Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),

                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Back Button
                SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal700,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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