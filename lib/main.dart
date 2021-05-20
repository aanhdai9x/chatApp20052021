import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1504/CustomDatabase.dart';
import 'package:flutter_app_1504/login_page.dart';
var image_bg_login = AssetImage("assets/bg_login.jpg");
var image_bg_register = AssetImage("assets/bg_register.jpg");
var image_bg_mess = AssetImage("assets/bg_mess.png");
var image_bg_forgot_password = AssetImage("assets/bg_forgot_password.jpg");
var image_bg_choose_group_chat = AssetImage("assets/bg_choose_group_chat.jpg");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(image_bg_login, context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
