import 'package:chatter_app/Components/message_bubble.dart';
import 'package:chatter_app/Components/custom_appbar.dart';
import 'package:chatter_app/Services/database_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatroomID;
  ChatScreen(this.chatroomID);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageTextEditingController = TextEditingController();
  Stream chatMessageStream;

  Widget chatMessageList() {
    return StreamBuilder<QuerySnapshot>(
        stream: chatMessageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? Container(
                  padding: EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return MessageBubble(
                            snapshot.data.docs[index].data()["message"],
                            snapshot.data.docs[index].data()["sender"] ==
                                sender);
                      }),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  sendMessage() {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageTextEditingController.text,
        "sender": sender,
        "time": DateTime.now().millisecondsSinceEpoch
      };

      databaseMethods.addMessages(widget.chatroomID, messageMap);
      messageTextEditingController.text =
          ""; //clear message from textfeild after sent
    }
  }

  @override
  void initState() {
    databaseMethods.getMessage(widget.chatroomID).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: CustomAppbar(),
      ),
      body: Stack(
        children: [
          chatMessageList(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              margin: EdgeInsets.only(right: 50),
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: kPrimaryColor, width: 2.0),
                ),
              ),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: messageTextEditingController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding / 2),
                    hintText: "Message...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
                    border: InputBorder.none),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(8),
              child: FloatingActionButton(
                backgroundColor: kPrimaryColor,
                onPressed: () {
                  sendMessage();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
