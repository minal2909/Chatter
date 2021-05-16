import 'package:chatter_app/Screens/chat_screen.dart';
import 'package:chatter_app/Services/database_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class SearchTile extends StatefulWidget {
  final String userName;
  final String userEmail;

  SearchTile({this.userEmail, this.userName});

  @override
  _SearchTileState createState() => _SearchTileState();
}

class _SearchTileState extends State<SearchTile> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  createChatRoomAndStartConversation(String receiver) {
    if (receiver != sender) {
      String chatroomId = getChatroomID(receiver, sender);

      List<String> users = [receiver, sender];
      Map<String, dynamic> chatroomMap = {
        "users": users,
        "chatRoomID": chatroomId
      };

      databaseMethods.createChatRoom(chatroomId, chatroomMap);

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChatScreen(chatroomId);
      }));
    } else {
      print("you can not send message to your self");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.userEmail,
                )
              ],
            ),
            GestureDetector(
              onTap: () => createChatRoomAndStartConversation(widget.userName),
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  "Message",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

getChatroomID(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
