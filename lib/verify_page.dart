import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1504/CustomDatabase.dart';

class VerifyPage extends StatefulWidget {
  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final auth = FirebaseAuth.instance;
  User user;
  final TextEditingController _otpController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    user = auth.currentUser;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Verify email'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: (){
                  sendOTP();
                },
                child: Text('Send an OTP to ${user.email}')
            ),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: "OTP",
              ),
            ),
            TextButton(
                onPressed: (){
                  verifyOTP();
                },
                child: Text("Verify OTP")
            ),
          ],
        ),

      ),
    );
  }

  void sendOTP() async{
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(receiverMail: user.email);
    if(res){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An OTP was sent!")));
    }
    else("We could not sent the OTP");

  }
  void verifyOTP()async{
    var res = EmailAuth.validate(receiverMail: user.email, userOTP: _otpController.text);
    if(res){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CustomData()));
    }
    else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong OTP!")));
  }



}

