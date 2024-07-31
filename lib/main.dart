import 'package:flutter/material.dart';
import 'kakaologin/firstloginUI.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter binding 초기화
  KakaoSdk.init(nativeAppKey: '845483f619ce7edf43af42ce8215559b'); // Kakao SDK 초기화
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}