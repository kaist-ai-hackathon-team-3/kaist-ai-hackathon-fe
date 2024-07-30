import 'package:flutter/material.dart';
import 'common_layout.dart'; // CommonLayout import

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/100'),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'John Doe',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text('john.doe@example.com'),
            ),
            const ListTile(
              leading: Icon(Icons.phone),
              title: Text('+123 456 7890'),
            ),
            const ListTile(
              leading: Icon(Icons.location_city),
              title: Text('123 Main Street, City, Country'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 로그아웃 기능 구현
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      selectedIndex: 2,
    );
  }
}
