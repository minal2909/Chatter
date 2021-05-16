import 'package:flutter/material.dart';

//color palette
const kPrimaryColor = Color(0xff5c6bc0);
const kSecondaryColor = Color(0xffffca28);
const kLightPrimaryColor = Color(0xff9fa8da);

//Text Styles
const kBigTextStyle =
    TextStyle(color: kPrimaryColor, fontSize: 36, fontWeight: FontWeight.w600);
const kTitleTextStyle = TextStyle(
    fontSize: 26,
    color: kPrimaryColor,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5);

//TextField Decoration
const kEmailTextFieldDecoration = InputDecoration(
    focusColor: kPrimaryColor,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    labelText: "Email",
    labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20));

const kPasswordTextFieldDecoration = InputDecoration(
    focusColor: kPrimaryColor,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    labelText: "Passowrd",
    labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20));

const kUsernameTextFieldDecoration = InputDecoration(
    focusColor: kPrimaryColor,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    labelText: "Username",
    labelStyle: TextStyle(color: kPrimaryColor, fontSize: 20));

const kSearchTextFieldDecoration = InputDecoration(
    border: InputBorder.none,
    hintText: "Search Username",
    hintStyle: TextStyle(fontSize: 20, color: Colors.black26),
    prefixIcon: Icon(
      Icons.search,
    ),
    suffixStyle: TextStyle(color: kPrimaryColor));

//container BoxDecoration
final kSearchBarDecortion = BoxDecoration(
    color: Color(0xffe0e0e0), borderRadius: BorderRadius.circular(30));

final kDefaultPadding = 20.0;

String sender = "";
