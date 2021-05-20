import 'package:flutter/material.dart';
import 'package:flutter_app_1504/CustomDatabase.dart';
import 'package:flutter_app_1504/main.dart';

class ChooseGroupChat extends StatefulWidget {
  const ChooseGroupChat({Key key}) : super(key: key);

  @override
  _ChooseGroupChatState createState() => _ChooseGroupChatState();
}

class _ChooseGroupChatState extends State<ChooseGroupChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image_bg_choose_group_chat,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHOOSE GROUP CHAT ',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "GoblinOne",
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  splashColor: Colors.black.withOpacity(0.5),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.red[800],
                            Colors.red[600],
                            Colors.red[400],
                            Colors.red[200],
                          ],
                        )
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage("assets/ic_car_green.png"),
                      ),
                      title: Text(
                        "Broadcast Group",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "GoblinOne",
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => CustomData()));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
