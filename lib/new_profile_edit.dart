import 'package:flutter/material.dart';

class NewInfoDetails extends StatefulWidget {
  const NewInfoDetails({super.key});

  @override
  State<NewInfoDetails> createState() => _NewInfoDetailsState();
}

class _NewInfoDetailsState extends State<NewInfoDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _householdSizeController = TextEditingController();
  final TextEditingController _householdIncomeController = TextEditingController();
  final TextEditingController _targetFeatureController = TextEditingController();

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
          '프로필 등록',
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
              _buildProfileField('나와의 관계', '*', _nameController, true, '예: 아버지'),
              _buildProfileField('이름', '*', _nameController, true, '예: 홍길동'),
              _buildProfileField('지역', '*', _regionController, true, '예: 대전광역시 유성구'),
              _buildProfileField('직업', '*', _occupationController, true, '예: 직장인'),
              _buildProfileField('가구원 수', '', _householdSizeController, false, '예: 4'),
              _buildProfileField('가구 소득', '', _householdIncomeController, false, '예: 5000만원'),
              _buildProfileField('기타 사항 자유롭게 기재', '', _targetFeatureController, false, '탈북민, 다문화가정, 한부모가정, 소상공인, 장애인, 노인 등'),
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
                    '등록',
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

  Widget _buildProfileField(String label, String required, TextEditingController controller, bool requiredField, String hintText) {
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
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14), // 가이드 텍스트 색상 회색
              filled: true,
              fillColor: Colors.grey[200], // 연한 회색 배경
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
