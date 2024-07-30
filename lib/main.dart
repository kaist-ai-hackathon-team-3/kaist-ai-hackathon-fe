import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() {
  KakaoSdk.init(
        nativeAppKey: '845483f619ce7edf43af42ce8215559b',
        //javaScriptAppKey: '${YOUR_JAVASCRIPT_APP_KEY}',
    );
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