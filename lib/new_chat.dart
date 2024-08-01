import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'chat.dart';
import 'home.dart';
import 'user.dart'; // Ensure this imports Profile class

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  _NewChatScreenState createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  bool isLoading = false; // 로딩 중 상태를 나타냄

  void _startNewChat(BuildContext context, Profile profile) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://223.130.141.98:3000/clova/newChatRoom'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userId": profile.userId,
          "profileId": profile.id,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chatRoomId = data['newChatRoomId'];

        // 새로운 채팅 방으로 이동
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(chatRoomId chatRoomId),
          ),
        );*/
      } else {
        throw Exception('새 채팅 방 생성 실패');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('새 채팅 시작 오류: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'images/chat_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 16,
            top: 60,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                          radius: 22,
                          child: ClipOval(
                            child: Image.asset(
                              "images/chat_profile.png",
                              fit: BoxFit.fill,
                              width: 44,
                              height: 44,
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
                        Navigator.pop(context);
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
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: userProvider.user?.profile.map((profile) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: () => _startNewChat(context, profile),
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
                                        Color(0x00ffffff),
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
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
