import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  User? _user;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse('http://223.130.141.98:3000/user/me'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _user = User.fromJson(json.decode(response.body));
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load user info: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user info: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${_user!.id}'),
                Text('Email: ${_user!.email}'),
                Text('Username: ${_user!.username}'),
                ..._user!.profile.map((profile) => Text('Profile: ${profile.id}, ${profile.name}, ${profile.gender}, ${profile.occupation}')).toList(),
                ..._user!.chatRooms.map((chatRoom) => Text('Chat Room: ${chatRoom.id}, Created At: ${chatRoom.createdAt}')).toList(),
                ..._user!.refreshTokens.map((token) => Text('Token: ${token.token}, Created At: ${token.createdAt}')).toList(),
              ],
            )
          : Text(_errorMessage),
    );
  }
}
