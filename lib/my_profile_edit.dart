import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyInfoDetails extends StatefulWidget {
  const MyInfoDetails({super.key});

  @override
  State<MyInfoDetails> createState() => _MyInfoDetailsState();
}

class _MyInfoDetailsState extends State<MyInfoDetails> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _familyMembersController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with default values or fetched data
    _ageController.text = '28';
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final response = await http.get(Uri.parse('http://223.130.141.98:3000/profile'));
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        setState(() {
          _nameController.text = data['name'] ?? '홍길동';
          _addressController.text = data['region'] ?? '예) 대전광역시 유성구';
          _familyMembersController.text = data['householdSize']?.toString() ?? '3명';
          _incomeController.text = data['householdIncome']?.toString() ?? '5000만원';
          _otherController.text = data['targetFeature'] ?? '예시: 탈북민, 다문화가정, 한부모가정, 노인가구, 소상공인, 장애인';
        });
      } else {
        print('Failed to load profile data');
      }
    } catch (e) {
      print('Error: $e');
    }
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
              _buildProfileField('나이', '*', _ageController, true),
              _buildProfileField('주소', '*', _addressController, true),
              _buildProfileField('가구원 수', '', _familyMembersController, false),
              _buildProfileField('소득분위 또는 월평균 소득', '', _incomeController, false),
              _buildProfileField('기타 사항 자유롭게 기재', '', _otherController, false),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: Color(0xFFA2D462),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '저장',
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
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
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

  void _saveProfile() {
    // Save profile details
    // Example: Save to database or call an API
    print("Profile Saved: ${_nameController.text}, ${_ageController.text}, ${_addressController.text}");
  }
}
