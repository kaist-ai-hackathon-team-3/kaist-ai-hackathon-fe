import 'package:flutter/material.dart';
import 'common_layout.dart'; // CommonLayout import

class PolicyDetailScreen extends StatelessWidget {
  final String title;

  const PolicyDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      selectedIndex: -1, // 정책 상세 화면에서는 하단 내비게이션 바의 인덱스를 선택하지 않음
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE9F4E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/44x45"),
                              fit: BoxFit.fill,
                            ),
                            border: Border.all(
                                width: 0.5, color: const Color(0xFF949497)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '지자체 학자금대출',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _buildTag('현금'),
                                const SizedBox(width: 10),
                                _buildTag('해시태그'),
                                const SizedBox(width: 10),
                                _buildTag('현금'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'AI 3줄 요약',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            _buildSectionTitle('지원 대상'),
            const SizedBox(height: 20),
            _buildSectionTitle('지원 기간'),
            const SizedBox(height: 20),
            _buildSectionTitle('지원 내용'),
            const SizedBox(height: 20),
            _buildSectionTitle('관련 정보'),
            const SizedBox(height: 20),
            _buildSectionTitle('신청 방법'),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F6),
        border: Border.all(width: 0.5, color: const Color(0xFF949497)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20, // Increased font size from 18 to 20
        fontFamily: 'Poppins',
        fontWeight:
            FontWeight.bold, // Changed from FontWeight.w400 to FontWeight.bold
      ),
    );
  }
}
