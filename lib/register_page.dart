import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1504/CustomDatabase.dart';
import 'package:flutter_app_1504/auth_bloc.dart';
import 'package:flutter_app_1504/login_page.dart';
import 'package:flutter_app_1504/main.dart';
import 'package:flutter_app_1504/verify_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthBloc authBloc = new AuthBloc();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.9),
                  BlendMode.dstATop,
                ),
                image: image_bg_register,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'Register now !',
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
                  SizedBox(height: 50),
                  StreamBuilder(
                      stream: authBloc.nameStream,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            errorText:
                                !snapshot.hasData ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 5),
                  StreamBuilder(
                      stream: authBloc.phoneStream,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            errorText:
                                !snapshot.hasData ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelText: 'Phone',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 5),
                  StreamBuilder(
                      stream: authBloc.emailStream,
                      builder: (context, snapshot) {
                        return TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            errorText:
                                !snapshot.hasData ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1),
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
                        );
                      }),
                  SizedBox(height: 5),
                  StreamBuilder(
                      stream: authBloc.passStream,
                      builder: (context, snapshot) {
                        return TextField(
                          obscureText: true,
                          controller: _passController,
                          decoration: InputDecoration(
                            errorText:
                                !snapshot.hasData ? snapshot.error : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    height: 40,
                    width: 150,
                    child: TextButton(
                        onPressed: () async {
                          var isValid = authBloc.isValid(
                              _nameController.text,
                              _emailController.text,
                              _passController.text,
                              _phoneController.text);
                          if (isValid) {
                            print("Valid infomation!");
                            EmailAuth.sessionName = "Test Session";
                            var res = await EmailAuth.sendOtp(
                                receiverMail: _emailController.text);
                            if (res) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("An OTP was sent!")));
                            } else
                              ("We could not sent the OTP");

                          // create user
                          // loading dialog
                          } else
                            print('Fail');
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "GoblinOne",
                          ),
                        )),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        "Signup with",
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
                          backgroundImage: AssetImage("assets/logo_gmail2.jpg"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an Account? ',
                        style: TextStyle(
                          fontSize: 12,
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
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          'Login now',
                          style: TextStyle(
                              fontFamily: "GoblinOne",
                              fontSize: 12,
                              color: Colors.blue[200]),
                        ),
                      )
                    ],
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          labelText: "OTP",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Container(
                            width: 50,
                            child: Icon(
                              Icons.verified_user_rounded,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var res = EmailAuth.validate(
                              receiverMail: _emailController.text,
                              userOTP: _otpController.text);
                          if (res) {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passController.text);
                            Fluttertoast.showToast(
                                msg: "Register success !",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          } else
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Wrong OTP!")));
                        },
                        child: Text(
                          "Verify OTP",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontFamily: "GoblinOne",
                          ),
                        ),
                      ),
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
}

//
// class User {
//   String name;
//   String phone;
//   String email;
//   String password;
//   User({this.name, this.phone, this.email, this.password});
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//         name: json['name'],
//         phone: json['phone'],
//         email: json['email'],
//         password: json['password']);
//   }
// }
