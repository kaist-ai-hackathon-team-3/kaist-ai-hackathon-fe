import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'package:jungmal/message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';

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
        await _fetchChatRooms();
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
      var userId = userProvider.user!.id;
      try {
        final response = await http.get(
          Uri.parse("http://223.130.141.98:3000/clova/rooms/${userProvider.user!.id}"),
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          setState(() {
            rooms.clear();
            rooms.addAll(data.map((room) => {"id": room["id"], "roomTitle": room["roomTitle"]}).toList());
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
      await _createNewChatRoom();
    }
  }

  Future<void> _createNewChatRoom() async {
    try {
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
        const SnackBar(content: Text("Failed to create new chat room, please try again!")),
      );
    }
  }

  Future<void> _fetchChatRoomSummary() async {
    try {
      print('요청 전송 중: /clova/chatroom/$chatRoomId/summary');
      var response = await http.get(
        Uri.parse("http://223.130.141.98:3000/clova/chatroom/$chatRoomId/summary"),
        headers: {"Content-Type": "application/json"},
      );

      print('API 응답 상태 코드: ${response.statusCode}');
      print('API 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        setState(() {
          msgs.add(Message(false, json["content"].toString().trimLeft()));
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
        body: jsonEncode({"messages": text, "roomId": chatRoomId}),
      );

      print('API 응답 상태 코드: ${response.statusCode}');
      print('API 응답 본문: ${response.body}');

      if (response.statusCode == 201) {
        var json = jsonDecode(response.body);
        print(json["content"].toString().trimLeft());
        setState(() {
          isTyping = false;
          msgs.add(Message(false, json["content"].toString().trimLeft()));
        });

        scrollController.animateTo(
          scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );

        print('응답 수신 완료: ${json["content"]}');
        if (msgs.length == 2) {
          //await _fetchChatRoomSummary();
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
        const SnackBar(content: Text("오류가 발생했습니다. 다시 시도해주세요!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  '자주 묻는 질문',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              FAQSection(),
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
                            ? Colors.grey.shade200
                            : const Color(0xFFE2EAD1),
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
                          padding: const EdgeInsets.fromLTRB(16.0, 10.0, 8.0, 7.0),
                          child: TextField(
                            controller: textEditingController,
                            textCapitalization: TextCapitalization.sentences,
                            onSubmitted: (value) => sendMsg(),
                            textInputAction: TextInputAction.send,
                            showCursor: true,
                            style: const TextStyle(fontSize: 13.0),
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
                        Icons.send,
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

class FAQSection extends StatelessWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FAQBubble(text: '제 나이에서 신청할 수 있는 대표 정책은 무엇이 있나요?'),
        FAQBubble(text: '우리 지역에서 신청할 수 있는 대표 정책은 무엇이 있나요?'),
        FAQBubble(text: '제 소득분위에서는 어떤 혜택이나 지원을 받을 수 있나요?'),
      ],
    );
  }
}

class FAQBubble extends StatelessWidget {
  final String text;

  const FAQBubble({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE9F4E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(color: Color(0xFF404040), fontSize: 14),
      ),
    );
  }
}
