import 'package:chatter_app/Helper/authhelptet.dart';
import 'package:chatter_app/Services/auth_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("CHATTER", style: kTitleTextStyle),
          Image.asset(
            "images/icon.png",
            scale: 1.3,
          )
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthHelper()),
                  (route) => false);
            },
            child: Icon(
              Icons.logout,
              color: kPrimaryColor,
              size: 30,
            ),
          ),
        )
      ],
    );
  }
}
