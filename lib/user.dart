class User {
  final int id;
  final String email;
  final String username;
  final String kakaoId;
  final String kakaoAccessToken;
  final String kakaoRefreshToken;
  final List<Profile> profile;
  final List<ChatRoom> chatRooms;
  final List<RefreshToken> refreshTokens;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.kakaoId,
    required this.kakaoAccessToken,
    required this.kakaoRefreshToken,
    required this.profile,
    required this.chatRooms,
    required this.refreshTokens,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      kakaoId: json['kakaoId'],
      kakaoAccessToken: json['kakaoAccessToken'],
      kakaoRefreshToken: json['kakaoRefreshToken'],
      profile: (json['profile'] as List).map((i) => Profile.fromJson(i)).toList(),
      chatRooms: (json['chatRooms'] as List).map((i) => ChatRoom.fromJson(i)).toList(),
      refreshTokens: (json['refreshTokens'] as List).map((i) => RefreshToken.fromJson(i)).toList(),
    );
  }
}

class Profile {
  final int id;
  final String name;
  final int userId;
  final String region;
  final String gender;
  final String occupation;
  final int householdSize;
  final int householdIncome;
  final String targetFeature;

  Profile({
    required this.id,
    required this.name,
    required this.userId,
    required this.region,
    required this.gender,
    required this.occupation,
    required this.householdSize,
    required this.householdIncome,
    required this.targetFeature,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      userId: json['userId'],
      region: json['region'],
      gender: json['gender'],
      occupation: json['occupation'],
      householdSize: json['householdSize'],
      householdIncome: json['householdIncome'],
      targetFeature: json['targetFeature'],
    );
  }
}

class ChatRoom {
  final int id;
  final int userId;
  final String createdAt;
  final String updatedAt;

  ChatRoom({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class RefreshToken {
  final int id;
  final String token;
  final int userId;
  final String createdAt;
  final String updatedAt;

  RefreshToken({
    required this.id,
    required this.token,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RefreshToken.fromJson(Map<String, dynamic> json) {
    return RefreshToken(
      id: json['id'],
      token: json['token'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
