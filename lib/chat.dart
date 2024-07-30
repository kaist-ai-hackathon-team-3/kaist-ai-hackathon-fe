import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ai/message.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'home.dart'; // HomePage import 추가

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final List<Message> msgs = [];
  bool isTyping = false;
  String userName = "사용자"; // 기본 이름을 '사용자'로 설정

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserName() async {
    try {
      final response = await http.get(
        Uri.parse("http://223.130.141.98:3000/user/profile"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          userName = data["profile"][0]["name"];
        });
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch user name: ${e.toString()}")),
      );
    }
  }

  void sendMsg() async {
    String text = textEditingController.text;

    if (text.isEmpty) return;
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
      var response = await http.post(
        Uri.parse("http://223.130.141.98:3000/clova/chat"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "messages": text,
        }),
      );

      if (response.statusCode == 201) {
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
      } else {
        throw Exception('Failed to get response from API');
      }
    } catch (e) {
      setState(() {
        isTyping = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some error occurred, please try again!")),
      );
    }
  }

  // UI DESIGN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          NetworkImage("https://via.placeholder.com/44"),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        '$userName님의 정말 채팅',
                        style: const TextStyle(
                          color: Color(0xFF202325),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
