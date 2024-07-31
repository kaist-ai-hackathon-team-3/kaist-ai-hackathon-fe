import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'chat.dart';
import 'home.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/chat_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 16,
            top: 60,
            right: 16, // Add right padding to balance the layout
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white.withOpacity(0),
                      child: ClipOval(
                        child: Container(
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFE3E4E5)),
                            ),
                          ),
                          child: const Icon(Icons.person, size: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${userProvider.user?.username}님의 새 채팅',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF202325),
                        fontSize: 16,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage(categories: [])),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            top: 254,
            right: 15,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                  child: Text(
                    '새 채팅을 시작하세요 👋',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150, // 여유 공간을 주기 위해 높이를 설정합니다.
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: userProvider.user?.profile.map((profile) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () {
                                  // 채팅 시작 로직을 여기에 추가합니다.
                                },
                                child: Container(
                                  width: 117,
                                  height: 170,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 13),
                                  decoration: ShapeDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment(0.00, -1.00),
                                      end: Alignment(0, 1),
                                      colors: [
                                        Color(0xFFBFDDA7),
                                        Color(0x00C4C4C4)
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x3F000000),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 87,
                                        height: 87,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 23, vertical: 20),
                                        decoration: ShapeDecoration(
                                          color: const Color(0x9BFDFDFD),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(47.50),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x19000000),
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            profile.name[0],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Color(0xFF686A8A),
                                              fontSize: 35,
                                              fontFamily: 'Noto Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Flexible(
                                        child: Text(
                                          profile.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Noto Sans',
                                            fontWeight: FontWeight.w700,
                                            height: 1.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList() ??
                          [],
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
