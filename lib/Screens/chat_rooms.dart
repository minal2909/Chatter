import 'package:chatter_app/Components/chatroom_tile.dart';
import 'package:chatter_app/Components/custom_appbar.dart';
import 'package:chatter_app/Helper/shared_pref.dart';
import 'package:chatter_app/Screens/search_screens.dart';
import 'package:chatter_app/Services/database_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRooms extends StatefulWidget {
  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatRoomStream;

  Widget chatroomList() {
    return StreamBuilder<QuerySnapshot>(
        stream: chatRoomStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return ChatroomTile(
                        snapshot.data.docs[index]
                            .data()["chatRoomID"]
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(sender, ""),
                        snapshot.data.docs[index].data()["chatRoomID"]);
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    //saving username to sender(String) which is from constant.dart
    sender = await SharedPref.getUsernameSharedPref();
    databaseMethods.getChatRooms(sender).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: CustomAppbar()),
      body: chatroomList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
