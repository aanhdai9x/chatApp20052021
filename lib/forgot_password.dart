import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1504/login_page.dart';
import 'package:flutter_app_1504/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image_bg_forgot_password,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
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
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  height: 40,
                  width: 250,
                  //width: double.infinity,
                  child: TextButton(
                    onPressed: (){
                      FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                      Fluttertoast.showToast(
                          msg: "Please check your email to reset your password !",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'RESET PASSWORD',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "GoblinOne",
                      ),
                    ),
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
