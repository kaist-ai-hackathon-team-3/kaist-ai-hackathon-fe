import 'package:flutter/material.dart';
import 'home_category.dart';

class HomePage extends StatelessWidget {
  final List<String> categories;

  const HomePage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // 검색 기능 구현
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 알림 기능 구현
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeCategoryScreen()),
                  );
                },
                child: Center(
                  child: Container(
                    width: 345,
                    height: 45,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF0F2F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '조건 검색',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF686A8A),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          letterSpacing: 0.34,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '새로 나온 정책',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  letterSpacing: 0.56,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 218.43,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    policyCard('소상공인 정책 지원', '2024.09~2024.11', '교육부',
                        'https://via.placeholder.com/192x108'),
                    policyCard('Crypto Art NFT', '6,510 Members', '교육부',
                        'https://via.placeholder.com/161x108'),
                    policyCard('Lord of the Rings', '1,050 Members', 'Movies',
                        'https://via.placeholder.com/267x108'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '내 주변 정책',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                  letterSpacing: 0.56,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 252.43,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    policyCard('정책 이름', '기간', '교육부',
                        'https://via.placeholder.com/150x108'),
                    policyCard('Crypto Insiders', '4,412 Members', '교육부',
                        'https://via.placeholder.com/162x108'),
                    policyCard('World News', '2,147 Members', 'News',
                        'https://via.placeholder.com/267x108'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF56B45F),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget policyCard(
      String title, String subtitle, String tag, String imageUrl) {
    return Container(
      width: 147,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 147,
            height: 108,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF303030),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.39,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF686A8A),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0.34,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(11),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Color(0xFF686A8A),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 1.5,
                letterSpacing: 0.34,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
