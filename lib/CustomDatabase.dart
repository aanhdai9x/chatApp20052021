import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1504/main.dart';


class CustomData extends StatefulWidget {
  CustomData({this.app});
  final FirebaseApp app;

  @override
  _CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
  final movieController = TextEditingController();
  final referenceDatabase = FirebaseDatabase.instance;
  DatabaseReference _messageMap;
  User _user = FirebaseAuth.instance.currentUser;
  final movieName = "MovieTitle";

  @override
  void initState() {
    // TODO: implement initState
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _messageMap = database.reference().child("MessageMap");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text(
          _user.email,
          style: TextStyle(
            color: Colors.blue[400],
            fontFamily: "GoblinOne",
            fontSize: 15,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image_bg_mess,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: FirebaseAnimatedList(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 100),
                  query: _messageMap,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return Column(
                      crossAxisAlignment: snapshot.value["Email"] == _user.email
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: snapshot.value["Email"] == _user.email
                                ? Colors.blue[300]
                                : Colors.pink[300],
                            borderRadius: snapshot.value["Email"] == _user.email
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  )
                                : BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${snapshot.value["Email"]}: ${snapshot.value["Message"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "GoblinOne",
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.blue[300],
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: movieController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            labelText: "Input Message",
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(
                                Icons.input,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Map<String, String> messageMap = {
                            "Message": movieController.text,
                            "Email": _user.email,
                          };
                          ref
                              .child("MessageMap")
                              .push()
                              .set(messageMap)
                              .asStream();

                          movieController.clear();

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
