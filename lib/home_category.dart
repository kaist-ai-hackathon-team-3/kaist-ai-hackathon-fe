import 'package:flutter/material.dart';
import 'home.dart'; // 홈 페이지 import

class HomeCategoryScreen extends StatefulWidget {
  const HomeCategoryScreen({super.key});

  @override
  _HomeCategoryScreenState createState() => _HomeCategoryScreenState();
}

class _HomeCategoryScreenState extends State<HomeCategoryScreen> {
  final List<String> _selectedCategories = [];

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        if (_selectedCategories.length < 3) {
          _selectedCategories.add(category);
        }
      }
    });
  }

  void _viewPolicies() {
    if (_selectedCategories.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(_selectedCategories),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  '관심있는 정책 분야를 선택하세요',
                  style: TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: 0.56,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Wrap(
                      spacing: 40.0,
                      runSpacing: 20.0,
                      children: [
                        policyCategory(
                          context,
                          'images/home_category_생활.png',
                          '생활, 안정',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_주거.png',
                          '주거, 자립',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_고용.png',
                          '고용, 창업',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_보건.png',
                          '보건, 의료',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_행정.png',
                          '행정, 안전',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_임신.png',
                          '임신, 출산',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_보호.png',
                          '보호, 돌봄',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_문화.png',
                          '문화, 환경',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_농축어업.png',
                          '농/축/어업',
                        ),
                        policyCategory(
                          context,
                          'images/home_category_기타.png',
                          '기타',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 312,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA2D462),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _viewPolicies,
                    child: const Text(
                      '정책 보기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        letterSpacing: 0.45,
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

  Widget policyCategory(BuildContext context, String imagePath, String text) {
    return GestureDetector(
      onTap: () => _toggleCategory(text),
      child: Container(
        width: 115,
        height: 120, // 텍스트를 포함한 높이 조정
        decoration: BoxDecoration(
          color: const Color(0xFFF6F5FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedCategories.contains(text)
                ? Colors.blue
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 61,
              height: 68,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF303030),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.5,
                letterSpacing: 0.56,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
