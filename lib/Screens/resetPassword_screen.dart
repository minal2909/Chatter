import 'package:chatter_app/Components/background.dart';
import 'package:chatter_app/Components/default_button.dart';
import 'package:chatter_app/Services/auth_methods.dart';
import 'package:chatter_app/Utilities/constants.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  AuthMethods authMethods = AuthMethods();

  sendLink() {
    if (formKey.currentState.validate()) {
      authMethods
          .resetPassword(emailTextEditingController.text)
          .then((value) => print(emailTextEditingController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Reset Password",
                style: kBigTextStyle,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: TextFormField(
                    controller: emailTextEditingController,
                    validator: (value) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                          ? null
                          : "Please provide a valid email";
                    },
                    decoration: kEmailTextFieldDecoration,
                  ),
                ),
              ),
              Text("Link will be sent through email, Please check your email"),
              DefaultButton(
                label: "Send Link",
                size: size,
                press: () {
                  sendLink();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
