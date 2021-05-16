import 'package:chatter_app/Screens/login_screen.dart';
import 'package:chatter_app/Screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthHelper extends StatefulWidget {
  @override
  _AuthHelperState createState() => _AuthHelperState();
}

class _AuthHelperState extends State<AuthHelper> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginScreen(
        toggle: toggleView,
      );
    } else {
      return SignUpScreen(
        toggle: toggleView,
      );
    }
  }
}
