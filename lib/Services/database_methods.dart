import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //this function will store/upload user info(name and email) to cloude firestore while user create its account
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  //this function will match the string with the firestore collection field and get the email by .get()
  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  //this function will match the string with the firestore collection field and get the username by .get()
  getUserByUseremail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  //this function will create chatroom which has defined document name.
  createChatRoom(String chatroomID, chatroomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomID) //defining doc name as chatroomID(sender_reciever)
        .set(chatroomMap) //set data as map(key-value)
        .catchError((e) {
      print(e.toString());
    });
  }

  //this function will add the message to chatroom's collection "chat" using chatroomID
  addMessages(String chatroomID, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomID)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  //this function will get the message from firestore collection
  getMessage(String chatroomID) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomID)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  //this function will get the all chatrooms from firestore collection
  getChatRooms(String username) async {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: username)
        .snapshots();
  }
}
