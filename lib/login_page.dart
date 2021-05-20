import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1504/CustomDatabase.dart';
import 'package:flutter_app_1504/choose_group_chat.dart';
import 'package:flutter_app_1504/forgot_password.dart';
import 'package:flutter_app_1504/main.dart';
import 'package:flutter_app_1504/register_page.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //AuthBloc authBloc = new AuthBloc();
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image_bg_login,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text(
                    'Welcome back !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "GoblinOne",
                    ),
                  ),
                  Text(
                    'Login to continue using iMess',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontFamily: "GoblinOne"),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    obscureText: true,
                    controller: _passController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Container(
                        width: 50,
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue[200],
                            fontFamily: "GoblinOne",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    height: 40,
                    width: 150,
                    //width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        _signInWithEmailAndPassword(); // else Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Text(
                        "Login with",
                        style: TextStyle(
                          fontFamily: "GoblinOne",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 40),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/logo_instagram2.jpg"),
                          radius: 30,
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.black,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/logo_fb.jpg"),
                          radius: 30,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'New user? ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: Text(
                          'Sign up for a new account',
                          style: TextStyle(
                              fontFamily: "GoblinOne",
                              fontSize: 13,
                              color: Colors.blue[200]
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
      if (userCredential == null) {
        print('SignIn not success');
      } else {
        Fluttertoast.showToast(
            msg: "Login success !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChooseGroupChat()));
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return null;
    }
  }
}
