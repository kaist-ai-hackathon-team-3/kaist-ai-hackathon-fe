import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // 추가된 패키지

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
