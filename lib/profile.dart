import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'common_layout.dart';
import 'my_profile_edit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserProvider에서 사용자 정보를 가져옴
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return CommonLayout(
      selectedIndex: 2,
      body: user != null ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Header
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.61, -0.79),
                end: Alignment(-0.61, 0.79),
                colors: [
                  Color(0xCCADEBB3).withOpacity(0.8), // 투명도 80%
                  Color.fromARGB(255, 224, 240, 189).withOpacity(0.8), // 투명도 80%
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
                    fontSize: 25,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                // Text for scraped policies can be uncommented and used if needed
                /*Text(
                  '스크랩한 정책 ${user.scrapedPolicies.length}개',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                  ),
                ),*/
                SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    // Navigate to MyInfoDetails for editing
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
                          fontWeight: FontWeight.w400,
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
          // Profile Details Section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: user.profile.map((profile) => _buildProfileTile(context, profile.name, profile.name /*relation으로 추가 필요*/)).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFA2D462), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                // Navigate to account linking page or functionality
              },
              child: Text(
                '연동계정 추가',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ) : Center(
        child: Text('사용자 정보를 불러오는 중입니다...'),
      ),
    );
  }

  Widget _buildProfileTile(BuildContext context, String name, String relation) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE9F4E9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x3FB3B3B3),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  relation,
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
        ],
      ),
    );
  }
}
