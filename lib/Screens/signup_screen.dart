import 'package:chatter_app/Components/background.dart';
import 'package:chatter_app/Components/default_button.dart';
import 'package:chatter_app/Helper/shared_pref.dart';
import 'package:chatter_app/Screens/chat_rooms.dart';
import 'package:chatter_app/Services/auth_methods.dart';
import 'package:chatter_app/Services/database_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggle;

  SignUpScreen({this.toggle});
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  signUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextEditingController.text,
        "email": emailTextEditingController.text,
      };

      //saving username and email to shared preference
      SharedPref.saveUseremailSharedPref(emailTextEditingController.text);
      SharedPref.saveUsernameSharedPref(usernameTextEditingController.text);

      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        //print("$value");

        databaseMethods.uploadUserInfo(
            userInfoMap); //this will upload user info as soon as user get registred

        SharedPref.saveLoggedInUserSharedPref(
            true); //this will save the logged i user as soon as user get registred and upload userinfo

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ChatRooms();
        }));
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
                    child: Text("SIGN UP", style: kBigTextStyle),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: kDefaultPadding),
                          child: TextFormField(
                            validator: (value) {
                              return value.isEmpty || value.length < 4
                                  ? "Username should be atleast 4 characters long"
                                  : null;
                            },
                            controller: usernameTextEditingController,
                            decoration: kUsernameTextFieldDecoration,
                          ),
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
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
                  DefaultButton(
                    size: size,
                    label: "SIGN UP",
                    press: () {
                      signUp();
                    },
                  ),
                  GestureDetector(
                    onTap: () => widget.toggle(),
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: kDefaultPadding),
                      child: Text(
                        "Already have an account? Log in",
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
