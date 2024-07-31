import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: userProvider.user != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ID: ${userProvider.user!.id}'),
                Text('Email: ${userProvider.user!.email}'),
                Text('Username: ${userProvider.user!.username}'),
                ...userProvider.user!.profile.map((profile) => Text('Profile: ${profile.id}, ${profile.name}, ${profile.gender}, ${profile.occupation}')).toList(),
                ...userProvider.user!.chatRooms.map((chatRoom) => Text('Chat Room: ${chatRoom.id}, Created At: ${chatRoom.createdAt}')).toList(),
                ...userProvider.user!.refreshTokens.map((token) => Text('Token: ${token.token}, Created At: ${token.createdAt}')).toList(),
              ],
            )
          : Text(userProvider.errorMessage),
    );
  }
}
