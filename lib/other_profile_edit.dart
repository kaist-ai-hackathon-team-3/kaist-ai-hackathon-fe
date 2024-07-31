import 'package:flutter/material.dart';
import 'mypage.dart'; // Profile 모델을 불러옵니다.
import 'user.dart';

class OtherInfoDetails extends StatefulWidget {
  final Profile profile;

  const OtherInfoDetails({Key? key, required this.profile}) : super(key: key);

  @override
  State<OtherInfoDetails> createState() => _OtherInfoDetailsState();
}

class _OtherInfoDetailsState extends State<OtherInfoDetails> {
  late TextEditingController _nameController;
  late TextEditingController _regionController;
  late TextEditingController _genderController;
  late TextEditingController _occupationController;
  late TextEditingController _householdSizeController;
  late TextEditingController _householdIncomeController;
  late TextEditingController _targetFeatureController;

  @override
  void initState() {
    super.initState();
    _initializeProfileData();
  }

  void _initializeProfileData() {
    final profile = widget.profile;
    _nameController = TextEditingController(text: profile.name);
    _regionController = TextEditingController(text: profile.region);
    _genderController = TextEditingController(text: profile.gender);
    _occupationController = TextEditingController(text: profile.occupation);
    _householdSizeController = TextEditingController(text: profile.householdSize.toString());
    _householdIncomeController = TextEditingController(text: profile.householdIncome.toString());
    _targetFeatureController = TextEditingController(text: profile.targetFeature);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _regionController.dispose();
    _genderController.dispose();
    _occupationController.dispose();
    _householdSizeController.dispose();
    _householdIncomeController.dispose();
    _targetFeatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '프로필 수정',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileField('이름', '*', _nameController, true),
              _buildProfileField('지역', '*', _regionController, true),
              _buildProfileField('성별', '*', _genderController, true),
              _buildProfileField('직업', '*', _occupationController, true),
              _buildProfileField('가구원 수', '', _householdSizeController, false),
              _buildProfileField('가구 소득', '', _householdIncomeController, false),
              _buildProfileField('기타 사항', '', _targetFeatureController, false),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile viewed')));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: Color(0xFFA2D462),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label, String required, TextEditingController controller, bool requiredField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (requiredField)
                Text(
                  required,
                  style: TextStyle(
                    color: Color(0xFFA2D462),
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            readOnly: true, 
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 2,
                  color: requiredField ? Color(0xFFA2D462) : Color(0xFFF0F2F6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
