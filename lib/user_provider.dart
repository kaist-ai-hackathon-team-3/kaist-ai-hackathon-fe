import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String _errorMessage = '';

  User? get user => _user;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserInfo() async {
    try {
      final response = await http.get(
        Uri.parse('http://223.130.141.98:3000/user/me'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _user = User.fromJson(json.decode(response.body));
        notifyListeners();
      } else {
        _errorMessage = 'Failed to load user info: ${response.statusCode} ${response.reasonPhrase}';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load user info: $e';
      notifyListeners();
    }
  }
}
