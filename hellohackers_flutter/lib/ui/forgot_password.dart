import 'package:flutter/material.dart';
import 'package:hellohackers_flutter/core/colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      color: AppColors.darkTeal,
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Email label + input
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Email:',
                    style: TextStyle(fontSize: 20, fontFamily: 'winterdraw', color: AppColors.black),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(right: 20),
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

              const SizedBox(height: 30),

              // Next Button
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {}, //to add pop up for email sent confirmation
                  //: isLoading ? null: _nextstep
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal700,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18, color: AppColors.white),
                  ),
                ),
              ),

              const Spacer(flex: 3),

              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.teal700,
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              //     ),
              //     child: _isLoading
              //         ? const SizedBox(
              //             width: 20,
              //             height: 20,
              //             child: CircularProgressIndicator(
              //               strokeWidth: 2,
              //               valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              //             ),
              //           )
              //         : const Text(
              //             'Login',
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //               color: AppColors.white,
              //             ),
              //           ),
              //   ),
              // ),

              // Back Button
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 12),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.teal700,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: const Text(
                        'Back',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}