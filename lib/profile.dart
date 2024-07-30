import 'package:flutter/material.dart';
import 'common_layout.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      selectedIndex: 2,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 343,
                height: 162,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 343,
                        height: 162,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFE9F4E9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 163,
                      top: 99,
                      child: Text(
                        '프로필 수정',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF949497),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.6, // Text height 0.16에서 1.6으로 수정
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 163,
                      top: 68,
                      child: Text(
                        '간단한 계정정보',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5, // Text height 0.08에서 1.5으로 수정
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 163,
                      top: 31,
                      child: Text(
                        '이름',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.2, // Text height 0.04에서 1.2으로 수정
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 31,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFD9D9D9),
                          shape: OvalBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(
                width: 300,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Text(
                        '다른 프로필',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.2, // Text height 0.04에서 1.2으로 수정
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 25,
                      child: Text(
                        '가족, 친구, 연인에게 맞는 정책을 알아보세요! ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF949497),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5, // Text height 0.08에서 1.5으로 수정
                          letterSpacing: 0.28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 343,
                height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(context, '이름', '대충 특징'),
                    const SizedBox(height: 15),
                    _buildProfileCard(context, '이름', '대충 특징'),
                  ],
                ),
              ),
              SizedBox(
                width: 312,
                height: 45,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: 312,
                        height: 45,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFA2D462),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      child: Center(
                        child: Text(
                          '계정 추가',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                            letterSpacing: 0.45,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, String name, String details) {
    return SizedBox(
      width: 343,
      height: 85,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 343,
              height: 85,
              decoration: ShapeDecoration(
                color: const Color(0xFFE9F4E9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 21,
            top: 13,
            child: Container(
              width: 60,
              height: 60,
              decoration: const ShapeDecoration(
                color: Color(0xFFD9D9D9),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 95,
            top: 20,
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.2,
                letterSpacing: 0.28,
              ),
            ),
          ),
          Positioned(
            left: 97,
            top: 46,
            child: SizedBox(
              width: 130,
              height: 23,
              child: Text(
                details,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: 0.28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
