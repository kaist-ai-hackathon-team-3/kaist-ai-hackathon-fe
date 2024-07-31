import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user.dart'; // Ensure this imports Profile class
import 'user_provider.dart';
import 'common_layout.dart';
import 'my_profile_edit.dart';
import 'other_profile_edit.dart';  // Import the new screen
import 'new_profile_edit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    final screenWidth = MediaQuery.of(context).size.width;

    return CommonLayout(
      selectedIndex: 2,
      body: user != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Header
                  Container(
                    width: screenWidth,
                    height: 280,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.61, -0.79),
                        end: Alignment(-0.61, 0.79),
                        colors: [
                          Color(0xCCADEBB3).withOpacity(0.8),
                          Color.fromARGB(255, 224, 240, 189).withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F5FF),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('images/chat_profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          '${user.username} 님',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyInfoDetails()),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '프로필 수정',
                                style: TextStyle(
                                  color: Color(0xFF949497),
                                  fontSize: 16,
                                  fontFamily: 'Noto Sans KR',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.edit,
                                size: 15,
                                color: Color(0xFF949497),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile Settings Text
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 16.0, 13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          '프로필 설정',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '가족, 친구, 연인에게 맞는 정책을 알아보세요!',
                          style: TextStyle(
                            color: Color(0xFF686A8A),
                            fontSize: 14,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Profile Details Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: user.profile
                          .where((profile) => profile.name != user.username) // 조건 추가
                          .map((profile) => _buildProfileTile(context, profile))
                          .toList(),
                    ),
                  ),
                  // Add Profile Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFA2D462),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to the NewInfoDetails screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NewInfoDetails()),
                          );
                        },
                        child: Text(
                          '연동 프로필 추가',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text('사용자 정보를 불러오는 중입니다...'),
            ),
    );
  }

  Widget _buildProfileTile(BuildContext context, Profile profile) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color.fromARGB(204, 212, 245, 216).withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(62, 144, 144, 144),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF6F5FF),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('images/chat_profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  profile.name, // 이 부분은 실제 relation으로 교체해야 함
                  style: TextStyle(
                    color: Color(0xFF626262),
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // 쓰레기통 아이콘
          IconButton(
            icon: Icon(Icons.delete, color: Color.fromARGB(255, 56, 56, 56)),
            onPressed: () {
              // 프로필 삭제 기능
            },
          ),
          // 편집 아이콘
          IconButton(
            icon: Icon(Icons.edit, color: Color.fromARGB(255, 56, 56, 56)),
            onPressed: () {
              // 프로필 수정 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtherInfoDetails(profile: profile),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
