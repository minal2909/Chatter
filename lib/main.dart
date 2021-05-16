import 'dart:async';

import 'package:chatter_app/Helper/authhelptet.dart';
import 'package:chatter_app/Helper/shared_pref.dart';
import 'package:chatter_app/Screens/chat_rooms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    //getLoggedInState();
    super.initState();
  }

  // getLoggedInState() async {
  //   await SharedPref.getLoggedInUserSharedPref().then((value) {
  //     if (mounted)
  //       setState(() {
  //         isUserLoggedIn = value;
  //       });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatter',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //home: isUserLoggedIn ? ChatRooms() : HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getTimer();
    super.initState();
  }

  getTimer() async {
    Timer(
      Duration(seconds: 1),
      () => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => AuthHelper()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(tag: "logo", child: Image.asset("images/logo.png")),
      ),
    );
  }
}
