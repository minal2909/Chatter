import 'package:chatter_app/Screens/chat_screen.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class ChatroomTile extends StatelessWidget {
  final String receiver;
  final String chatroomID;

  ChatroomTile(this.receiver, this.chatroomID);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChatScreen(chatroomID))),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: kPrimaryColor,
                ),
                child: Text(
                  "${receiver.substring(0, 1).toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Text(
                receiver,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
