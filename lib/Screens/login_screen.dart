import 'package:chatter_app/Components/background.dart';
import 'package:chatter_app/Components/default_button.dart';
import 'package:chatter_app/Helper/shared_pref.dart';
import 'package:chatter_app/Screens/chat_rooms.dart';
import 'package:chatter_app/Screens/resetPassword_screen.dart';
import 'package:chatter_app/Services/auth_methods.dart';
import 'package:chatter_app/Services/database_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final Function toggle;

  LoginScreen({this.toggle});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  QuerySnapshot snapshot;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  signIn() {
    if (formkey.currentState.validate()) {
      //This will save user email to shared preference / saving the email offline
      SharedPref.saveUseremailSharedPref(emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      //this method will get user's email from cloud firestore
      databaseMethods
          .getUserByUseremail(emailTextEditingController.text)
          .then((value) {
        snapshot = value;
        SharedPref.saveUsernameSharedPref(snapshot.docs[0].data()["name"]);
      });

      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value != null) {
          SharedPref.saveLoggedInUserSharedPref(true);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ChatRooms();
          }));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding),
                    alignment: Alignment.centerLeft,
                    child: Text("LOGIN", style: kBigTextStyle),
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: TextFormField(
                              validator: (value) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Please provide a valid email";
                              },
                              controller: emailTextEditingController,
                              decoration: kEmailTextFieldDecoration),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: TextFormField(
                              validator: (value) {
                                return value.isEmpty || value.length < 6
                                    ? "Password should be atleast 6 characters long"
                                    : null;
                              },
                              controller: passwordTextEditingController,
                              obscureText: true,
                              decoration: kPasswordTextFieldDecoration),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen())),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: kDefaultPadding / 2, right: kDefaultPadding),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 17,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  DefaultButton(
                    size: size,
                    label: "LOGIN",
                    press: () {
                      signIn();
                    },
                  ),
                  GestureDetector(
                    onTap: () => widget.toggle(),
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: kDefaultPadding),
                      child: Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(
                            color: Colors.deepPurple[800],
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
