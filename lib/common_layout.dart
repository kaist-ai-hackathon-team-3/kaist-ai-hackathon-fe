// common_layout.dart
import 'package:flutter/material.dart';
import 'home.dart'; // HomePage import
import 'chat.dart'; // ChatScreen import
import 'profile.dart'; // ProfileScreen import

class CommonLayout extends StatefulWidget {
  final Widget body;
  final int selectedIndex;

  const CommonLayout({super.key, required this.body, required this.selectedIndex});

  @override
  _CommonLayoutState createState() => _CommonLayoutState();
}

class _CommonLayoutState extends State<CommonLayout> {
  void _onItemTapped(int index) {
    if (index != widget.selectedIndex) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(categories: [])),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          break;
      }
    }
  }

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
      body: widget.body,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF56B45F),
        currentIndex: widget.selectedIndex == -1 ? 0 : widget.selectedIndex,
        onTap: _onItemTapped,
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
}
