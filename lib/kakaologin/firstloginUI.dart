import 'package:ai/home_category.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/login_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Components
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sign Up Button
                Container(
                  width: 327,
                  height: 58,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 327,
                          height: 58,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF96D266),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        top: 0,
                        child: SizedBox(
                          width: 327,
                          height: 58,
                          child: Center(
                            child: Text(
                              'Sign up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                // Log In Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeCategoryScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 327,
                    height: 58,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 327,
                            height: 58,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFDFF8AC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 327,
                            height: 58,
                            child: Center(
                              child: Text(
                                'Log in',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
