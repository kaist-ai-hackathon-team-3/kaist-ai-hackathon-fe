import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jungmal/new_chat.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'package:jungmal/message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'home.dart';

import 'dart:io'; // File 처리
import 'package:path_provider/path_provider.dart'; // Path 처리
import 'package:audioplayers/audioplayers.dart'; // Audio Player
import 'package:http/http.dart' as http; // HTTP 요청

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<Message> msgs = [];
  final List<Map<String, dynamic>> rooms = [];
  bool isTyping = false;
  String userName = "사용자";
  int chatRoomId = 0;
  int userId = 1;
  int profileId = 11;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _fetchChatRooms();
    _createNewChatRoom();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final response = await http.get(
        Uri.parse('http://223.130.141.98:3000/profile'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 201) {
        final profileData = json.decode(response.body);
        setState(() {
          userName = profileData['name'];
          userId = profileData['userId']; 
          profileId = profileData['id'];
        });
        print('Profile loaded: $userName, User ID: $userId, Profile ID: $profileId');
        await _fetchChatRooms(); // Fetch chat rooms after setting profile data
      } else {
        throw Exception('Failed to load profile info');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  Future<void> _fetchChatRooms() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user != null) {
      var userId = userProvider.user!.id; // userId 가져오기
      try {
        final response = await http.get(
          Uri.parse("http://223.130.141.98:3000/clova/rooms/${userProvider.user!.id}"),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          setState(() {
            rooms.clear();
            rooms.addAll(data
                .map((room) =>
                    {"id": room["id"], "roomTitle": room["roomTitle"]})
                .toList());
          });
        } else {
          throw Exception('Failed to load rooms');
        }
      } catch (e) {
        print('Error fetching rooms: $e');
      }
      setState(() {
        userName = userProvider.user!.username;
        userId = userProvider.user!.id;
      });
      print('User data loaded: $userName, User ID: $userId, Profile ID: $profileId');
      await _createNewChatRoom(); // Ensure that userId and profileId are set before calling this
    }
  }

  Future<void> _createNewChatRoom() async {
    try {
        /*if (userId == 0 || profileId == 0) {
        print('User ID or Profile ID is not set.');
        return;
      }*/
      print('새 채팅방 생성 중: /clova/newChatRoom/$userId/$profileId');
      var response = await http.get(
        Uri.parse("http://223.130.141.98:3000/clova/newChatRoom/$userId/$profileId"),
        headers: {"Content-Type": "application/json"},
      );

      print('새 채팅방 생성 응답 상태 코드: ${response.statusCode}');
      print('새 채팅방 생성 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          chatRoomId = json["newChatRoomId"];
        });
        print('새 채팅방 ID: $chatRoomId');
      } else {
        throw Exception('Failed to create new chat room');
      }
    } catch (e) {
      print('오류 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to create new chat room, please try again!")),
      );
    }
  }

  Future<void> _fetchChatRoomSummary() async {
    try {
      print('요청 전송 중: /clova/chatroom/$chatRoomId/summary');
      var response = await http.get(
        Uri.parse(
            "http://223.130.141.98:3000/clova/chatroom/$chatRoomId/summary"),
        headers: {"Content-Type": "application/json"},
      );

      print('API 응답 상태 코드: ${response.statusCode}');
      print('API 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          msgs.add(Message(
            false,
            json["content"].toString().trimLeft(),
          ));
        });
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
        print('채팅방 요약 생성 완료: ${json["content"]}');
      } else {
        throw Exception('Failed to get response from API');
      }
    } catch (e) {
      setState(() {
        isTyping = false;
      });
      print('오류 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some error occurred, please try again!")),
      );
    }
  }

  void sendMsg() async {
    String text = textEditingController.text;

    if (text.isEmpty || chatRoomId == 0) return; // chatRoomId가 0이면 반환
    textEditingController.clear();

    setState(() {
      msgs.add(Message(true, text));
      isTyping = true;
    });

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );

    try {
      print('메시지 전송 중: $text');
      var response = await http.post(
        Uri.parse("http://223.130.141.98:3000/clova/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "messages": text,
          "roomId": chatRoomId, // 추가된 필드
        }),
      );

      print('API 응답 상태 코드: ${response.statusCode}');
      print('API 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          isTyping = false;
          msgs.add(Message(
            false,
            json["content"].toString().trimLeft(),
          ));
        });
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
        print('응답 수신 완료: ${json["content"]}');
        if (msgs.length == 2) {
          // 사용자가 첫 대화를 보내고 나서 첫 번째 응답을 받은 후에만 요약 요청
          await _fetchChatRoomSummary();
        }
      } else {
        throw Exception('Failed to get response from API');
      }
    } catch (e) {
      setState(() {
        isTyping = false;
      });
      print('오류 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some error occurred, please try again!")),
      );
    }
  }

  // UI DESIGN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFADD77A),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 채팅방 목록을 나열합니다.
            ...rooms
                .map((room) => ListTile(
                      title: Text(room["roomTitle"]),
                      // onTap: () => _navigateToRoom(room["id"]),
                    ))
                .toList(),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            // 배경 사진
            child: Image.asset(
              "images/chat_bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Builder(
                      builder: (context) => GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: CircleAvatar(
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
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '$userName님의 대화 내역',
                        style: const TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewChatScreen()),
                        );
                      },
                    ),
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
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: BubbleNormal(
                        text: msgs[index].msg,
                        isSender: msgs[index].isSender,
                        color: msgs[index].isSender
                            ? Colors.grey.shade200 // grey
                            : const Color(0xFFE2EAD1), // light green bubble
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 10.0, 8.0, 7.0),
                          child: TextField(
                            controller: textEditingController,
                            textCapitalization: TextCapitalization.sentences,
                            onSubmitted: (value) => sendMsg(),
                            textInputAction: TextInputAction.send,
                            showCursor: true,
                            style: const TextStyle(
                              fontSize: 13.0, // 글씨 크기를 16으로 설정
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "정책 도움이 필요한 부분이나 궁금한 것을 물어보세요.",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: sendMsg,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB8DF88),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.blur_on_sharp, // 채팅 보내기 버튼
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
